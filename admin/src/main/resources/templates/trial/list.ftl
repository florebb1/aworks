<#include "/layout/base.ftl">
<#import "../pagination.ftl" as pagination />
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
                                    <li class="breadcrumb-item active" aria-current="page">Trial 관리</li>
                                    <#--<li class="breadcrumb-item active" aria-current="page">Trial 목록</li>-->
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 Trial <span id="totalCnt">${total}</span> 개</p>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="seq">
                    <input type="hidden" id="order" name="order" value="${order!}">
                    <div class="form-row mb-3">
                        <div class="col-4">
                            <div class="form-row">
                            <div class="col">
                                <input type="text" id="datestart" name="startDate" style="background:#fff" class="form-control" placeholder="날짜선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                            </div>
                            <div class="col-auto">~</div>
                            <div class="col">
                                <input type="text" id="dateend" name="endDate" style="background:#fff" class="form-control" placeholder="날짜선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                            </div>
                        </div>
                        </div>
                        <div class="col-2">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="">통합</option>
                                <option value="name">이름</option>
                                <option value="company">회사명</option>
                                <option value="email">이메일</option>
                                <option value="phone">연락처</option>
                                <option value="position">직급</option>
                            </select>
                        </div>
                        <div class="col-6">
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
                        <#--<button type="button" class="btn btn-light btn-checkdelete">선택삭제</button>-->
                        <button type="button" class="btn btn-light  btn-exceldownload" onclick="excelDownload(0)">선택 엑셀 다운로드</button>
                        <button type="button" class="btn btn-light  btn-exceldownload ml-1" onclick="excelDownload(1)">전체 엑셀 다운로드</button>
                        <button type="button" class="btn btn-light btn-licenseDown ml-1">라이선스키 다운로드</button>
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
                            <col width="110px">
                            <col width="">
                            <col width="110px">
                            <col width="140px">
                            <col width="110px">
                            <col width="110px">
                            <#--<col width="110px">-->
                            <#--<col width="100px">-->
                            <#--<col width="110px">-->
                            <col width="180px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <div class="form-check">
                                    <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>No</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tu.seq" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>이름</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tu.name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>이메일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tu.email" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>연락처</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tu.phone" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>회사명</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tu.company" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>직급</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tu.position" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>시작일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tl.start_date" data-orderby="0">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>종료일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tl.end_date" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>

                            <th scope="col" style="vertical-align:middle;">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="trialList">
                            <#--<#if total?number gt 0>-->
                                <#--<#list results as row>-->
                                <#--<tr>-->
                                    <#--<td scope="row">-->
                                        <#--<div class="form-check">-->
                                            <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                                        <#--</div>-->
                                    <#--</td>-->
                                    <#--<td>${row.seq}</td>-->
                                    <#--<td><#if row.email??>${row.email}</#if></td>-->
                                    <#--<td><#if row.phone??>${row.phone}</#if></td>-->
                                    <#--<td><#if row.company??>${row.company}</#if></td>-->
                                    <#--<td><#if row.position??>${row.position}</#if></td>-->
                                    <#--<td><#if row.startDate??>${row.startDate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td><#if row.endDate??>${row.endDate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td><#if row.extension?? && row.extension = 0>-<#else>연장</#if></td>-->
                                    <#--<td><#if row.status?? && row.status = 0>비활성화<#else>활성화</#if></td>-->
                                    <#--<td><#if row.macAddress??>${row.macAddress}</#if></td>-->
                                <#--</tr>-->
                                <#--</#list>-->
                            <#--<#else>-->
                                <#--<tr>-->
                                    <#--<td colspan="10" align="center">등록된 Trial이 없습니다.</td>-->
                                <#--</tr>-->
                            <#--</#if>-->
                        </tbody>
                    </table>
                </form>
                <nav id="paging" class="d-flex justify-content-center">

                </nav>
            </div>
        </div>
    </div>
</div>

<table id="trialListByExeclTable" style="display:none;">
    <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">이름</th>
            <th scope="col">이메일</th>
            <th scope="col">연락처</th>
            <th scope="col">회사명</th>
            <th scope="col">직급</th>
            <th scope="col">시작일</th>
            <th scope="col">종료일</th>
            <#--<th scope="col">LicenseKey</th>-->
        </tr>
    </thead>
    <tbody id="trialListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/trial/trialList.js"></script>
<script type="text/javascript" src="/assets/js/fileSaver.min.js"></script>
<!-- custom script 위치 -->
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
        $(".btn-licenseDown").click(function(){
            if(confirm("라이선스를 발급하시겠습니까?")){
                $.ajax({
                    url: "/trial/trial_tmp",
                    type: 'GET',
                    dataType: 'JSON',
                    success: function (response) {
                        console.log(response);
                        if(response.result){

                            var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license.license");
                            // location.reload();
                            setTimeout(function () {
                                location.reload();
                            }, 500);

                        }else{
                            if(response.msg == "duple"){
                                alert("이미 등록된 mac address입니다.");
                                return false;
                            }else{
                                if(response.errorCode == "-1"){
                                    alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                    return false;
                                }else{
                                    alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                                }
                            }

                        }
                    }
                });
            }
        })
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

    function excelDownload(type){

        $("#trialListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(type == 0){ // 선택
            if(chkValueArr <= 0) {
                alert("Trial을 1개 이상 선택해야합니다.");
                return false;
            }
            var url = "/trial/execlDownList";
        }else{
            alert("전체 다운로드시 데이터양에 따라 다소 시간이 소요될수 있습니다.");
            var url = "/trial/execlDownListAll";
        }

        var datas = { chkValueArr : chkValueArr.join("|") };
        $.ajax({
            url: url,
            type: 'POST',
            dataType: 'JSON',
            data: datas
        }).done(function (response) {
            console.log(response);
            var trialList = response.execlDownList;
            var html = '';
            for(var i=0;i<trialList.length;i++) {
                var name = trialList[i].name;
                if(name == null || name == "") name = "";

                var email = trialList[i].email;
                if(email == null || email == "") email = "";

                var phone = trialList[i].phone;
                if(phone == null || phone == "") phone = "";

                var company = trialList[i].company;
                if(company == null || company == "") company = "";

                var position = trialList[i].position;
                if(position == null || position == "") position = "";

                var startDate = getFormatDate(trialList[i].startDate);

                var endDate = getFormatDate(trialList[i].endDate);

                var extension = trialList[i].extension;
                if(extension == 0) extension = "";
                else extension = "연장";

                var status = trialList[i].status;
                if(status == 0) status = "비활성화";
                else status = "활성화";



                html =
                    '<tr>' +
                        '<td>'+(i+1)+'</td>'+
                        '<td>'+name+'</td>'+
                        '<td>'+email+'</td>'+
                        '<td>'+phone+'</td>'+
                        '<td>'+company+'</td>'+
                        '<td>'+position+'</td>'+
                        '<td>'+startDate+'</td>'+
                        '<td>'+endDate+'</td>'+
                        // '<td>'+trialList[i].macAddress+'</td>'+
                    '</tr>';
                $("#trialListByExeclBody").append(html);
            }

            var filename = "trialList.xlsx";
            /* create new workbook */
            var workbook = XLSX.utils.book_new();

            /* convert table 'table1' to worksheet named "Sheet1" */
            var ws1 = XLSX.utils.table_to_sheet(document.getElementById('trialListByExeclTable'));
            XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

            XLSX.writeFile(workbook, filename);
        });
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">