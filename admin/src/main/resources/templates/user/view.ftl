<#include "/layout/base.ftl">

    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="breadcrumb-wrap mb-3">
                        <div class="row">
                            <div class="col d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">메인</a></li>
                                        <li class="breadcrumb-item"><a href="/user/list">사용자 관리</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">사용자 상세</li>
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
                            <input type="hidden" name="seq" id="seq" value="<#if user??>${user.seq}</#if>">

                            <div id="contentMain" class="p-5 view-wireframe">

                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">아이디 (이메일)</div>
                                    </div>
                                    <div class="col-10">
                                        ${user.loginId}
                                        <#--  <div class="miw300">${user.loginId}</div>  -->
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">프로필 이미지</div>
                                    </div>
                                    <div class="col-10">
                                        <div id="imageView">
                                            <#--  <div></div>  -->
                                            <#if user.profileImg?exists && user.profileImg != ''>
                                                <img id="imagePreview" class="view-user-img" src="${user.profileImg!}" alt="">
                                            <#else>
                                                <img id="imagePreview" class="view-user-img" src="/assets/images/user.png" alt="">
                                            </#if>

                                        </div>
                                    </div>
                                </div>
                                <#--  <hr class="my-5">  -->
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">이 름</div>
                                    </div>
                                    <div class="col-10">
                                        <#if user.name?exists && user.name != ''>
                                            ${user.name!}
                                        <#else>
                                            -
                                        </#if>

                                        <#--  <div class="miw300">${user.name!}</div>  -->
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">연락처</div>
                                    </div>
                                    <div class="col-10">
                                        <#--  <div class="miw300">${user.phone!}</div>  -->
                                        <#if user.phone?exists && user.phone != ''>
                                            ${user.phone!}
                                        <#else>
                                            -
                                        </#if>
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">회사명</div>
                                    </div>
                                    <div class="col-10">
                                        <#--  <div class="mxw300">${user.comName!}</div>  -->
                                        <#if user.comName?exists && user.comName != ''>
                                            ${user.comName!}
                                        <#else>
                                            -
                                        </#if>
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">직 급</div>
                                    </div>
                                    <div class="col-10">
                                        <#--  <div class="miw300">${user.position!}</div>  -->
                                        <#if user.position?exists && user.position != ''>
                                            ${user.position!}
                                        <#else>
                                            -
                                        </#if>
                                    </div>
                                </div>
                                <#--  <hr class="my-5">  -->
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">레 벨</div>
                                    </div>
                                    <div class="col-10">
                                        <#if user.level = 1>User<#else><#if user.level = 2>Contract Admin User<#else>User</#if></#if>
                                        <#--  <#if user.level = 1>Trial User<#else>
                                            <#if user.level = 2>User
                                                <#else>Contract Admin User
                                            </#if>
                                        </#if>  -->
                                    </div>
                                </div>
                                <#if user??>
                                    <div class="row mb-3">
                                        <div class="col-2">
                                            <div class="text-right font-w600">등록일</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div class="miw300">${user.createDatetime?string["yyyy년 MM월 dd일 HH시mm분"]}</div>  -->
                                            ${user.createDatetime?string["yyyy년 MM월 dd일 HH시mm분"]}
                                        </div>
                                    </div>
                                </#if>
                            </div>
                        </form>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-info min-width120" type="button" onclick="document.location.href='/user/list'">목록</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


<#include "/layout/base_script.ftl">

<script type="text/javascript">
    $(function(){

    });
</script>

<#include "/layout/footer.ftl">