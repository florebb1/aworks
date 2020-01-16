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
                                    <li class="breadcrumb-item"><a href="#">CS 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">버그신고 목록</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 글 <span id="totalCnt">${total}</span>개</p>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="bo.create_datetime">
                    <input type="hidden" id="order" name="order" value="1">
                    <div class="form-row mb-3">

                        <div class="col-4">
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
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="">통합</option>
                                <option value="title">제목</option>
                                <option value="answerContent">답변</option>
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
                            <col width="">
                            <col width="110px">
                            <col width="110px">
                            <col width="110px">
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
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.seq" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>제목</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.title" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>작성자</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="userName" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>작성일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>답변</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.answer_content" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="bugList">

                        <#--<#if total?number gt 0>-->
                        <#--<#list results as row>-->
                        <#--<tr >-->
                        <#--<td scope="row">-->
                        <#--<div class="form-check">-->
                        <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                        <#--</div>-->
                        <#--</td>-->
                        <#--<td onclick="onetooneViewDetail(${row.seq})" style="cursor:pointer;">${row.seq}</td>-->
                        <#--<td onclick="onetooneViewDetail(${row.seq})" style="cursor:pointer;">${row.title}</td>-->
                        <#--<td onclick="onetooneViewDetail(${row.seq})" style="cursor:pointer;">${row.userName!}</td>-->
                        <#--<td onclick="onetooneViewDetail(${row.seq})" style="cursor:pointer;">${row.createDatetime?string["yyyy-MM-dd"]}</td>-->
                        <#--<td onclick="onetooneViewDetail(${row.seq})" style="cursor:pointer;"><#if row.answerYn = 1>${row.answerContent!}<#else>답변대기중</#if></td>-->
                        <#--<td>-->
                        <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                        <#--<i class="icon-newpage"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                        <#--<i class="icon-urlcopy"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#bugModal" data-seq="${row.seq}" title="수정">-->
                        <#--<i class="icon-modify"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-danger btn-sm bugDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                        <#--<i class="icon-delete"></i>-->
                        <#--</button>-->
                        <#--</td>-->
                        <#--</tr>-->
                        <#--</#list>-->
                        <#--<#else>-->
                        <#--<tr>-->
                        <#--<td colspan="7" align="center">버그신고 내역이 없습니다.</td>-->
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

<div class="modal fade" id="bugModal" tabindex="-1" role="dialog" aria-labelledby="bugModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="bugModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="bug-modal-view"></div>
        </div>
    </div>
</div>

<table id="bugListByExeclTable" style="display:none;">
    <thead>
    <tr>
        <th scope="col">No</th>
        <th scope="col">제목</th>
        <th scope="col">작성자</th>
        <th scope="col">작성일</th>
        <th scope="col">답변</th>
    </tr>
    </thead>
    <tbody id="bugListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/cs/bugList.js"></script>
<!-- custom script 위치 -->
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}')
        $('[data-toggle="tooltip"]').tooltip();

        // 정렬 순서 변경 처리
        // $(".icon-caret-down").on("click", function(){
        //     var fullStringClassName = $(this).attr("class");
        //     var className = fullStringClassName.substring(45);
        //     $("#sort").val(className);
        //     $("#searchForm").submit();
        // });
    });


    function excelDownload(){

        $("#bugListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("버그신고를 1개 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|") };
            $.ajax({
                url: "/cs/bugExeclDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var bugList = response.list;
                var html = '';
                for(var i=0;i<bugList.length;i++) {

                    var title = bugList[i].title;
                    if(title == null || title == "") title = "";

                    var userName = bugList[i].userName;
                    if(userName == null || userName == "") userName = "";

                    var createDatetime = getFormatDate(bugList[i].createDatetime);

                    var answerYn = bugList[i].answerYn;
                    var answerContent = bugList[i].answerContent;
                    if(answerContent == null || answerContent == "") answerContent = "";
                    if(answerYn != 1) answerContent = "답변대기중";

                    html =
                        '<tr>' +
                        '<td>'+bugList[i].seq+'</td>'+
                        '<td>'+title+'</td>'+
                        '<td>'+userName+'</td>'+
                        '<td>'+createDatetime+'</td>'+
                        '<td>'+answerContent+'</td>'+
                        '</tr>';
                    $("#bugListByExeclBody").append(html);
                }

                var filename = "bugList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('bugListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">