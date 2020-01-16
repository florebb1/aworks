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
                                    <li class="breadcrumb-item"><a href="#">CS 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">1:1문의 목록</li>
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
                            <col width="120px">
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
                                    <span>분류</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.qna_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
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
                        <tbody id="onetooneList">

                        </tbody>
                    </table>
                </form>

                <nav id="paging" class="d-flex justify-content-center">

                </nav>

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="onetooneModal" tabindex="-1" role="dialog" aria-labelledby="onetooneModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="onetooneModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="onetoone-modal-view"></div>
        </div>
    </div>
</div>

<table id="onetooneListByExeclTable" style="display:none;">
    <thead>
    <tr>
        <th scope="col">No</th>
        <th scope="col">분류</th>
        <th scope="col">제목</th>
        <th scope="col">작성자</th>
        <th scope="col">작성일</th>
        <th scope="col">답변</th>
    </tr>
    </thead>
    <tbody id="onetooneListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/cs/onetooneList.js"></script>
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

        $("#onetooneListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("1:1문의를 1개 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|"),"sort":$("#sort").val(),"order":$("#order").val() };
            $.ajax({
                url: "/cs/onetooneExeclDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var onetooneList = response.list;
                var html = '';
                for(var i=0;i<onetooneList.length;i++) {

                    var qnaType = onetooneList[i].qnaType;
                    if(qnaType == 0) qnaType = "REPOSITORY";
                    else qnaType = "INFO,CONTRACT";

                    var title = onetooneList[i].title;
                    if(title == null || title == "") title = "";

                    var userName = onetooneList[i].userName;
                    if(userName == null || userName == "") userName = "";

                    var createDatetime = getFormatDate(onetooneList[i].createDatetime);

                    var answerYn = onetooneList[i].answerYn;
                    var answerContent = onetooneList[i].answerContent;
                    if(answerContent == null || answerContent == "") answerContent = "";
                    if(answerYn != 1) answerContent = "답변대기중";

                    html =
                        '<tr>' +
                        '<td>'+(i+1)+'</td>'+
                        '<td>'+qnaType+'</td>'+
                        '<td>'+title+'</td>'+
                        '<td>'+userName+'</td>'+
                        '<td>'+createDatetime+'</td>'+
                        '<td>'+answerContent+'</td>'+
                        '</tr>';
                    $("#onetooneListByExeclBody").append(html);
                }

                var filename = "oneToOneList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('onetooneListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">