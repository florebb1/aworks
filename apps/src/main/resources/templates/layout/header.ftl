
<div class="header">
    <div class="container h-100">
        <div class="row h-100">
            <div class="col-3 d-flex justify-content-start align-items-center logo-section">
                <a href="/" class="d-flex justify-content-start align-items-center main-logo a-link">
                    <i class="icon-logo font18 mr-3"></i>
                    <span>Repository</span>
                </a>
            </div>
            <div class="col-6 d-flex justify-content-center align-items-center menu-section">
                <a href="/market" class="a-link"><@spring.message "header.text1"/></a>
                <a href="#" class="a-link"><@spring.message "header.text2"/></a>
                <div class="btn-group">
                    <a href="#" class="a-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><@spring.message "header.text3"/></a>
                    <div class="dropdown-menu dropdown-menu-tip-nw">
                        <a class="dropdown-item" href="/board/list"><@spring.message "header.text4"/></a>
                        <#if s_user.s_seq?c?number &gt; 0>
                            <a class="dropdown-item" id="direct" href="/board/direct"><@spring.message "header.text5"/></a>
                        <#else>
                            <a href="void(0);" onclick="$('#login-md').modal('show');return false;"><@spring.message "header.text5"/></a>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="col-3 d-flex justify-content-end align-items-center user-menu-section">
                <div class="btn-group">
                    <a href="#" class="a-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <@spring.message "header.text13"/><i class="icon-caret-down font8 ml-2"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-tip-nw">
                        <a class="dropdown-item" href="?language=ko_KR">
                            <i class="icon-south-korea mr-1">
                                <i class="path1"></i><i class="path2"></i><i class="path3"></i><i class="path4"></i><i class="path5"></i><i class="path6"></i><i class="path7"></i><i class="path8"></i><i class="path9"></i><i class="path10"></i><i class="path11"></i><i class="path12"></i><i class="path13"></i><i class="path14"></i><i class="path15"></i><i class="path16"></i><i class="path17"></i><i class="path18"></i><i class="path19"></i><i class="path20"></i><i class="path21"></i>
                            </i>
                            KOR
                        </a>
                        <a class="dropdown-item" href="?language=en_US">
                            <i class="icon-united-states mr-1">
                                <i class="path1"></i><i class="path2"></i><i class="path3"></i><i class="path4"></i><i class="path5"></i><i class="path6"></i>
                            </i>
                            ENG
                        </a>
                    </div>
                </div>
                <span class="side-line">l</span>
                <#if s_user.s_seq?c?number &gt; 0>
                    <div class="btn-group" id="afterLogin">
                        <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="a-link d-flex justify-content-center align-items-center">
                            <#if s_user.s_profileImg?exists && s_user.s_profileImg != ''>
                                <span id="profileImg" class="user-img" style="background-image:url('${s_user.s_profileImg!}');"></span>
                            <#else>
                                <span id="profileImg" class="user-img" style="background-image:url('/assets/images/profile-sample.png');"></span>
                            </#if>
                            <i class="icon-caret-down font8 ml-2"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-tip-nw p-3">
                            <div class="dropdown-user-info">${s_user.s_loginId!}<@spring.message "header.text6"/></div>
                            <a class="dropdown-item" href="/mypage/profile"><@spring.message "header.text7"/></a>
                            <a id="downloadList" class="dropdown-item" href="/mypage/download"><@spring.message "header.text8"/></a>
                            <a id="onetooneList" class="dropdown-item" href="/mypage/onetoone"><@spring.message "header.text9"/></a>
                            <span  class="dropdown-item" onclick="document.location.href='/api/logout'"><@spring.message "header.text10"/></span>
                        </div>
                    </div>

                <#else>
                    <div class="btn-group" id="beforeLogin">
                        <!-- 로그인 전 시작 -->
                        <a href="#" class="a-link" data-toggle="modal" data-backdrop="static" data-target="#login-md"><@spring.message "header.text11"/></a>
                        <span class="side-line">l</span>
                        <a href="#" class="a-link" data-toggle="modal" data-backdrop="static" data-target="#join-md"><@spring.message "header.text12"/></a>
                        <!-- 로그인 전 끝 -->
                    </div>
                </#if>
                <!-- 로그인 후 끝 -->
            </div>
        </div>
    </div>
</div>