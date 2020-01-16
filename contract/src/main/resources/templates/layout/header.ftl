<div class="new-header">
    <div class="new-header-in">
        <div class="d-flex d-flex justify-content-center">
            <div class="new-logo d-flex justify-content-start align-items-center">
                <a href="/">
                    <i class="icon-logo font18"></i>
                </a>
            </div>    
            <div class="new-menu d-flex justify-content-center">
                <div>
                    <a href="/rpa">RPA</a>
                    <a href="/rpa">Digital Labor</a>
                    <a href="/applied">Use Case</a>
                    <a href="/grafting">AI Connected</a>
                </div>
                <div>
                    <a href="/features">제품소개</a>
                    <a href="/features">Major Features</a>
                    <a href="/solution">Solution Set</a>
                    <a href="/studio">Studio</a>
                    <a href="/robot">Robot/Mini</a>
                    <a href="/work_center">WorkCenter</a>
                    <a href="/repository">Repository</a>
                </div>
                <div>
                    <a href="/news_list">뉴스룸</a>
                    <a href="/news_list">News</a>
                    <a href="/partner">Partners</a>
                </div>
                <div>
                    <a href="/faq">고객지원</a>
                    <a href="/faq">FAQ</a>
                    <a href="/education">교육안내</a>
                    <#if s_user.s_seq?c?number gt 0>
                        <a id="direct" href="/qna">1:1 문의</a>
                    <#else>
                        <a href="void(0);" onclick="$('#login-md').modal('show');return false;">1:1 문의</a>
                    </#if>
                    <a href="/contactus">Contact Us</a>
                </div>
                <div>
                    <a href="/download">다운로드</a>
                    <a href="/download">Trial Download</a>
                    <a href="/release_note">Release Note</a>
                    <#--<a href="/manual">User Manuals</a>-->
                </div>
                <#--  <div>
                    <a href="/rpa"><@spring.message "header.text1"/></a>
                    <a href="/rpa"><@spring.message "header.text8"/></a>
                </div>
                <div>
                    <a href="/why"><@spring.message "header.text2"/></a>
                    <a href="/why"><@spring.message "header.text9"/></a>
                    <a href="/platform"><@spring.message "header.text10"/></a>
                    <a href="/studio"><@spring.message "header.text11"/></a>
                    <a href="/robot"><@spring.message "header.text12"/></a>
                    <a href="/work_center"><@spring.message "header.text13"/></a>
                    <a href="/repository"><@spring.message "header.text14"/></a>
                </div>
                <div>
                    <a href="/cloud_manual"><@spring.message "header.text4"/></a>
                    <a href="/cloud_manual#cloud"><@spring.message "header.text16"/></a>
                    <a href="/cloud_manual#onpremise"><@spring.message "header.text17"/></a>
                </div>
                <div>
                    <a href="/partner">파트너</a>
                    <a href="/partner">파트너</a>
                </div>
                <div>
                    <a href="/news_list"><@spring.message "header.text5"/></a>
                    <a href="/news_list"><@spring.message "header.text18"/></a>
                </div>
                <div>
                    <a href="/faq"><@spring.message "header.text6"/></a>
                    <a href="/faq"><@spring.message "header.text20"/></a>
                    <#if s_user.s_seq?number gt 0>
                        <a id="direct" href="/qna"><@spring.message "header.text21"/></a>
                    <#else>
                        <a href="void(0);" onclick="$('#login-md').modal('show');return false;"><@spring.message "header.text21"/></a>
                    </#if>
                    <a href="/manual"><@spring.message "header.text22"/></a>
                    <a href="/release_note">Release Note</a>
                </div>
                <div>
                    <a id="trial" class="menu-box" href="/download"><@spring.message "header.text7"/></a>
                    <a id="trial" href="/download"><@spring.message "header.text23"/></a>
                </div>  -->
            </div>
            <div class="new-user d-flex justify-content-end align-items-center">
                <div class="btn-group">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <@spring.message "header.text24"/>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="?language=ko_KR">
                            <i class="icon-south-korea mr-1">
                                <i class="path1"></i><i class="path2"></i><i class="path3"></i><i class="path4"></i><i class="path5"></i><i class="path6"></i><i class="path7"></i><i class="path8"></i><i class="path9"></i><i class="path10"></i><i class="path11"></i><i class="path12"></i><i class="path13"></i><i class="path14"></i><i class="path15"></i><i class="path16"></i><i class="path17"></i><i class="path18"></i><i class="path19"></i><i class="path20"></i><i class="path21"></i>
                            </i>
                            KOR
                        </a>
                        <#--<a class="dropdown-item" href="?language=en_US">-->
                            <#--<i class="icon-united-states mr-1">-->
                                <#--<i class="path1"></i><i class="path2"></i><i class="path3"></i><i class="path4"></i><i class="path5"></i><i class="path6"></i>-->
                            <#--</i>-->
                            <#--ENG-->
                        <#--</a>-->
                    </div>
                </div>
                <span>ㅣ</span>
                <#if s_user.s_seq?c?number &gt; 0>
                    <div class="btn-group" id="afterLogin">
                        <a href="#" class="dropdown-toggle profile-img-arrow" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <#if s_user.s_profileImg?exists && s_user.s_profileImg != ''>
                                <span id="profileImg" class="user-img" style="background-image:url('${s_user.s_profileImg!}');"></span>
                            <#else>
                                <span id="profileImg" class="user-img" style="background-image:url('/assets/images/profile-sample.png');"></span>
                            </#if>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <#if s_user.s_level?number = 2>
                                <div class="dropdown-user-info"><span id="user">${s_user.s_loginId!}</span><@spring.message "header.text25"/></div>
                                <a class="dropdown-item" href="/mypage/user_modify"><@spring.message "header.text26"/></a>
                                <a class="dropdown-item" href="/mypage/contract_management_info"><@spring.message "header.text27"/></a>
                                <a id="onetooneList" class="dropdown-item" href="/mypage/qna_list"><@spring.message "header.text28"/></a>
                                <span  class="dropdown-item" onclick="document.location.href='/api/logout'"><@spring.message "header.text29"/></span>
                            <#else>
                                <#if s_user.s_seq?c?number = 2826>
                                    <div class="dropdown-user-info"><span id="user">${s_user.s_loginId!}</span><@spring.message "header.text25"/></div>
                                    <a class="dropdown-item" href="/mypage/wc_download">WC_DOWNLOAD</a>
                                    <a class="dropdown-item" href="/mypage/user_modify"><@spring.message "header.text26"/></a>
                                    <a id="onetooneList" class="dropdown-item" href="/mypage/qna_list"><@spring.message "header.text28"/></a>
                                    <span  class="dropdown-item" onclick="document.location.href='/api/logout'"><@spring.message "header.text29"/></span>
                                <#else>
                                    <div class="dropdown-user-info"><span id="user">${s_user.s_loginId!}</span><@spring.message "header.text25"/></div>
                                    <a class="dropdown-item" href="/mypage/user_modify"><@spring.message "header.text26"/></a>
                                    <a id="onetooneList" class="dropdown-item" href="/mypage/qna_list"><@spring.message "header.text28"/></a>
                                    <span  class="dropdown-item" onclick="document.location.href='/api/logout'"><@spring.message "header.text29"/></span>
                                </#if>

                            </#if>
                        </div>
                    </div>
                <#else>
                <a href="#" data-toggle="modal" data-backdrop="static" data-target="#login-md"><@spring.message "header.text30"/></a>
                <span>ㅣ</span>
                <a href="#" data-toggle="modal" data-backdrop="static" data-target="#join-md"><@spring.message "header.text31"/></a>
                </#if>
            </div>
        </div>
    </div>
</div>