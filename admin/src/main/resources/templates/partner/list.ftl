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
                                    <li class="breadcrumb-item active" aria-current="page">파트너 관리</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체파트너사 <span id="totalCnt">${total}</span>명</p>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#partnerModal" data-seq="">파트너 등록</button>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="${sort!}">
                    <input type="hidden" id="order" name="order" value="${order!}">

                    <div class="form-row mb-3">

                        <div class="col-4">
                            <div class="form-row">
                                <div class="col">
                                    <input type="text" id="datestart" name="startDate" class="form-control" placeholder="날짜선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                                </div>
                                <div class="col-auto">~</div>
                                <div class="col">
                                    <input type="text" id="dateend" name="endDate" class="form-control" placeholder="날짜선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="col-2">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="">통합</option>
                                <option value="name">회사명</option>
                                <option value="address">주소</option>
                                <option value="tel">연락처</option>
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
                        <button type="button" class="btn btn-light btn-checkdelete">선택삭제</button>
                        <button type="button" class="btn btn-light ml-1 btn-exceldownload" onclick="excelDownload()">선택 엑셀 다운로드</button>
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
                            <col width="180px">
                            <col width="180px">
                            <col width="">
                            <col width="140px">
                            <col width="140px">
                            <col width="100px">
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
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="seq" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>회사명</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>대표전화</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="tel" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>주소</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="address" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>사업자번호</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="business_number" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </div>
                            </th>

                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="partnerList">

                        <#--<#if total?number gt 0>-->
                            <#--<#list results as row>-->
                            <#--<tr >-->
                                <#--<td scope="row">-->
                                    <#--<div class="form-check">-->
                                        <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                                    <#--</div>-->
                                <#--</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})">${row.seq!}</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})">${row.logo!}</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})">${row.name!}</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})">${row.tel!}</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})">${row.address!}</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})">${row.businessNumber!}</td>-->
                                <#--<td onclick="partnerViewDetail(${row.seq})"><#if row.createDatetime??>${row.createDatetime?string["yyyy-MM-dd"]}</#if></td>-->
                                <#--<td>-->
                                    <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                                        <#--<i class="icon-newpage"></i>-->
                                    <#--</button>-->
                                    <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                                        <#--<i class="icon-urlcopy"></i>-->
                                    <#--</button>-->
                                    <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#partnerModal" data-seq="${row.seq}" title="수정">-->
                                        <#--<i class="icon-modify"></i>-->
                                    <#--</button>-->
                                    <#--<button type="button" class="btn btn-danger btn-sm partnerDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                                        <#--<i class="icon-delete"></i>-->
                                    <#--</button>-->
                                <#--</td>-->
                            <#--</tr>-->
                            <#--</#list>-->
                        <#--<#else>-->
                            <#--<tr>-->
                                <#--<td colspan="10" align="center">파트너사가 없습니다.</td>-->
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

<div class="modal fade" id="partnerModal" tabindex="-1" role="dialog" aria-labelledby="partnerModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="partnerModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="partner-modal-view"></div>
        </div>
    </div>
</div>

<table id="partnerListByExeclTable" style="display:none;">
    <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">회사명</th>
            <th scope="col">대표전화</th>
            <th scope="col">주소</th>
            <th scope="col">사업자번호</th>
            <th scope="col">등록일</th>
        </tr>
    </thead>
    <tbody id="partnerListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/partner/partnerList.js"></script>
<!-- custom script 위치 -->
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}')
        $('[data-toggle="tooltip"]').tooltip()
    })


    function excelDownload(){

        $("#partnerListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("파트너사를 1개 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|") };
            $.ajax({
                url: "/partner/execlDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var partnerList = response.list;
                var html = '';
                for(var i=0;i<partnerList.length;i++) {
                    var name = partnerList[i].name;
                    if(name == null || name == "") name = "";

                    var tel = partnerList[i].tel;
                    if(tel == null || tel == "") tel = "";

                    var address = partnerList[i].address;
                    if(address == null || address == "") address = "";

                    var businessNumber = partnerList[i].businessNumber;
                    if(businessNumber == null || businessNumber == "") businessNumber = "";

                    var createDatetime = getFormatDate(partnerList[i].createDatetime);

                    html =
                        '<tr>' +
                            '<td>'+partnerList[i].seq+'</td>'+
                            '<td>'+name+'</td>'+
                            '<td>'+tel+'</td>'+
                            '<td>'+address+'</td>'+
                            '<td>'+businessNumber+'</td>'+
                            '<td>'+createDatetime+'</td>'+
                        '</tr>';
                    $("#partnerListByExeclBody").append(html);
                }

                var filename = "partnerList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('partnerListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">