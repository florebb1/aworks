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
                                    <li class="breadcrumb-item"><a href="#">cs 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">ReleaseNote 상세보기</li>
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


                    <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">
                        <div class="form-row mb-4">
                            <div class="col-2">
                                <div class="miw100 text-right">분 류</div>
                            </div>
                            <div class="col-10">
                                <#if releaseNote.noteType?number = 1>
                                    Stuido
                                <#elseif releaseNote.noteType?number = 2>
                                    Mini
                                <#else>
                                    WorkCenter
                                </#if>
                                <#--  <div class="miw300">${user.loginId}</div>  -->
                            </div>
                        </div>
                        <div class="form-row mb-4">
                            <div class="col-2">
                                <div class="miw100 text-right">제 목</div>
                            </div>
                            <div class="col-10">
                                ${releaseNote.title!}
                                <#--  <div class="miw300">${user.loginId}</div>  -->
                            </div>
                        </div>

                        <div class="form-row mb-4">
                            <div class="col-2">
                                <div class="miw100 text-right">내 용</div>
                            </div>
                            <div class="col-10">
                                <#--<input type="text" class="form-control input-form mxw300" value="${repository.description}" readonly>-->
                                <div id="contentNote"> ${releaseNote.content!} </div>
                            </div>
                        </div>


                    </div>

                </div>
                <div class="text-center">
                    <button class="btn btn-info" type="button" onclick="document.location.href='/cs/release_note'">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>


<#include "/layout/base_script.ftl">
<script type="text/javascript">
    $(document).ready(function () {

    });

</script>
<#include "/layout/footer.ftl">