<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<div class="sub-title-bg background-base-code background-h4">
    교육안내
</div>

<#--<section class="subpage-wrap-none">-->
    <#--<div class="container">-->
        <#--<div class="row d-flex justify-content-center">-->
            <#--<div class="col-3">-->
                <#--<div class="border p-5 text-center">-->
                    <#--<div><img src="/assets/images/icon/youtube.png" class="w-25 mb-3"/></div>-->
                    <#--<h5>교육자료 1</h5>-->
                <#--</div>-->
            <#--</div>-->
            <#--<div class="col-3">-->
                <#--<div class="border p-5 text-center">-->
                    <#--<div><img src="/assets/images/icon/youtube.png" class="w-25 mb-3"/></div>-->
                    <#--<h5>교육자료 2</h5>-->
                <#--</div>-->
            <#--</div>-->
            <#--<div class="col-3">-->
                <#--<div class="border p-5 text-center">-->
                    <#--<div><img src="/assets/images/icon/youtube.png" class="w-25 mb-3"/></div>-->
                    <#--<h5>교육자료 3</h5>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
<#--</section>-->

<section class="subpage-wrap-bluegray">
    <div class="container">
        <div class="row">
            <div class="col">
                <h3 class="subpage-title">솔루션 교육 안내</h3>
                <div class="subpage-content">교육 인원 제한이 있어 선착순으로 교육 참석이 가능합니다. 1:1문의로 신청하시면 담당자가 연락드리도록 하겠습니다.</div>
            </div>
        </div>
        <div class="row d-flex justify-content-center mt-5 py-5">
            <div class="col-8">
                <div class="border p-5 bg-white">
                    <h3>솔루션 교육 안내</h3>
                    <div class="ullih">
                        <ul>
                            <li>장소 : 포스코ICT 판교 교육장</li>
                            <#--<li>일정 : 7.24~25일</li>-->
                            <li>준비물 : 없음. 교육용 노트북 및 교육자료 제공</li>
                            <li>1일차 : A.WORKS 솔루션 구성 및 주요 특징 / Studio 기능 및 조작 방법 설명</li>
                            <li>2일차  : Studio 개발 실습(인터넷, 메일, 엑셀 등)</li>
                        </ul>
                    </div>
                    <h3>2019년 솔루션 교육일정</h3>
                    <div class="ullih">
                        <ul>
                            <li>09월 : 9.26~9.27</li>
                            <#--<li>일정 : 7.24~25일</li>-->
                            <li>10월 : 10.22~10.23</li>
                            <li>11월 : 11.20~11.21</li>
                            <li>12월 : 12.17~12.18</li>
                        </ul>
                    </div>
                    <div class="text-center">
                        <#if s_user.s_seq?c?number gt 0>
                            <a class="btn btn-outline-info border-radius-none btn-lg mt-3" id="direct" href="/qna" role="button">교육신청</a>
                        <#else>
                            <a class="btn btn-outline-info border-radius-none btn-lg mt-3" href="void(0);" onclick="$('#login-md').modal('show');return false;" role="button">교육신청</a>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>



<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">