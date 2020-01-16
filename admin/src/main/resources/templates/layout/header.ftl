<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <#--  <div class="sidebar-logo">
            <a id="sidebarCollapse">
                <i class="icon-menu"></i>
            </a>
        </div>  -->
        <div class="sidebar-header">
            <h3>
                <a href="/">
                    <i class="icon-logo white-color font18"></i>
                </a>
            </h3>
        </div>
        <div class="sidebar-icon d-flex justify-content-center align-items-center">
            <a href="#" class="mr-3">
                <span>administrator</span>
            </a>
            <a data-toggle="modal" data-backdrop="static" data-target="#adminInfoModal" class="mr-3">
                <i class="icon-setting white-color font18"></i>
            </a>
            <a href="/logout">
                <i class="icon-logout white-color font18"></i>
            </a>
        </div>
    </div>
</nav>

<nav id="sidebar" class="d-flex align-content-between flex-wrap">

    <ul class="list-unstyled components">
        <li>
            <div class="navi-title">Navigation</div>
        </li>
        <#if springMacroRequestContext.requestUri?contains("/user/")>
            <li class="side-active">
                <a href="/user/list"><i class="icon-user2 font12"></i>사용자 관리</a>
            </li>
        <#else>
            <li>
                <a href="/user/list"><i class="icon-user2 font12"></i>사용자 관리</a>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/company/")>
            <li class="side-active">
                <a href="/company/list"><i class="icon-user-add font12"></i>회사 관리</a>
            </li>
        <#else>
            <li>
                <a href="/company/list"><i class="icon-user-add font12"></i>회사 관리</a>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/contract/")>
            <li class="side-active">
                <a href="/contract/new_list"><i class="icon-user-add font12"></i>계약 관리</a>
            </li>
        <#else>
            <li>
                <a href="/contract/new_list"><i class="icon-user-add font12"></i>계약 관리</a>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/repository/")>
            <li class="side-active">
                <a href="#repository" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle dropdown-toggle-icon"><i class="icon-hard-drive font12"></i>레포지토리 관리</a>
                <ul class="list-unstyled collapse show" id="repository">
                    <#if springMacroRequestContext.requestUri?contains("/repository/list")>
                        <li class="side-sub-active">
                            <a href="/repository/list"><i class="icon-cloud1 font12"></i>콘텐츠 관리</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/repository/list"><i class="icon-cloud1 font12"></i>콘텐츠 관리</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/repository/recomm")>
                        <li class="side-sub-active">
                            <a href="/repository/recomm"><i class="icon-like font12"></i>추천 아이템 관리</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/repository/recomm"><i class="icon-like font12"></i>추천 아이템 관리</a>
                        </li>
                    </#if>
                    <#--<li>-->
                        <#--<a href="javascript:alert('준비중')"><i class="icon-clip font12"></i>분류 관리</a>-->
                    <#--</li>-->
                </ul>
            </li>
        <#else>
            <li>
                <a href="#repository" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle dropdown-toggle-icon"><i class="icon-hard-drive font12"></i>레포지토리 관리</a>
                <ul class="collapse list-unstyled" id="repository">
                    <li>
                        <a href="/repository/list"><i class="icon-cloud1 font12"></i>콘텐츠 관리</a>
                    </li>
                    <li>
                        <a href="/repository/recomm"><i class="icon-like font12"></i>추천 아이템 관리</a>
                    </li>
                    <#--<li>-->
                    <#--<a href="javascript:alert('준비중')"><i class="icon-clip font12"></i>분류 관리</a>-->
                    <#--</li>-->
                </ul>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/license/") || springMacroRequestContext.requestUri?contains("/abbyy/") || springMacroRequestContext.requestUri?contains("/trial/") >
            <li class="side-active">
                <a href="#license" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle dropdown-toggle-icon"><i class="icon-key1 font12"></i>라이선스 관리</a>
                <ul class="collapse list-unstyled collapse show" id="license">
                    <#if springMacroRequestContext.requestUri?contains("/license/list")>
                        <li class="side-sub-active">
                            <a href="/license/list"><i class="icon-lock font12"></i>라이선스 목록</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/license/list"><i class="icon-lock font12"></i>라이선스 목록</a>
                        </li>
                    </#if>
<#--                    <#if springMacroRequestContext.requestUri?contains("/license/write")>-->
<#--                        <li class="side-sub-active">-->
<#--                            <a href="/license/write"><i class="icon-key font12"></i>라이선스 생성</a>-->
<#--                        </li>-->
<#--                    <#else>-->
<#--                        <li>-->
<#--                            <a href="/license/write"><i class="icon-key font12"></i>라이선스 생성</a>-->
<#--                        </li>-->
<#--                    </#if>-->
                    <#--<li>-->
                    <#--<a href="#">라이선스 연장신청 관리</a>-->
                    <#--</li>-->
                    <#--<#if springMacroRequestContext.requestUri?contains("/abbyy/list")>-->
                        <#--<li class="side-sub-active">-->
                            <#--<a href="/abbyy/list"><i class="icon-note font12"></i>ABBYY 라이선스 관리</a>-->
                        <#--</li>-->
                    <#--<#else>-->
                        <#--<li>-->
                            <#--<a href="/abbyy/list"><i class="icon-note font12"></i>ABBYY 라이선스 관리</a>-->
                        <#--</li>-->
                    <#--</#if>-->
                    <#--<#if springMacroRequestContext.requestUri?contains("/abbyy/registrationForm")>-->
                        <#--<li class="side-sub-active">-->
                            <#--<a href="/abbyy/registrationForm"><i class="icon-pen font12"></i>ABBYY 라이선스 등록</a>-->
                        <#--</li>-->
                    <#--<#else>-->
                        <#--<li>-->
                            <#--<a href="/abbyy/registrationForm"><i class="icon-pen font12"></i>ABBYY 라이선스 등록</a>-->
                        <#--</li>-->
                    <#--</#if>-->
                    <#if springMacroRequestContext.requestUri?contains("/trial/list")>
                        <li class="side-sub-active">
                            <a href="/trial/list"><i class="icon-bolt font12"></i>Trial 관리</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/trial/list"><i class="icon-bolt font12"></i>Trial 관리</a>
                        </li>
                    </#if>
                </ul>
            </li>
        <#else>
            <li>
                <a href="#license" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle dropdown-toggle-icon"><i class="icon-key1 font12"></i>라이선스 관리</a>
                <ul class="collapse list-unstyled" id="license">
                    <li>
                        <a href="/license/list"><i class="icon-lock font12"></i>라이선스 관리</a>
                    </li>
                    <#--<li>-->
                        <#--<a href="/license/write"><i class="icon-key font12"></i>라이선스 생성</a>-->
                    <#--</li>-->
                    <#--<li>-->
                    <#--<a href="#">라이선스 연장신청 관리</a>-->
                    <#--</li>-->
                    <#--<li>-->
                        <#--<a href="/abbyy/list"><i class="icon-note font12"></i>ABBYY 라이선스 관리</a>-->
                    <#--</li>-->
                    <#--<li>-->
                        <#--<a href="/abbyy/registrationForm"><i class="icon-pen font12"></i>ABBYY 라이선스 등록</a>-->
                    <#--</li>-->
                    <li>
                        <a href="/trial/list"><i class="icon-bolt font12"></i>Trial 관리</a>
                    </li>
                </ul>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/cs/")>
            <li class="side-active">
                <a href="#cs" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle dropdown-toggle-icon"><i class="icon-conversation font12"></i>CS 관리</a>
                <ul class="collapse list-unstyled collapse show" id="cs">
                    <#if springMacroRequestContext.requestUri?contains("/cs/notice")>
                        <li class="side-sub-active">
                            <a href="/cs/notice"><i class="icon-sound font12"></i>공지사항</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/notice"><i class="icon-sound font12"></i>공지사항</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/cs/onetoone")>
                        <li class="side-sub-active">
                            <a href="/cs/onetoone"><i class="icon-bubble font12"></i>1:1문의</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/onetoone"><i class="icon-bubble font12"></i>1:1문의</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/cs/div_one")>
                        <li class="side-sub-active">
                            <a href="/cs/div_one"><i class="icon-bubble font12"></i>1:1문의 분류관리</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/div_one"><i class="icon-bubble font12"></i>1:1문의 분류관리</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/cs/bug")>
                        <li class="side-sub-active">
                            <a href="/cs/bug"><i class="icon-paperplane font12"></i>버그신고</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/bug"><i class="icon-paperplane font12"></i>버그신고</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/cs/contactus")>
                        <li class="side-sub-active">
                            <a href="/cs/contactus"><i class="icon-paperplane font12"></i>제휴문의</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/contactus"><i class="icon-paperplane font12"></i>제휴문의</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/cs/newsroom")>
                        <li class="side-sub-active">
                            <a href="/cs/newsroom"><i class="icon-paperplane font12"></i>뉴스룸</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/newsroom"><i class="icon-paperplane font12"></i>뉴스룸</a>
                        </li>
                    </#if>
                    <#if springMacroRequestContext.requestUri?contains("/cs/release_note")>
                        <li class="side-sub-active">
                            <a href="/cs/release_note"><i class="icon-paperplane font12"></i>Release Note</a>
                        </li>
                    <#else>
                        <li>
                            <a href="/cs/release_note"><i class="icon-paperplane font12"></i>Release Note</a>
                        </li>
                    </#if>
                </ul>
            </li>
        <#else>
            <li>
                <a href="#cs" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle dropdown-toggle-icon"><i class="icon-conversation font12"></i>CS 관리</a>
                <ul class="collapse list-unstyled" id="cs">
                    <li>
                        <a href="/cs/notice"><i class="icon-sound font12"></i>공지사항</a>
                    </li>
                    <li>
                        <a href="/cs/onetoone"><i class="icon-bubble font12"></i>1:1문의</a>
                    </li>
                    <li>
                        <a href="/cs/div_one"><i class="icon-bubble font12"></i>1:1문의 분류관리</a>
                    </li>
                    <li>
                        <a href="/cs/bug"><i class="icon-paperplane font12"></i>버그신고</a>
                    </li>
                    <li>
                        <a href="/cs/contactus"><i class="icon-paperplane font12"></i>제휴문의</a>
                    </li>
                    <li>
                        <a href="/cs/newsroom"><i class="icon-paperplane font12"></i>뉴스룸</a>
                    </li>
                    <li>
                        <a href="/cs/release_note"><i class="icon-paperplane font12"></i>Release Note</a>
                    </li>
                </ul>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/partner/")>
            <li class="side-active">
                <a href="/partner/list"><i class="icon-load-balancer font12"></i>파트너사 관리</a>
            </li>
        <#else>
            <li>
                <a href="/partner/list"><i class="icon-load-balancer font12"></i>파트너사 관리</a>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/version_manage/")>
            <li class="side-active">
                <a href="/version_manage/list"><i class="icon-load-balancer font12"></i>프로그램 버전 관리</a>
            </li>
        <#else>
            <li>
                <a href="/version_manage/list"><i class="icon-load-balancer font12"></i>프로그램 버전 관리</a>
            </li>
        </#if>
    </ul>
    <div class="copyight">Copyright©a.works<br>All Rights Reserved</div>
</nav>

<div class="modal fade" id="adminInfoModal" tabindex="-1" role="dialog" aria-labelledby="adminInfoCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="adminInfoCenterTitle">관리자 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="adminInfo-modal-view"></div>
        </div>
    </div>
</div>

<script src="/assets/js/main.js"></script>