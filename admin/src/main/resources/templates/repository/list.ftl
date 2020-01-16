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
                                    <li class="breadcrumb-item active">레포지토리 관리</li>
                                    <#--<li class="breadcrumb-item active" aria-current="page">레포지토리 목록</li>-->
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 레포지토리 <span id="totalCnt">${total}</span>개</p>
                        </div>
                    <div class="col-auto">
                        <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#repositoryModal" data-seq="">레포지토리 등록</button>
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
                                <option value="appName">제목</option>
                                <option value="description">개요</option>
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
                        <#--<button type="button" class="btn btn-light btn-activation">활성화</button>-->
                        <#--<button type="button" class="btn btn-light ml-1 btn-deactivation">비활성화</button>-->
                        <button type="button" class="btn btn-light ml-1 btn-checkdelete">선택삭제</button>
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
                            <col width="10%">
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
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>타입</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="app_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>제목</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="app_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>업데이트</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="last_update" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>다운로드</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="downloadCnt" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>질문</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="qnaCnt" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>리뷰</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="review" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>노출여부</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="status" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="repositoryList">
                        <#--<#if results??>-->
                            <#--<#list results as row>-->
                                <#--<tr>-->
                                    <#--<td scope="row">-->
                                        <#--<div class="form-check">-->
                                            <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                                        <#--</div>-->
                                    <#--</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">${row.seq}</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">-->
                                        <#--<#if row.appType = 0>Process<#else><#if row.appType = 1>Task<#else><#if row.appType = 2>Event Item<#else>Connector</#if></#if></#if>-->
                                    <#--</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">${row.appName}</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">${row.createDatetime?string["yyyy-MM-dd"]}</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})"><#if row.lastUpdate??>${row.lastUpdate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">${row.downloadCnt}</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">${row.qnaCnt}</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">${row.review}</td>-->
                                    <#--<td style="cursor: pointer" onclick="repositoryViewDetail(${row.seq})">-->
                                        <#--<#if row.status?? && row.status = 0>활성화<#else>비활성화</#if>-->
                                    <#--</td>-->
                                    <#--<td>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                                            <#--<i class="icon-newpage"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                                            <#--<i class="icon-urlcopy"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#repositoryModal" data-seq="${row.seq}" title="수정">-->
                                            <#--<i class="icon-modify"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm activation" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="활성화">-->
                                            <#--<i class="icon-urlcopy"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm deactivation" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="비활성화">-->
                                            <#--<i class="icon-urlcopy"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-danger btn-sm repositoryDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                                            <#--<i class="icon-delete"></i>-->
                                        <#--</button>-->
                                    <#--</td>-->
                                <#--</tr>-->
                            <#--</#list>-->
                        <#--<#else>-->
                            <#--<td colspan="10" align="center">등록된 레포지토리가 없습니다.</td>-->
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

<div class="modal fade" id="repositoryModal" tabindex="-1" role="dialog" aria-labelledby="repositoryModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="repositoryModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="repository-modal-view"></div>
        </div>
    </div>
</div>

<table id="repositoryListByExeclTable" style="display:none;">
    <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">타입</th>
            <th scope="col">제목</th>
            <th scope="col">동록일</th>
            <th scope="col">업데이트</th>
            <th scope="col">다운로드</th>
            <th scope="col">질문</th>
            <th scope="col">리뷰</th>
            <th scope="col">노출여부</th>
        </tr>
    </thead>
    <tbody id="repositoryListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/page/repository/repositoryList.js"></script>
<!-- custom script 위치 -->
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}');
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

        $("#repositoryListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("레포지토리를 1개 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|") };
            $.ajax({
                url: "/repository/execlDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var repositoryList = response.list;
                var html = '';
                for(var i=0;i<repositoryList.length;i++) {
                    var appType = repositoryList[i].appType;
                    if(appType == 0) appType = "Process";
                    else if(appType == 1) appType = "Task";
                    else if(appType == 2) appType = "Event Item";
                    else appType= "Connector";
                    var appName = repositoryList[i].appName;
                    if(appName == null || appName == "") appName = "";
                    var createDatetime = getFormatDate(repositoryList[i].createDatetime);
                    var lastUpdate = repositoryList[i].lastUpdate;
                    if(lastUpdate == null || lastUpdate == "") lastUpdate = "";
                    else lastUpdate = getFormatDate(repositoryList[i].lastUpdate);
                    var downloadCnt = String(repositoryList[i].downloadCnt);
                    if(downloadCnt == null || downloadCnt == "") downloadCnt = "0";
                    var qnaCnt = repositoryList[i].qnaCnt;
                    if(qnaCnt == null || qnaCnt == "") qnaCnt = "0";
                    var review = repositoryList[i].review;
                    if(review == null || review == "") review = "0";
                    var status = repositoryList[i].status;
                    if(status == 0) status = "노출";
                    else if(status == 1) status = "비노출";
                    html =
                        '<tr>' +
                            '<td>'+repositoryList[i].seq+'</td>'+
                            '<td>'+appType+'</td>'+
                            '<td>'+appName+'</td>'+
                            '<td>'+createDatetime+'</td>'+
                            '<td>'+lastUpdate+'</td>'+
                            '<td>'+downloadCnt+'</td>'+
                            '<td>'+qnaCnt+'</td>'+
                            '<td>'+review+'</td>'+
                            '<td>'+status+'</td>'+
                        '</tr>';
                    $("#repositoryListByExeclBody").append(html);
                }

                var filename = "repository.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('repositoryListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">
