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
                                    <li class="breadcrumb-item active" aria-current="page">사용자 관리</li>

                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 사용자 <span id="totalCnt">${total}</span> 명</p>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-backdrop="static" data-target="#userModal" data-seq="">사용자 등록</button>
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
                                    <input type="text" id="datestart" name="startDate" style="background:#fff" class="form-control" placeholder="날짜선택" value="${RequestParameters.startDate!}" readonly autocomplete="off">
                                </div>
                                <div class="col-auto">~</div>
                                <div class="col">
                                    <input type="text" id="dateend" name="endDate" style="background:#fff" class="form-control" placeholder="날짜선택" value="${RequestParameters.endDate!}" readonly autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="col-2">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="">통합</option>
                                <option value="loginId">아이디</option>
                                <option value="name">이름</option>
                                <option value="phone">연락처</option>
                                <option value="comName">회사명</option>
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
                    <table class="table" id="userList">
                        <colgroup>
                            <col width="40px">
                            <col width="100px">
                            <col width="">
                            <col width="10%">
                            <col width="10%">
                            <col width="10%">
                            <col width="10%">
                            <col width="10%">
                            <col width="10%">
                            <col width="100px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <div class="form-check">
                                    <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>No</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="seq" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down" style="cursor:pointer"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>아이디</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="login_id" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down" style="cursor:pointer"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>이름</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="name" data-orderby="1" >
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down" style="cursor:pointer"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>연락처</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="phone" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down" style="cursor:pointer"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>회사명</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="com_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down" style="cursor:pointer"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>직함</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="position" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down" style="cursor:pointer"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>레벨</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="level" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="create_datetime" data-orderby="0">
                                        <i class="icon-caret-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="userBodyList">

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

<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="user-modal-view"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="userHistoryModal" tabindex="-1" role="dialog" aria-labelledby="userHistoryModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userHistoryModalCenterTitle">사용자 히스토리</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div class="modal-body pa-0">
                <div id="userHistoryContentMain" class="input-display">
                    <!-- tab start -->
                    <div class="form-row">
                        <div class="col-12">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="download-tab" data-toggle="tab" href="#download" role="tab" aria-controls="download" aria-selected="true">다운로드 히스토리</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link " id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">리뷰 히스토리</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab" aria-controls="qna" aria-selected="false">질문 히스토리</a>
                                </li>


                            </ul>
                            <input type="hidden" id="userSeq" name="userSeq" value="">
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="download" role="tabpanel" aria-labelledby="download-tab">
                                    <input type="hidden" id="dlTotal" name="dlTotal" value="">
                                    <input type="hidden" id="dlRow" name="dlRow" value="10">
                                    <input type="hidden" id="dlSort" name="dlSort" value="create_datetime">
                                    <input type="hidden" id="dlPage" name="dlPage" value="1">
                                    <input type="hidden" id="dlOrder" name="dlOrder" value="0">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">
                                                <span>No</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>콘텐츠 No</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down rvSeq"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>콘텐츠 제목</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down title"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>다운로드 일</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <#--<th scope="col">-->
                                            <#--<span>Action</span>-->
                                            <#--</th>-->
                                        </tr>
                                        </thead>
                                        <tbody id="downloadList"></tbody>
                                    </table>
                                    <div id="download-page-selection"></div>
                                </div>
                                <div class="tab-pane fade " id="review" role="tabpanel" aria-labelledby="review-tab">
                                    <input type="hidden" id="rvTotal" name="rvTotal" value="">
                                    <input type="hidden" id="rvRow" name="rvRow" value="10">
                                    <input type="hidden" id="rvSort" name="rvSort" value="create_datetime">
                                    <input type="hidden" id="rvPage" name="rvPage" value="1">
                                    <input type="hidden" id="rvOrder" name="rvOrder" value="0">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">
                                                <span>No</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>콘텐츠 No</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down rvSeq"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>콘텐츠 제목</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down title"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>등록일</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>리뷰 내용</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <#--<th scope="col">-->
                                                <#--<span>Action</span>-->
                                            <#--</th>-->
                                        </tr>
                                        </thead>
                                        <tbody id="reviewList"></tbody>
                                    </table>
                                    <div id="review-page-selection"></div>
                                </div>
                                <div class="tab-pane fade" id="qna" role="tabpanel" aria-labelledby="qna-tab">
                                    <input type="hidden" id="qnaTotal" name="qnaTotal" value="">
                                    <input type="hidden" id="qnaRow" name="qnaRow" value="10">
                                    <input type="hidden" id="qnaSort" name="qnaSort" value="create_datetime">
                                    <input type="hidden" id="qnaPage" name="qnaPage" value="1">
                                    <input type="hidden" id="qnaOrder" name="qnaOrder" value="0">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">
                                                <span>No</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>콘텐츠 No</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down rvSeq"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>콘텐츠 제목</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down title"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>등록일</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>질문</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <th scope="col">
                                                <span>내용</span>
                                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-2">-->
                                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                <#--</button>-->
                                            </th>
                                            <#--<th scope="col">-->
                                                <#--<span>Action</span>-->
                                            <#--</th>-->
                                        </tr>
                                        </thead>
                                        <tbody id="qnaList"></tbody>
                                    </table>
                                    <div id="qna-page-selection"></div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- tab end -->
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
            </div>
        </div>
    </div>
</div>

<table id="userListByExeclTable" style="display:none;">
    <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">아이디</th>
            <th scope="col">이름</th>
            <th scope="col">연락처</th>
            <th scope="col">회사명</th>
            <th scope="col">직함</th>
            <th scope="col">레벨</th>
            <th scope="col">등록일</th>
        </tr>
    </thead>
    <tbody id="userListByExeclBody"></tbody>
</table>


<#include "/layout/base_script.ftl">
<script src="/assets/plugins/bootpag/jquery.bootpag.min.js"></script>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.1.24.min.js"></script>
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/user/userList.js"></script>
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}');
        $('[data-toggle="tooltip"]').tooltip();

        // 정렬 순서 변경 처리
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

        $("#userListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("사용자를 1명 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|"),"sort":$("#sort").val(),"order":$("#order").val() };
            $.ajax({
                url: "/user/execlDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var userList = response.list;
                var html = '';
                for(var i=0;i<userList.length;i++) {
                    var name = userList[i].name;
                    if(name == null || name == "") name = "";
                    var phone = String(userList[i].phone);
                    if(phone == null || phone == "") phone = "";
                    var comName = userList[i].comName;
                    if(comName == null || comName == "") comName = "";
                    var position = userList[i].position;
                    if(position == null || position == "") position = "";
                    var createDatetime = getFormatDate(userList[i].createDatetime);
                    var level = userList[i].level;
                    if(level == 1) level_str = "User";
                    else if(level == 2) level_str = "Contract Admin User";
                    html =
                        '<tr>' +
                            '<td>'+(i+1)+'</td>'+
                            '<td>'+userList[i].loginId+'</td>'+
                            '<td>'+name+'</td>'+
                            '<td style="mso-number-format:'+"'\\@'"+';">'+phone+'</td>'+
                            '<td>'+comName+'</td>'+
                            '<td>'+position+'</td>'+
                            '<td>'+level_str+'</td>'+
                            '<td>'+createDatetime+'</td>'+
                        '</tr>';
                    $("#userListByExeclBody").append(html);
                }

                var filename = "userList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('userListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">