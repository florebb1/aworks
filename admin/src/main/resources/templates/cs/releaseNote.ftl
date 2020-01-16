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
                                    <li class="breadcrumb-item active" aria-current="page">뉴스룸 목록</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 글 <span id="totalCnt">${total!}</span> 개</p>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#releaseNoteModal" data-seq="">ReleaseNote 등록</button>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="${sort!}">
                    <input type="hidden" id="order" name="order" value="${order!}">
                    <div class="form-row mb-3">


                        <div class="col-2">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="title">제목</option>

                            </select>
                        </div>

                        <div class="col-10">
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
                        <#--<button type="button" class="btn btn-light ml-1 btn-exceldownload" onclick="excelDownload()">선택 엑셀 다운로드</button>-->
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
                            <col width="50px">
                            <col width="*">
                            <col width="120px">
                            <col width="180px">
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
                                    <span>제목</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="title" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>종류</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="writer" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="create_datetime" data-orderby="0">
                                        <i class="icon-caret-down"></i>
                                    </button>
                                </div>
                            </th>

                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="noticeList">

                        </tbody>
                    </table>
                </form>

                <nav id="paging" class="d-flex justify-content-center">

                </nav>

            </div>
        </div>
    </div>

</div>
<div class="modal fade" id="releaseNoteModal" tabindex="-1" role="dialog" aria-labelledby="releaseNoteModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="releaseNoteModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div class="modal-body pa-0">
                <form id="writeForm" action="/cs/release_note" method="post">
                    <input type="hidden" name="seq" id="seq" >
                    <input type="hidden" name="content" id="content" value="">
                    <div id="contentMain" class="input-display p-5">
                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">분 류</div>
                                <div>
                                    <select name="noteType" id="noteType" class="form-control">
                                        <option value="1">Studio</option>
                                        <option value="2">Mini</option>
                                        <option value="3">WorkCenter</option>
                                    </select>

                                </div>
                            </div>
                        </div>
                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">제 목</div>
                                <div>
                                    <input type="text" class="form-control input-form" name="title" id="title" placeholder=""
                                           value="" maxlength="100">
                                    <div class="text-info-mih" >
                                        <small id="titleChkText" class="form-text text-danger"></small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">내 용</div>
                                <div>

                                    <div class="contentNote"></div>
                                    <div class="text-info-mih">
                                        <small id="contentChkText" class="form-text text-danger"></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
                <button type="button" class="btn btn-primary btn-save">등록</button>
            </div>
        </div>
    </div>
</div>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/cs/releaseNoteList.js"></script>
<!-- custom script 위치 -->
<script type="text/javascript">
    $(function(){
        <#--$("#searchType").val('${RequestParameters.searchType!}');-->
        $('[data-toggle="tooltip"]').tooltip();

        // 정렬 순서 변경 처리
        $(".icon-caret-down").on("click", function(){
            var fullStringClassName = $(this).attr("class");
            var className = fullStringClassName.substring(45);
            $("#sort").val(className);
            $("#searchForm").submit();
        });
        $('.contentNote').summernote({
            placeholder: 'ReleaseNote 내용을 입력해주세요.',
            height: 150,
            lang:'',
            dialogsInBody: true,
            tooltip: false
        });
    });

</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">