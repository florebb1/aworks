<#include "/layout/base.ftl">

<div class="content">

    <div class="container">
        <div class="row">
            <div class="col">
                <div class="breadcrumb-wrap mb-3">
                    <div class="form-row">
                        <div class="col d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">메인</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">라이선스 관리</li>

                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 라이선스 발급 <span id="totalCnt">${total}</span> 건</p>
                        </div>
                        <#--<div class="col-auto">-->
                            <#--<button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#userModal" data-seq="">사용자 등록</button>-->
                        <#--</div>-->
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="${sort!}">
                    <input type="hidden" id="order" name="order" value="${order!1}">
                    <div class="form-row mb-3">
                        <div class="col-3">
                            <div class="form-row">
                                <div class="col">
                                    <input type="text" id="datestart" name="startDate" class="form-control" style="background:#fff" placeholder="날짜선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                                </div>
                                <div class="col-auto">~</div>
                                <div class="col">
                                    <input type="text" id="dateend" name="endDate" class="form-control" style="background:#fff" placeholder="날짜선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="col-2">
                            <select class="custom-select" name="licenseType" id="licenseType">
                                <option value="">전체</option>
                                <option value="1">PC형</option>
                                <option value="2">Cloud형</option>
                                <option value="3">On-premise형</option>
                            </select>
                        </div>
                        <div class="col-1">
                            <select class="custom-select" name="contractStatus" id="contractStatus">
                                <option value="">전체</option>
                                <option value="1">대기</option>
                                <option value="2">사용</option>
                                <option value="3">종료</option>
                            </select>
                        </div>
                        <div class="col-1">
                            <select class="custom-select" name="licenseStatus" id="licenseStatus">
                                <option value="">전체</option>
                                <option value="0">사용가능</option>
                                <option value="1">관리자 사용불가</option>
                                <option value="2">계약기간 만료</option>
                                <option value="3">발급개수 부족</option>
                            </select>
                        </div>
                        <div class="col-1">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="">전체</option>
                                <option value="contractNumber">계약번호</option>
                            </select>
                        </div>
                        <div class="col-4">
                            <div class="input-group">
                                <input type="text" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search" value="${RequestParameters.searchWord!}">
                                <div class="input-group-append">
                                    <button class="btn btn-primary d-flex align-items-center" type="submit" id="button-search">
                                        <i class="icon-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <hr>

                <div class="form-row mb-3">
                    <div class="col d-flex justify-content-start">
                        <button type="button" class="btn btn-light btn-checkdelete">선택삭제</button>
                        <button type="button" class="btn btn-light ml-1 btn-exceldownload" onclick="excelDownload()">엑셀 다운로드</button>
                    </div>
                    <div class="col d-flex justify-content-end">
                        <div class="btn-group" role="group" aria-label="Basic example">
                            <button type="button" class="btn btn-primary btn-row" data-row="10">10개</button>
                            <button type="button" class="btn btn-light btn-row" data-row="20">20개</button>
                            <button type="button" class="btn btn-light btn-row" data-row="30">30개</button>
                        </div>
                    </div>
                </div>

                <form id="listForm">
                    <table class="table">
                        <colgroup>
                            <col width="40px">
                            <col width="100px">
                            <col width="140px">
                            <col width="120px">
                            <col width="110px">
                            <col>
                            <col>
                            <col>
                            <col>
                            <col width="100px">
                            <col width="120px">
                            <col width="100px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="form-check">
                                    <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>No</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="seq" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"  style="cursor:pointer"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>계약번호</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_number" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>라이선스종류</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="license_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>기간</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_start" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>

                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span style="line-height:140%;text-align:left;">UnAttended Bot<br>Count</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="count_unattended" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span style="line-height:140%;text-align:left;">Attended Bot<br>Count</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="count_attended" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span style="line-height:140%;text-align:left;">Studio<br>Count</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="count_studio" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span style="line-height:140%;text-align:left;">WorkCenter<br>Count</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="count_workcenter" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>계약상태</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_status" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>라이선스 상태</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="license_status" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <span>Action</span>
                            </th>
                            <#--<th scope="col">-->
                                <#--<span>상태</span>-->
                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                    <#--<i class="icon-caret-down status"></i>-->
                                <#--</button>-->
                            <#--</th>-->
                            <#--<th scope="col">-->
                                <#--<span>Action</span>-->
                            <#--</th>-->
                        </tr>
                        </thead>
                        <tbody id="licenseList">
                            <#--<#if total?number gt 0>-->
                                <#--<#list results as row>-->
                                <#--<tr >-->
                                    <#--<td scope="row">-->
                                        <#--<#if row.downloadCount &lt;= 0>-->
                                            <#--<div class="form-check">-->
                                                <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                                            <#--</div>-->
                                        <#--</#if>-->
                                    <#--</td>-->
                                    <#--<td style="cursor: pointer" onclick="licenseViewDetail((${row.seq})">${row.seq}</td>-->
                                    <#--<td style="cursor: pointer" onclick="licenseViewDetail(${row.seq})"><#if row.comName??>${row.comName}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="licenseViewDetail(${row.seq})"><#if row.createDatetime??>${row.createDatetime?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="licenseViewDetail(${row.seq})"><#if row.subscribeType = 0>yearly<#else>runtime</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="licenseViewDetail(${row.seq})"><#if row.startDate??>${row.startDate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="licenseViewDetail(${row.seq})"><#if row.endDate??>${row.endDate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--&lt;#&ndash;<td style="cursor: pointer" onclick="licenseViewDetail(${row.seq})">&ndash;&gt;-->
                                        <#--&lt;#&ndash;<#if row.status = 0>신청<#else>발급완료</#if>&ndash;&gt;-->
                                    <#--&lt;#&ndash;</td>&ndash;&gt;-->
                                    <#--<td>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                                            <#--<i class="icon-newpage"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                                            <#--<i class="icon-urlcopy"></i>-->
                                        <#--</button>-->
                                        <#--&lt;#&ndash;<#if row.downloadCount &lt;= 0>&ndash;&gt;-->
                                        <#--<button type="button" class="btn btn-info btn-sm licenseModify" data-seq="${row.seq}" title="수정">-->
                                            <#--<i class="icon-modify"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-danger btn-sm licenseDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                                            <#--<i class="icon-delete"></i>-->
                                        <#--</button>-->
                                        <#--&lt;#&ndash;</#if>&ndash;&gt;-->
                                    <#--</td>-->
                                <#--</tr>-->
                                <#--</#list>-->
                            <#--<#else>-->
                                <#--<tr>-->
                                    <#--<td colspan="9" align="center">발급된 라이선스가 없습니다.</td>-->
                                <#--</tr>-->
                            <#--</#if>-->
                        </tbody>
                    </table>
                </form>
                <#--<nav aria-label="Page navigation">-->
                    <#--<ul class="pagination d-flex justify-content-center">-->
                        <#--<@pagination.first />-->
                        <#--<@pagination.numbers />-->
                        <#--<@pagination.last />-->
                    <#--</ul>-->
                <#--</nav>-->
                <nav id="paging" class="d-flex justify-content-center">

                </nav>
            </div>
        </div>
    </div>
</div>

<table id="licenseListByExeclTable" style="display:none;">
    <thead>
        <#--<tr>-->
            <#--<th scope="col">No</th>-->
            <#--<th scope="col">계약번호</th>-->
            <#--<th scope="col">라이선스종류</th>-->
            <#--<th scope="col">기간</th>-->
            <#--<th scope="col">Unattended 수량</th>-->
            <#--<th scope="col">Attended 수량</th>-->
            <#--<th scope="col">Studio 수량</th>-->
            <#--<th scope="col">Workcenter 수량</th>-->
            <#--<th scope="col">상태</th>-->
        <#--</tr>-->
        <tr>
            <th scope="col">No</th>
            <th scope="col">계약번호</th>
            <th scope="col">회사명</th>
            <th scope="col">계약명</th>
            <th scope="col">시작일</th>
            <th scope="col">종료일</th>
            <th scope="col">계약담당자</th>
            <th scope="col">담당자 E-mail</th>
            <th scope="col">담당자 연락처</th>
            <th scope="col">계약상태</th>
            <th scope="col">ICT 계약담당자</th>
            <th scope="col">계약종류</th>
            <th scope="col">라이선스종류</th>
            <th scope="col">과금종류</th>
            <th scope="col">UnAttended 납품금액</th>
            <th scope="col">UnAttended List price</th>
            <th scope="col">UnAttended 수량</th>
            <th scope="col">Attended 납품금액</th>
            <th scope="col">Attended List price</th>
            <th scope="col">Attended 수량</th>
            <th scope="col">Studio 납품금액</th>
            <th scope="col">Studio List price</th>
            <th scope="col">Studio 수량</th>
            <th scope="col">Workcenter 납품금액</th>
            <th scope="col">Workcenter List price</th>
            <th scope="col">Workcenter 수량</th>
            <th scope="col">라이선스 상태</th>
            <th scope="col">등록일</th>
        </tr>
    </thead>
    <tbody id="licenseListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/license/licenseList.js"></script>
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}')
        $('[data-toggle="tooltip"]').tooltip()

        // 정렬 순서 변경 처리
        // $(".icon-caret-down").on("click", function(){
        //     var fullStringClassName = $(this).attr("class");
        //     var className = fullStringClassName.substring(45);
        //     $("#sort").val(className);
        //     $("#searchForm").submit();
        // });
    });

    function paging(pageValue) {
        if(window.location.search != "") {
            var query = window.location.search.replace("?", "");
            query = query.split("&");
            query.forEach(function (one, i) {
                console.log(one.indexOf("page="));
                if (one.indexOf("page=") > -1) {
                    query.splice(i, 1);
                }
            });
            query.push("page=" + pageValue);
            query = query.join("&");
            document.location.href = "?"+query;
        }else{
            document.location.href = "?page="+pageValue;
        }
    }

    function excelDownload(){

        $("#licenseListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("라이선스를 1개 이상 선택해야합니다.");
        } else {
            var datas = { checkSeq : chkValueArr.join("|"),"sort":$("#sort").val(),"order":$("#order").val() };
            $.ajax({
                url: "/license/execlDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                // console.log(response);
                // var licenseList = response.execlDownList;
                // var html = '';
                // for(var i=0;i<licenseList.length;i++) {
                //     html = '<tr>\
                //                 <td >계약번호</td>\
                //                 <td>라이선스종류</td>\
                //                 <td >기간</td>\
                //                 <td >Unattended 수량</td>\
                //                 <td >Attended 수량</td>\
                //                 <td >Studio 수량</td>\
                //                 <td >Workcenter 수량</td>\
                //                 <td >상태</td>\
                //             </tr>';
                //
                //
                //     $("#licenseListByExeclBody").append(html);
                // }
                var companyList = response.list;
                var html = '';
                for(var i=0;i<companyList.length;i++) {
                    // 수정
                    var startdate = moment(companyList[i].contractStart).format("YYYY-MM-DD");
                    var enddate = moment(companyList[i].contractEnd).format("YYYY-MM-DD");
                    var today = moment(new Date()).format("YYYY-MM-DD");

                    if(enddate != "" && enddate < today){
                        var status = "종료";
                        // $("#contractStatus").val(3)
                    }else if(startdate != "" && startdate > today){
                        var status = "대기";
                        // $("#contractStatus").val(1);
                    }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
                        // $("#contractStatus").val(2);
                        var status = "사용";
                    }else{
                        // $("#contractStatus").val(1);
                        var status = "대기";
                    }

                    if(companyList[i].contractType == 1){
                        var contractType = "Pilot";
                    }else if(companyList[i].contractType == 2){
                        var contractType = "PoC";
                    }else{
                        var contractType = "본사업";
                    }
                    if(companyList[i].licenseType == 1){
                        var licenseType = "PC형";
                    }else if(companyList[i].licenseType == 2){
                        var licenseType = "Cloud형";
                    }else{
                        var licenseType = "On-premise형";
                    }

                    if(companyList[i].subscribeType == 1){
                        var subscribeType = "Hour";
                    }else if(companyList[i].subscribeType == 2){
                        var subscribeType = "Month";
                    }else{
                        var subscribeType = "Annual";
                    }
                    var left1 = companyList[i].countUnattended - companyList[i].countUnAttendedUse;
                    var left2 = companyList[i].countAttended - companyList[i].countAttendedUse;
                    var left3 = companyList[i].countStudio - companyList[i].countStudioUse;
                    var left4 = companyList[i].countWorkcenter - companyList[i].countWorkcenterUse;
                    var errorMsg = "사용가능";



                    if(left1 == 0 && left2 == 0 && left3 == 0 && left4 == 0){
                        licenseUse = false
                        errorMsg = "발급개수 부족"
                    }
                    if(enddate != "" && enddate < today){
                        licenseUse = false
                        errorMsg = "계약기간 만료"
                    }
                    if(companyList[i].licenseStatus == 1 ) {

                        licenseUse = false
                        errorMsg = "관리자 사용불가 처리";
                    }else{

                    }
                    html = '<tr><td >'+(i+1)+'</td>\
                        <td >'+companyList[i].contractNumber+'</td>\
                        <td >'+companyList[i].comContract.company.comName+'</td>\
                        <td >'+companyList[i].comContract.contractName+'</td>\
                        <td >'+moment(companyList[i].contractStart).format("YYYY-MM-DD")+'</td>\
                        <td >'+moment(companyList[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                        <td >'+companyList[i].userName+'</td>\
                        <td >'+companyList[i].loginId+'</td>\
                        <td >'+companyList[i].userPhone+'</td>\
                        <td >'+status+'</td>\
                        <td >'+companyList[i].contractIctName+'</td>\
                        <td >'+contractType+'</td>\
                        <td >'+licenseType+'</td>\
                        <td >'+subscribeType+'</td>\
                        <td >'+(companyList[i].unattendedLicensePrice === null ? 0:companyList[i].unattendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].unattendedLicenseListPrice === null ? 0:companyList[i].unattendedLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countUnattended === null ? 0:companyList[i].countUnattended)+'</td>\
                        <td >'+(companyList[i].attendedLicensePrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].attendedLicenseListPrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].countAttended === null ? 0:companyList[i].countAttended)+'</td>\
                        <td >'+(companyList[i].studioLicensePrice === null ? 0:companyList[i].studioLicensePrice)+'</td>\
                        <td >'+(companyList[i].studioLicenseListPrice === null ? 0:companyList[i].studioLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countStudio === null ? 0:companyList[i].countStudio)+'</td>\
                        <td >'+(companyList[i].workcenterLicensePrice === null ? 0:companyList[i].workcenterLicensePrice)+'</td>\
                        <td >'+(companyList[i].workcenterLicenseListPrice === null ? 0:companyList[i].workcenterLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countWorkcenter === null ? 0:companyList[i].countWorkcenter)+'</td>\
                        <td>'+errorMsg+'</td>\
                        <td >'+moment(companyList[i].comContract.createDatetime).format("YYYY-MM-DD")+'</td></tr>';

                    $("#licenseListByExeclBody").append(html);
                }

                var filename = "licenseList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('licenseListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">