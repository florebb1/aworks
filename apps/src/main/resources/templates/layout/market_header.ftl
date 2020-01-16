<div class="sub-header">
    <div class="container h-100">
        <div class="row h-100">
            <div class="col-3 d-flex justify-content-start align-items-center logo-section">
                <a href="/" class="d-flex justify-content-start align-items-center main-logo a-link">
                    <i class="icon-logo font18 mr-3"></i>
                    <span>Repository</span>
                </a>
            </div>
            <div class="col-6 d-flex justify-content-center align-items-center menu-section">
                <a href="/market" id="market" class="a-link">Market Place</a>
                <a href="#" id="info" class="a-link">Repository 소개</a>
                <div class="btn-group">
                    <a href="#" id="support" class="a-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">고객지원</a>
                    <div class="dropdown-menu dropdown-menu-tip-nw">
                        <a class="dropdown-item" href="/board/list">공지사항</a>
                        <#if s_user.s_seq?c?number &gt; 0>
                            <a class="dropdown-item" id="direct" href="/board/direct">1:1문의</a>
                        <#else>
                            <a href="void(0);" onclick="$('#login-md').modal('show');return false;">1:1문의</a>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="col-3 d-flex justify-content-end align-items-center user-menu-section">
                <div class="btn-group">
                    <a href="#" class="a-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        KOR<i class="icon-caret-down font8 ml-2"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-tip-nw">
                        <a class="dropdown-item" href="#">
                            <i class="icon-south-korea mr-1">
                                <i class="path1"></i><i class="path2"></i><i class="path3"></i><i class="path4"></i><i class="path5"></i><i class="path6"></i><i class="path7"></i><i class="path8"></i><i class="path9"></i><i class="path10"></i><i class="path11"></i><i class="path12"></i><i class="path13"></i><i class="path14"></i><i class="path15"></i><i class="path16"></i><i class="path17"></i><i class="path18"></i><i class="path19"></i><i class="path20"></i><i class="path21"></i>
                            </i>
                            KOR
                        </a>
                        <a class="dropdown-item" href="#">
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
                            <div class="dropdown-user-info">${s_user.s_loginId!}님</div>
                            <a class="dropdown-item" href="/mypage/profile">정보수정</a>
                            <a id="downloadList" class="dropdown-item" href="/mypage/download">다운로드 내역</a>
                            <a id="onetooneList" class="dropdown-item" href="/mypage/onetoone">1:1문의 내역</a>
                            <span  class="dropdown-item" onclick="document.location.href='/api/logout'">로그아웃</span>
                        </div>
                    </div>
                <#else>
                    <div class="btn-group" id="beforeLogin">
                        <!-- 로그인 전 시작 -->
                        <a href="#" class="a-link" data-toggle="modal" data-target="#login-md">로그인</a>
                        <span class="side-line">l</span>
                        <a href="#" class="a-link" data-toggle="modal" data-target="#join-md">회원가입</a>
                        <!-- 로그인 전 끝 -->
                    </div>
                </#if>
            </div>
        </div>
    </div>
</div>