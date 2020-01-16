<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<div class="header-progress">
    <div class="progress-container">
        <div class="page-progress-bar" id="myBar"></div>
    </div>
</div>

<div class="page-title-section">
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h1 class="main-title-h1"><@spring.message "contract.text1"/></h1>
                <h2 class="main-title-h2">"<@spring.message "contract.text2"/>"</h2>
                <#--<div class="main-title-div">-->
                <#--고객의 이용 환경에 맞게 Cloud형과 구축형, PC형 등 다양한 솔루션 패키지로 구성되어 있다.<br>-->
                <#--Cloud형과 구축형은 Work Center를 통해 로봇을 관리하고, 확장 모듈에 대한 업그레이드가 가능하다.<br>-->
                <#--Cloud형은 온라인으로 자동 업그레이드 되고, 구축형(On- Premise)은 직접 설치를 통해 업그레이드를 반영한다.<br>-->
                <#--반면, PC형은 Work Center 대신 a.works Mini를 통해 로봇을 관리하고 확장 모듈에 대한 업그레이드를 지원하지 않는다.<br>-->
                <#--하지만, 3 가지 유형 모두 a.Works Portal 을 통해 무료 교육 컨텐츠를 제공 받을 수 있고,<br>-->
                <#--Ready made Apps 를 다운받을 수 있는 Apps Repository 서비스 이용과 기술지원이 가능하다.-->
                <#--</div>-->
            </div>
        </div>
    </div>
</div>

<section class="place-wrap bg-light-gray pt-5 pb-5">
    <div class="container p-5">
        <div class="row">
            <div class="col text-center">
                <svg class="bd-placeholder-img" width="100%" height="480px" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: 140x140"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"></rect><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
            </div>
        </div>
    </div>
</section>

<section class="place-wrap">
    <div class="container mb-5">
        <div class="row text-center">
            <div class="col">
                <a class="btn btn-outline-info border-radius-none btn-lg mb-5" href="#" role="button"><@spring.message "default.text1"/></a>
            </div>
        </div>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">