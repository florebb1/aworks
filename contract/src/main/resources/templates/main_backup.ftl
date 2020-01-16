<#include "/layout/base.ftl">
<#include "/layout/header.ftl">

<nav class="navigation" id="mainNav">
    <a class="navigation__link" href="#1"></a>
    <a class="navigation__link" href="#2"></a>
    <a class="navigation__link" href="#3"></a>
    <a class="navigation__link" href="#4"></a>
    <a class="navigation__link" href="#5"></a>
</nav>

<a href="#1" class="top-move-arrow"><i class="icon-arrow-thin-up"></i></a>

<div class="page-section main-hero01 d-flex flex-column justify-content-center align-items-center" id="1" style="background-image:url(/assets/images/section01.jpg);">
    <img src="/assets/images/ni-logo.png" class="mb-4"/>
    <h1>Automation, Easy To Start</h1>
    <div>a.works, Release on May 1st 2019</div>
    <div class="row w-100 mt-5">
        <div class="col d-flex flex-row justify-content-center">

            <a href="#" data-toggle="modal" data-backdrop="static" data-target="#contactus-lg" class="btn btn-outline-light btn-border-radius-none min-width200 btn-lg mr-2">서비스 가입하기</a>
            <a href="/download" id="asdf" class="btn btn-outline-light btn-border-radius-none min-width200 btn-lg ml-2">무료체험하기</a>

        </div>
    </div>
<#--  
    <div class="btn-group mt-3" role="group" aria-label="Basic example">
        <button class="main1-a-button">image1</button>
        <button class="main1-b-button">image2</button>
        <button class="main1-c-button">image3</button>
    </div>  -->

    <div class="main-visual-mouse"></div>
</div>
<div class="page-section main-hero02 d-flex flex-column justify-content-center align-items-center" id="2">
    <div class="main-container">
        <div class="form-row">
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <img src="/assets/images/main_01.png" class="w-100"/>
            </div>
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <div class="side-content-layout p-5">
                    <h2 class="px-5 py-3">쉽고 빠른 개발</h2>
                    <div class="px-5 py-3">
                        <ul class="m-0 p-0">
                            <li class="m-0 p-0 py-3">Use Case Template을 활용하는 것으로, 쉽게 자동화를 구현할 수 있습니다.</li>
                            <li class="m-0 p-0 py-3">현업담당자가 직접 직관적 UI/UX, 간단한 마우스 조작을 통해 자동화 Script를 생성할 수 있습니다.</li>
                        </ul>
                    </div>
                    <div class="px-5 py-3">
                        <a href="/download" class="btn btn-info btn-border-radius-none min-width200 btn-lg">Studio</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#--  <img src="/assets/images/a01.png" class="mb-3"/>
    <h1 class="text-center">이제는 쉽고 편리하게<br>a.works로 RPA서비스를 시작해 보세요</h1>
    <div class="mt-3">워크 타임을 단축시켜 남은 시간을 효율적으로 활용합니다.</div>  -->

    <#--  <div class="btn-group mt-3" role="group" aria-label="Basic example">
        <button class="main2-a-button">image1</button>
        <button class="main2-b-button">image2</button>
        <button class="main2-c-button">image3</button>
    </div>  -->

</div>
<div class="page-section main-hero03 d-flex flex-column justify-content-center align-items-center" id="3">
    <div class="main-container">
        <div class="form-row">
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <div class="side-content-layout p-5">
                    <h2 class="px-5 py-3">실시간 모니터링</h2>
                    <div class="px-5 py-3">
                        <ul class="m-0 p-0">
                            <li class="m-0 p-0 py-3">로봇은 사용자가 정한 스케줄에 따라 실수없이 업무를 실행합니다.</li>
                            <li class="m-0 p-0 py-3">로봇의 업무 진행 상황은 a.works mini를 통해 실시간 파악할 수 있습니다.<br>사용자는 직접 로봇을 컨트롤할 수도 있습니다.</li>
                        </ul>
                    </div>
                    <div class="px-5 py-3">
                        <a href="/download" class="btn btn-info btn-border-radius-none min-width200 btn-lg">a.works mini</a>
                    </div>
                </div>
            </div>
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <img src="/assets/images/main_02.png" class="w-100"/>
            </div>
        </div>
    </div>

    <#--  <img src="/assets/images/a02.png" class="mb-3"/>
    <h1 class="text-center">스캔 된 PDF를 WORD로 변환해 보세요</h1>
    <div class="mt-3">OCR시스템의 적용으로 불필요한 타이핑은 줄어듭니다.</div>  -->

    <#--  <div class="btn-group mt-3" role="group" aria-label="Basic example">
        <button class="main3-a-button">image1</button>
        <button class="main3-b-button">image2</button>
        <button class="main3-c-button">image3</button>
    </div>  -->

</div>
<div class="page-section main-hero04 d-flex flex-column justify-content-center align-items-center" id="4">
    <div class="main-container">
        <div class="form-row">
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <img src="/assets/images/main_03.png" class="w-100"/>
            </div>
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <div class="side-content-layout p-5">
                    <h2 class="px-5 py-3">고객 맞춤 도입 전략</h2>
                    <div class="px-5 py-3">
                        <ul class="m-0 p-0">
                            <li class="m-0 p-0 py-3">고객의 사용 환경에 최적화된 구축형 RPA와 사용한 만큼만 비용을 지불하는 Cloud RPA, 두가지 version을 제공합니다.</li>
                            <li class="m-0 p-0 py-3">니즈와 예산에 맞는 도입, 운영 전략을 지원합니다.</li>
                        </ul>
                    </div>
                    <div class="px-5 py-3">
                        <a href="/download" class="btn btn-info btn-border-radius-none min-width200 btn-lg">Platform</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#--  <img src="/assets/images/a03.png" class="mb-3"/>
    <h1 class="text-center">지속적인 연구, 최적화된 UI/UX로<br>누구나 사용하기 쉽습니다</h1>
    <div class="mt-3">편리한 사용 경험을 제공하기 위한 UI/UX에 대한 고민은 지속적으로 이루어집니다.</div>  -->

    <#--  <div class="btn-group mt-3" role="group" aria-label="Basic example">
        <button class="main4-a-button">image1</button>
        <button class="main4-b-button">image2</button>
        <button class="main4-c-button">image3</button>
    </div>  -->

</div>
<div class="page-section main-hero05 d-flex flex-column justify-content-center align-items-center" id="5" style="background-image:url(/assets/images/section05.jpg);color:#000000;">
    <div class="main-container">
        <div class="form-row">
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <div class="side-content-layout p-5">
                    <h2 class="px-5 py-3">시원한 대용량 처리, 쉬운 유지보수</h2>
                    <div class="px-5 py-3">
                        <ul class="m-0 p-0">
                            <li class="m-0 p-0 py-3">업무량에 따라 대량의 Robot도 쉽게 생성하고 어느 상황에서나 유연하게 운영할 수 있습니다.</li>
                            <li class="m-0 p-0 py-3">Script 구조가 단순하고 이해하기 쉬워, 유지보수도 쉽습니다.</li>
                        </ul>
                    </div>
                    <div class="px-5 py-3">
                        <a href="/download" class="btn btn-info btn-border-radius-none min-width200 btn-lg">Work Center</a>
                    </div>
                </div>
            </div>
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <img src="/assets/images/main_04.png" class="w-100"/>
            </div>
        </div>
    </div>
    <#--  <h1 class="mb-5 text-center">클라우드RPA의 첫 걸음<br>쉽게 시작하세요</h1>
    <iframe width="640" height="380" src="https://www.youtube.com/embed/lNeCTzNRtUs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>  -->
    
    <#--  <div class="btn-group mt-3" role="group" aria-label="Basic example">
        <button class="main5-a-button">image1</button>
        <button class="main5-b-button">image2</button>
        <button class="main5-c-button">image3</button>
    </div>  -->
    
</div>


<section class="contact-area2">
    <div class="container h-100">
        <div class="row h-100">

            <div class="col d-flex flex-column justify-content-center align-items-center h-100">
                <h2>비개발자도 이용할 수 있는 쉬운 프로그램을 경험해보세요</h2>
                <div class="mt-3">
                    <#if s_user.s_seq?number gt 0>
                        <a href="javascript:void(0)" onclick="alert('이미 가입 하셨습니다.')" class="btn btn-outline-light btn-border-radius-none mr-3">서비스 가입 바로가기</a>
                    <#else>
                        <a href="#" data-toggle="modal" data-backdrop="static" data-target="#join-md" class="btn btn-outline-light btn-border-radius-none mr-3">서비스 가입 바로가기</a>
                    </#if>
                    <#if s_user.s_seq?number gt 0>
                        <a href="/qna" id="direct" class="btn btn-outline-light btn-border-radius-none">문의 바로가기</a>
                    <#else>
                        <a href="void(0);" onclick="$('#login-md').modal('show');return false;" class="btn btn-outline-light btn-border-radius-none">문의 바로가기</a>
                    </#if>
                </div>
            </div>

            <#--  <div class="col d-flex flex-column justify-content-center align-items-start contract-area-left-bg" style="background-image:url('/assets/images/section06-left.png');">
            </div>  -->
            <#--  <div class="col d-flex flex-column justify-content-center align-items-center">
                <div class="mb-3">비개발자도 이용할 수 있는 쉬운 프로그램을 경험해보세요</div>
                <button type="button" class="btn btn-outline-dark">문의 바로가기</button>
            </div>  -->
            <#--  <div class="col-auto d-flex flex-row justify-content-end align-items-center">
                <div class="mr-5 text-right">비개발자도 이용할 수 있는 쉬운 프로그램을 경험하고<br>a.works 정회원에 가입하고 다양한 혜택과 정보를 이용해보세요</div>
                <#if s_user.s_seq?number gt 0>
                    <a href="javascript:void(0)" onclick="alert('이미 가입 하셨습니다.')" class="btn btn-outline-info btn-border-radius-none mr-3">서비스 가입 바로가기</a>
                <#else>
                    <a href="#" data-toggle="modal" data-backdrop="static" data-target="#join-md" class="btn btn-outline-info btn-border-radius-none mr-3">서비스 가입 바로가기</a>
                </#if>
                <#if s_user.s_seq?number gt 0>
                    <a href="/qna" id="direct" class="btn btn-outline-info btn-border-radius-none">문의 바로가기</a>
                <#else>
                    <a href="void(0);" onclick="$('#login-md').modal('show');return false;" class="btn btn-outline-info btn-border-radius-none">문의 바로가기</a>
                </#if>
            </div>  -->
        </div>
    </div>
</section>


<div class="modal fade" id="contactus-lg" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content border-radius-none">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">문의하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form id="contactusFrm" class="pl-3 pr-3 pt-4 pb-4" autocomplete="new-password">
                    <div style="position: absolute;left:-9999px; display:none;">

                        <input type="text" id="tricId2" name="tricId" placeholder="입력하세요.">

                        <input type="password" id="tricPwd2" name="tricPwd" placeholder="입력하세요.">

                    </div>
                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">이름</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="contactusName" name="name" aria-describedby="passwordHelp" placeholder="이름을 입력해 주세요." autocomplete="new-password">
                            <small id="contactusNameStr" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">이메일</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="contactusEmail" name="email" placeholder="이메일 주소를 입력해 주세요." autocomplete="off">
                            <small id="contactusEmailStr" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">회사명</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="contactusComName" name="comName" aria-describedby="passwordHelp" placeholder="회사명을 입력해 주세요." autocomplete="new-password">
                            <small id="contactusComNameStr" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">연락처</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="contactusPhone" name="comPhone" aria-describedby="passwordHelp" placeholder="연락처를 입력해 주세요" autocomplete="new-password">
                            <small id="contactusPhoneStr" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">문의내용</span>
                        </div>
                        <div class="col-7">
                            <textarea class="form-control" name="content" id="contactusContent" style="height:150px"></textarea>
                            <small id="contactusContentStr" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                </form>
                <hr class="mt-0 mb-4">
                <div class="privacy-text text-center pt-2 mb-3">
                    확인 버튼을 클릭하면 a.works의 <a href="#">약관</a>, <a href="#">데이터 정책</a> 및 <a href="#">쿠키 정책</a>에 동의하게 됩니다.<br>
                    a.works로부터 SMS 알림을 받을 수 있으며 알림은 언제든지 수신거부할 수 있습니다.
                </div>

            </div>
            <div class="modal-footer justify-content-center align-items-center">
                <button type="button" class="btn btn btn-secondary border-radius-none" data-dismiss="modal">취소</button>
                <button type="button" id="btnContactus" class="btn btn-info border-radius-none">확인</button>
            </div>
        </div>
    </div>
</div>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    function appRating(rating) {
        var result = rating / 5 * 100;
        return result;
    }
</script>
    <script src="/assets/js/main/main.js"></script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">