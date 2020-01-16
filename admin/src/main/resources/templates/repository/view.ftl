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
                                    <li class="breadcrumb-item active" aria-current="page">레포지토리 상세</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                        </div>
                        <div class="col-auto">
                        </div>
                    </div>
                </div>

                <hr>

                <div class="card">
                    <form id="writeForm" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="seq" id="seq" value="<#if repository??>${repository.seq}</#if>">
                        <div id="contentMain" class="detail-display">

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">콘텐츠 정보</h6>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">콘텐츠 이름</div>
                                </div>
                                <div class="col-10">
                                    <#--  <input type="text" class="form-control input-form" value="${repository.appName}" readonly>  -->
                                    ${repository.appName}
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">콘텐츠 요약</div>
                                </div>
                                <div class="col-10">
                                    <#--  <input type="text" class="form-control input-form" value="<#if repository.summary??>${repository.summary}</#if>" readonly>  -->
                                    <#if repository.summary??>${repository.summary}</#if>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">콘텐츠 설명</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form" value="${repository.description}" readonly>-->
                                    ${repository.description!''}
                                </div>
                            </div>

                            <hr>

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">타입 / 분류</h6>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">타입</div>
                                </div>
                                <div class="col-10">
                                    <#--  <input type="text" class="form-control input-form"
                                           value="<#if repository.appType = 0>Process<#else>Task</#if>" readonly>  -->
                                    <#if repository.appType = 0>Process<#else>Task</#if>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">업무분류</div>
                                </div>
                                <div class="col-10">
                                    <input type="checkbox" class="form-check-label pointer input-form" name="processTypes" id="" value="0" readonly>
                                    <label for="" class="pointer">Finance & Accounting</label>
                                    <input type="checkbox" class="form-check-label pointer ml-3 input-form" name="processTypes" id="" value="" readonly>
                                    <label for="" class="pointer">HR</label>
                                    <input type="checkbox" class="form-check-label pointer ml-3 input-form" name="processTypes" id="" value="" readonly>
                                    <label for="" class="pointer">Sales</label>
                                    <input type="checkbox" class="form-check-label pointer ml-3 input-form" name="processTypes" id="" value="" readonly>
                                    <label for="" class="pointer">Others</label>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">태그 (#)</div>
                                </div>
                                <div class="col-10">
                                    <#--  <input type="text" class="form-control input-form"
                                           value="<#if repository.tags??>${repository.tags}</#if>" readonly>  -->
                                    <#if repository.tags??>${repository.tags}</#if>
                                </div>
                            </div>

                            <hr>

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">콘텐츠 추가정보</h6>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">기대 효과</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form" value="${repository.benefit}" readonly>-->
                                    ${repository.benefit!''}
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">의 존</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form" value="${repository.appDependencies}" readonly>-->
                                    ${repository.appDependencies!''}
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">호 환</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form" value="${repository.component}" readonly>-->
                                    ${repository.component!''}
                                </div>
                            </div>

                            <hr>

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">콘텐츠 메뉴얼</h6>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">매뉴얼</div>
                                </div>
                                <div class="col-10">
                                    <a href="javascript:void(0)" onclick="fileDownload('${repository.manualFileUrl!}')"><i class="icon-manual mr-2"></i>메뉴얼다운로드</a>
                                </div>
                            </div>

                            <hr>

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">콘텐츠 미디어</h6>
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">영상 (App 실행 영상)</div>
                                </div>
                                <div class="col-10">
                                    <a href="">${repository.movieFileUrl!''}</a>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">이미지 (App Screen)</div>
                                </div>
                                <div class="col-10">
                                    <div class="repository-img-body">
                                        <#if repositoryMedia?size &gt; 0>
                                            <#list repositoryMedia as media>
                                                <img src="${media.mediaValue!}" style="width:120px"/>
                                            </#list>
                                        </#if>
                                    </div>
                                </div>
                            </div>

                            <hr>

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">콘텐츠 버전 / 라이선스</h6>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">버전 정보</div>
                                </div>
                                <div class="col-10">
                                    <#--  <input type="text" class="form-control input-form" value="<#if repository.version??>${repository.version}</#if>" readonly>  -->
                                    <#if repository.version??>${repository.version}</#if>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">버전 설명</div>
                                </div>
                                <div class="col-10">
                                    <#--  <input type="text" class="form-control input-form" value="<#if repository.versionNote??>${repository.versionNote}</#if>" readonly>  -->
                                    <#if repository.versionNote??>${repository.versionNote}</#if>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">라이선스 정보</div>
                                </div>
                                <div class="col-10">
                                    <a href="javascript:void(0)" onclick="fileDownload('${repository.licenseFileUrl!}')"><i class="icon-key1 mr-2"></i>라이선스 다운로드</a>
                                </div>
                            </div>

                            <hr>

                            <div class="form-row">
                                <div class="col-12">
                                    <h6 class="modalin-title">콘텐츠 파일</h6>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-2">
                                    <div class="text-right font-w600">콘텐츠 첨부파일 (App)</div>
                                </div>
                                <div class="col-10">
                                    <a href="javascript:void(0)" onclick="fileDownload('${repository.appFileUrl!}')"><i class="icon-download mr-2"></i>첨부파일 다운로드</a>
                                </div>
                            </div>


                            <!-- tab start -->
                            <#--<div class="row mb-4 mt-5">-->
                                <#--<div class="col-9 offset-2">-->

                                    <#--<ul class="nav nav-tabs" id="myTab" role="tablist">-->
                                    <#--<li class="nav-item">-->
                                        <#--<a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="true">리 뷰</a>-->
                                    <#--</li>-->
                                    <#--<li class="nav-item">-->
                                        <#--<a class="nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab" aria-controls="qna" aria-selected="false">질 문</a>-->
                                    <#--</li>-->
                                    <#--<li class="nav-item">-->
                                        <#--<a class="nav-link" id="bug-tab" data-toggle="tab" href="#bug" role="tab" aria-controls="bug" aria-selected="false">버그신고</a>-->
                                    <#--</li>-->
                                    <#--</ul>-->
                                    <#--<div class="tab-content" id="myTabContent">-->
                                        <#--<div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">-->
                                            <#--<div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">-->
                                                <#--<input type="hidden" id="rvTotal" name="rvTotal" value="">-->
                                                <#--<input type="hidden" id="rvRow" name="rvRow" value="10">-->
                                                <#--<input type="hidden" id="rvSort" name="rvSort" value="create_datetime">-->
                                                <#--<input type="hidden" id="rvPage" name="rvPage" value="1">-->
                                                <#--<input type="hidden" id="rvOrder" name="rvOrder" value="0">-->
                                                <#--<table class="table">-->
                                                    <#--<thead>-->
                                                    <#--<tr>-->
                                                        <#--<th scope="col">-->
                                                            <#--<span>No</span>-->
                                                            <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                                            <#--</button>-->
                                                        <#--</th>-->
                                                        <#--<th scope="col">-->
                                                            <#--<span>등록일</span>-->
                                                            <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                                            <#--</button>-->
                                                        <#--</th>-->
                                                        <#--<th scope="col">-->
                                                            <#--<span>리뷰 내용</span>-->
                                                            <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                            <#--</button>-->
                                                        <#--</th>-->
                                                        <#--<th scope="col">-->
                                                            <#--<span>Action</span>-->
                                                        <#--</th>-->
                                                    <#--</tr>-->
                                                    <#--</thead>-->
                                                    <#--<tbody id="reviewList"></tbody>-->
                                                <#--</table>-->
                                                <#--<div id="review-page-selection"></div>-->
                                        <#--</div>-->
                                        <#--<div class="tab-pane fade" id="qna" role="tabpanel" aria-labelledby="qna-tab">-->
                                            <#--<input type="hidden" id="qnaTotal" name="qnaTotal" value="">-->
                                            <#--<input type="hidden" id="qnaRow" name="qnaRow" value="10">-->
                                            <#--<input type="hidden" id="qnaSort" name="qnaSort" value="create_datetime">-->
                                            <#--<input type="hidden" id="qnaPage" name="qnaPage" value="1">-->
                                            <#--<input type="hidden" id="qnaOrder" name="qnaOrder" value="0">-->
                                            <#--<table class="table">-->
                                                <#--<thead>-->
                                                <#--<tr>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>No</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>등록일</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>질문</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>내용</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>Action</span>-->
                                                    <#--</th>-->
                                                <#--</tr>-->
                                                <#--</thead>-->
                                                <#--<tbody id="qnaList"></tbody>-->
                                            <#--</table>-->
                                            <#--<div id="qna-page-selection"></div>-->
                                        <#--</div>-->
                                        <#--<div class="tab-pane fade" id="bug" role="tabpanel" aria-labelledby="bug-tab">-->
                                            <#--<input type="hidden" id="bugTotal" name="bugTotal" value="">-->
                                            <#--<input type="hidden" id="bugRow" name="bugRow" value="10">-->
                                            <#--<input type="hidden" id="bugSort" name="bugSort" value="create_datetime">-->
                                            <#--<input type="hidden" id="bugPage" name="bugPage" value="1">-->
                                            <#--<input type="hidden" id="bugOrder" name="bugOrder" value="0">-->
                                            <#--<table class="table">-->
                                                <#--<thead>-->
                                                <#--<tr>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>No</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>등록일</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>질문</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>내용</span>-->
                                                        <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                                            <#--<i class="icon-sort-arrows-couple-pointing-up-and-down accrued_payment"></i>-->
                                                        <#--</button>-->
                                                    <#--</th>-->
                                                    <#--<th scope="col">-->
                                                        <#--<span>Action</span>-->
                                                    <#--</th>-->
                                                <#--</tr>-->
                                                <#--</thead>-->
                                                <#--<tbody id="bugList"></tbody>-->
                                            <#--</table>-->
                                            <#--<div id="bug-page-selection"></div>-->
                                        <#--</div>-->
                                    <#--</div>-->

                                <#--</div>-->
                            <#--</div>-->
                            <!-- tab end -->
                        </div>
                    </form>
                </div>
                <div class="text-center">
                    <button class="btn btn-info min-width120" type="button" onclick="document.location.href='/repository/list'">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/layout/base_script.ftl">

<script type="text/javascript">
    $(function(){
        <#if repository?? && repository.description??>
            $("#descriptionEditor").summernote('code', '${repository.description}');
        </#if>
        $('#descriptionEditor').summernote({
            placeholder: '콘텐츠 설명을 입력해주세요.',
            tabsize: 2,
            width: 1000,
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ]
        });

        <#if repository?? && repository.benefit??>
            $("#benefitEditor").summernote('code', '${repository.benefit}');
        </#if>
        $('#benefitEditor').summernote({
            placeholder: '기대효과를 입력해주세요.',
            tabsize: 2,
            width: 1000,
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ]
        });

        <#if repository?? && repository.appDependencies??>
            $("#appDependenciesEditor").summernote('code', '${repository.appDependencies}');
        </#if>
        $('#appDependenciesEditor').summernote({
            placeholder: '의존을 입력해주세요.',
            tabsize: 2,
            width: 1000,
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ]
        });

        <#if repository?? && repository.component??>
            $("#componentEditor").summernote('code', '${repository.component}');
        </#if>
        $('#componentEditor').summernote({
            placeholder: '호환을 입력해주세요.',
            tabsize: 2,
            width: 1000,
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ]
        });
    });
    function fileDownload(filePath){
        document.location.href='/repository/fileDownload?fileUrl='+encodeURIComponent(filePath)
    }
</script>

<#include "/layout/footer.ftl">