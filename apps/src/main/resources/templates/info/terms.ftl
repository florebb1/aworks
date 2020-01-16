<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">

<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "terms.text1"/></h1>
    <div><@spring.message "terms.text2"/></div>
</section>

<section class="place-wrap">
    <div class="container">
        <div class="row sub-top-area mb-3">
            <div class="col-2 text-left">
            </div>
        </div>
    </div>
</div>

<section class="place-wrap bg-light-gray pt-5 pb-5">
    <div class="container p-5">
        <div class="row">
            <div class="col text-center">
                <svg class="bd-placeholder-img" width="100%" height="680px" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: 140x140"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"></rect><text x="50%" y="50%" fill="#ffffff" dy=".3em">140x140</text></svg>
            </div>
        </div>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script type="text/javascript" src="/assets/js/market/list.js"></script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">