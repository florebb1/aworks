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
                                    <li class="breadcrumb-item active" aria-current="page">프로그램 버전 관리</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 <span id="totalCnt">${total}</span>개</p>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#versionModalWc" data-seq="" style="display:inline-block">WC 버전 등록</button>
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#versionModal" data-seq="" style="display:inline-block">버전 등록</button>
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
                        <div class="col">
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
                        <#--<button type="button" class="btn btn-light ml-1 btn-exceldownload">선택 엑셀 다운로드</button>-->
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
                            <col width="140px">
                            <col width="140px">
                            <col width="">
                            <col width="140px">
                            <col width="200px">
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
                                    <span>Type</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="version_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>bit</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bit_type" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>버전</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="version_number" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>등록</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>업데이트일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="update_datetime" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>사용갯수</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="uses_count" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down "></i>
                                    </button>
                                </div>
                            </th>

                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="versionManageList">

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
                <nav id="paging" class="d-flex justify-content-center"></nav>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="versionModal" tabindex="-1" role="dialog" aria-labelledby="versionModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="versionModalCenterTitle">버전 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div class="modal-body pa-0">
                <form id="writeForm" action="/version_manage/save" method="post" enctype="multipart/form-data">
                    <div id="contentMain" class="input-display">

                            <div class="form-row mb-4">
                                <div class="col-3 main-form-title">
                                    <span>Type</span>
                                </div>
                                <div class="col-9">

                                    <div class="form-check form-check-inline mr-5 pt-1 pb-2">
                                        <input class="form-check-input" type="radio" name="versionType" id="versionType0" value="0" checked>
                                        <label class="form-check-label" for="versionType0">Mini</label>
                                    </div>
                                    <div class="form-check form-check-inline mr-5 pt-1 pb-2">
                                        <input class="form-check-input" type="radio" name="versionType" id="versionType1" value="1">
                                        <label class="form-check-label" for="versionType1">Studio</label>
                                    </div>
                                    <div class="form-check form-check-inline pt-1 pb-2">
                                        <input class="form-check-input" type="radio" name="versionType" id="versionType2" value="2">
                                        <label class="form-check-label" for="versionType2">Trial</label>
                                    </div>

                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-3 main-form-title">
                                    <span>bit</span>
                                </div>
                                <div class="col-9">
                                    <div class="form-check form-check-inline mr-5 pt-1 pb-2">
                                        <input class="form-check-input" type="radio" name="bitType" id="bitType0" value="0" checked>
                                        <label class="form-check-label" for="bitType0">Window7 32x</label>
                                    </div>
                                    <div class="form-check form-check-inline pt-1 pb-2">
                                        <input class="form-check-input" type="radio" name="bitType" id="bitType1" value="1">
                                        <label class="form-check-label" for="bitType1">Window10 64x</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-3 main-form-title">
                                    <span>버전</span>
                                </div>
                                <div class="col-9">
                                        <input type="text" class="form-control input-form" placeholder="" required="" name="versionNumber" id="versionNumber"
                                               value="">
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-3 main-form-title">
                                    <span>업데이트일</span>
                                </div>
                                <div class="col-9">
                                        <input type="text" class="form-control input-form" placeholder="" required="" name="updateDatetimeStr" id="updateDatetimeStr" autocomplete="off"
                                               value="">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-3 main-form-title">
                                    <span>파일</span>
                                </div>
                                <div class="col-9">

                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" name="file" id="file" value="" required>
                                            <label class="custom-file-label" for="file">프로그램 파일을 업로드 해주세요.</label>
                                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                                        </div>

                                        <#--  <input type="file" class="form-control input-form" placeholder="" required="" name="file" id="file"
                                               value="">  -->
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
<div class="modal fade" id="versionModalWc" tabindex="-1" role="dialog" aria-labelledby="versionModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="versionModalCenterTitle">Wc 버전 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div class="modal-body pa-0">
                <form id="writeForm2" action="/version_manage/save" method="post" enctype="multipart/form-data">
                    <div id="contentMain" class="input-display">
                        <input type="hidden" name="versionType" value="3">
                        <div class="form-row mb-4">
                            <div class="col-3 main-form-title">
                                <span>OS</span>
                            </div>
                            <div class="col-9">
                                <div class="form-check form-check-inline mr-5 pt-1 pb-2">
                                    <input class="form-check-input" type="radio" name="bitType" id="bitType3" value="0" checked>
                                    <label class="form-check-label" for="bitType3">linux</label>
                                </div>
                                <div class="form-check form-check-inline pt-1 pb-2">
                                    <input class="form-check-input" type="radio" name="bitType" id="bitType4" value="1">
                                    <label class="form-check-label" for="bitType4">windows</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row mb-4">
                            <div class="col-3 main-form-title">
                                <span>버전</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control input-form" placeholder="" required="" name="versionNumber" id="versionNumber1"
                                       value="">
                            </div>
                        </div>
                        <div class="form-row mb-4">
                            <div class="col-3 main-form-title">
                                <span>업데이트일</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control input-form" placeholder="" required="" name="updateDatetimeStr" id="updateDatetimeStr2" autocomplete="off"
                                       value="">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-3 main-form-title">
                                <span>파일</span>
                            </div>
                            <div class="col-9">

                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" name="file" id="file1" value="" required>
                                    <label class="custom-file-label" for="file1">프로그램 파일을 업로드 해주세요.</label>
                                    <div class="invalid-feedback">Example invalid custom file feedback</div>
                                </div>

                                <#--  <input type="file" class="form-control input-form" placeholder="" required="" name="file" id="file"
                                       value="">  -->
                            </div>
                        </div>
                        <#--<div class="form-row">-->
                            <#--<div class="col-3 main-form-title">-->
                                <#--<span>API파일</span>-->
                            <#--</div>-->
                            <#--<div class="col-9">-->

                                <#--<div class="custom-file">-->
                                    <#--<input type="file" class="custom-file-input" name="file2" id="file2" value="" required>-->
                                    <#--<label class="custom-file-label" for="file2">프로그램 파일을 업로드 해주세요.</label>-->
                                    <#--<div class="invalid-feedback">Example invalid custom file feedback</div>-->
                                <#--</div>-->

                                <#--&lt;#&ndash;  <input type="file" class="form-control input-form" placeholder="" required="" name="file" id="file"-->
                                       <#--value="">  &ndash;&gt;-->
                            <#--</div>-->
                        <#--</div>-->
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
                <button type="button" class="btn btn-primary btn-save-wc">등록</button>
            </div>
        </div>
    </div>
</div>

<#include "/layout/base_script.ftl">
<script src="/assets/js/page/versionManage/list.js"></script>
<script type="text/javascript">
    $(function(){
        $("#searchType").val('${RequestParameters.searchType!}');
        $('[data-toggle="tooltip"]').tooltip();

        // // 정렬 순서 변경 처리
        // $(".icon-caret-down").on("click", function(){
        //     var fullStringClassName = $(this).attr("class");
        //     var className = fullStringClassName.substring(45);
        //     $("#sort").val(className);
        //     $("#searchForm").submit();
        // });

    });

</script>
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">