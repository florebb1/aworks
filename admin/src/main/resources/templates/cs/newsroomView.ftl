<#include "/layout/base.ftl">
<style>
    img {max-width:100%}
</style>
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
                                    <li class="breadcrumb-item"><a href="#">cs 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">뉴스룸 상세보기</li>
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
                    <form id="writeForm" action="/user/save" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="seq" id="seq" value="<#if newsroom??>${newsroom.seq?c}</#if>">

                        <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">

                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">제 목</div>
                                </div>
                                <div class="col-10">
                                    ${newsroom.title}
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">간략 내용</div>
                                </div>
                                <div class="col-10">
                                    ${newsroom.subTitle}
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">기사 등록일</div>
                                </div>
                                <div class="col-10">
                                    <#if newsroom.viewDatetime?exists>${newsroom.viewDatetime?string["yyyy-MM-dd"]}</#if>
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">리스트 이미지</div>
                                </div>
                                <div class="col-10" id="noticeFileArea">
                                    <#if newsroom??>
                                        <#if newsroom.listFile?exists>
                                            <img src="${newsroom.listFile}" width="50px" height="50px">
                                        </#if>
                                    </#if>
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">내 용</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form mxw300" value="${repository.description}" readonly>-->
                                    <div id="contentNote"> ${newsroom.content} </div>
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">노출/미노출</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form mxw300" value="${repository.description}" readonly>-->
                                    <#if newsroom.displayYn?number = 0>노출<#else>미노출</#if>
                                </div>
                            </div>



                        </div>
                    </form>
                </div>
                <div class="text-center">
                    <button class="btn btn-info" type="button" onclick="document.location.href='/cs/newsroom'">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>


<#include "/layout/base_script.ftl">
<script type="text/javascript">
    $(document).ready(function () {
        <#if newsroom?? && newsroom.content??>
        <#--$("#contentNote").summernote('code', '${notice.content}');-->
        <#--$("#contentNote").summernote('disable');-->
        </#if>

        // $('#contentNote').summernote({
        //     placeholder: '공지 내용을 입력해주세요.',
        //     height: 150,
        //     focus: false,
        //     lang: 'ko-KR'
        // });


    });

    function noticeFileDown(filePath, fileSeq) {
        console.log(filePath + " , " + fileSeq);
        $.fileDownload(filePath);
    }

</script>
<#include "/layout/footer.ftl">