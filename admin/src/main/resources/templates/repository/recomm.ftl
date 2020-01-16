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
                                    <li class="breadcrumb-item"><a href="#">레포지토리 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">추천 아이템 관리</li>
                                </ol>
                            </nav>
                        </div>

                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#recommModal" data-seq="">콘텐츠 검색</button>
                        </div>
                    </div>
                </div>

                <hr>

                <div class="form-row mb-3">
                    <div class="col d-flex justify-content-start">
                        <button type="button" class="btn btn-light btn-checkdelete">선택삭제</button>
                    </div>

                </div>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="${sort!}">
                    <input type="hidden" id="order" name="order" value="${order!}">
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
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="r.seq" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>분류</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="r.app_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>제목</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="r.app_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="r.create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>업데이트</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="r.last_update" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>다운로드</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="downloadCnt" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>질문</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="qnaCnt" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>리뷰</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="review" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="recommList">
                        <#--<#if results??>-->
                            <#--<#assign resultsSize = results?size>-->
                            <#--<#if resultsSize &gt; 0>-->
                                <#--<#list results as row>-->
                                    <#--<tr>-->
                                        <#--<td scope="row">-->
                                            <#--<div class="form-check">-->
                                                <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.recommSeq}" aria-label="...">-->
                                            <#--</div>-->
                                        <#--</td>-->
                                        <#--<td style="cursor: pointer">${row.seq}</td>-->
                                        <#--<td style="cursor: pointer"">-->
                                        <#--<#if row.appType = 0>Process<#else><#if row.appType = 1>Task<#else><#if row.appType = 2>Event Item<#else>Connector</#if></#if></#if>-->
                                        <#--</td>-->
                                        <#--<td style="cursor: pointer">${row.appName}</td>-->
                                        <#--<td style="cursor: pointer">${row.createDatetime?string["yyyy-MM-dd"]}</td>-->
                                        <#--<td style="cursor: pointer"><#if row.lastUpdate??>${row.lastUpdate?string["yyyy-MM-dd"]}</#if></td>-->
                                        <#--<td style="cursor: pointer">${row.downloadCnt}</td>-->
                                        <#--<td style="cursor: pointer">${row.qnaCnt}</td>-->
                                        <#--<td style="cursor: pointer">${row.review}</td>-->
                                        <#--<td>-->
                                            <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                                                <#--<i class="icon-newpage"></i>-->
                                            <#--</button>-->
                                            <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                                                <#--<i class="icon-urlcopy"></i>-->
                                            <#--</button>-->
                                            <#--<button type="button" class="btn btn-danger btn-sm recommDelete" data-seq="${row.recommSeq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                                                <#--<i class="icon-delete"></i>-->
                                            <#--</button>-->
                                        <#--</td>-->
                                    <#--</tr>-->
                                <#--</#list>-->
                                <#--<#else>-->
                                <#--<tr>-->
                                    <#--<td colspan="10" align="center">등록된 추천 아이템이 없습니다.</td>-->
                                <#--</tr>-->
                            <#--</#if>-->
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

<div class="modal fade" id="recommModal" tabindex="-1" role="dialog" aria-labelledby="recommModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="recommModalCenterTitle">콘텐츠 검색</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0">
                <div id="contentMain" class="input-display">
                    <form id="recommSearchForm">
                        <input type="hidden" id="total-m" name="total-m" value="">
                        <input type="hidden" id="row-m" name="row-m" value="0">
                        <input type="hidden" id="order-m" name="order-m" value="1">
                        <input type="hidden" id="sort-m" name="sort-m" value="r.create_datetime">

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
                                    <option value="appName">제목</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchWord" name="searchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search" value="${RequestParameters.searchWord!}">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary d-flex align-items-center" type="submit" id="button-search">
                                            <i class="icon-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <form id="recommListForm">
                        <table class="table">
                            <colgroup>
                                <col width="30px">
                                <col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">
                                    <div class="form-check">
                                        <input class="form-check-input position-static" type="checkbox" id="recommAllChk" value="" aria-label="...">
                                    </div>
                                </th>
                                <th scope="col">
                                    <span>No</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="r.seq" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>타입</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="r.app_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>제목</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="r.app_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="r.create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>업데이트</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="r.last_update" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>다운로드</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="downloadCnt" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>질문</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="qnaCnt" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>리뷰</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting-m" data-sort="review" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </th>
                                <#--<th scope="col">-->
                                    <#--<span>Action</span>-->
                                <#--</th>-->
                            </tr>
                            </thead>
                            <tbody id="recommSearchList"></tbody>
                        </table>
                    </form>
                    <div id="page-selection" class="d-flex justify-content-center align-items-center"></div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
                <button type="button" class="btn btn-primary btn-save" id="btnSave">선택 완료</button>
            </div>
        </div>
    </div>
</div>

<#include "/layout/base_script.ftl">
<script src="/assets/plugins/bootpag/jquery.bootpag.min.js"></script>
<script src="/assets/js/page/repository/recommList.js"></script>
<!-- custom script 위치 -->
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}');
        $('[data-toggle="tooltip"]').tooltip();

        // 정렬 순서 변경 처리
        // $(".icon-sort-arrows-couple-pointing-up-and-down").on("click", function(){
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
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">