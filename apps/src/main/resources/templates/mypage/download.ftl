<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">
<#import "../pagination.ftl" as pagination />

<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "download.text1"/></h1>
    <div><@spring.message "download.text2"/></div>
</section>

<section class="place-wrap">
    <div class="container">
        <div class="row">

            <#if results?size gt 0>
                <#assign i = 1>
                <#list results as row>
                    <div class="col-12 mb-3">
                        <#if row.deleteDatetime?? && row.status?number != 0>
                            <a href="javascript:alert('<@spring.message "download.text3"/>');" class="card">
                        <#else>
                            <a href="/market/view?marketId=${row.repositorySeq?number}" class="card">
                        </#if>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-3">
                                        <#if row.appType?number = 0>
                                            <div class="download-scr-img" style="background-image:url('/assets/images/maxresdefault.jpg');"></div>
                                        <#elseif row.appType?number = 1>
                                            <div class="download-scr-img" style="background-image:url('/assets/images/maxresdefault.jpg');"></div>
                                        <#elseif row.appType?number = 2>
                                            <div class="download-scr-img" style="background-image:url('/assets/images/maxresdefault.jpg');"></div>
                                        <#elseif row.appType?number = 3>
                                            <div class="download-scr-img" style="background-image:url('/assets/images/maxresdefault.jpg');"></div>
                                        <#else>
                                            <div class="download-scr-img" style="background-image:url('/assets/images/maxresdefault.jpg');"></div>
                                        </#if>

                                    </div>
                                    <div class="col-9">
                                        <#if row.appType?number = 0>
                                            <h6 class="card-title pt-2 main-color"><@spring.message "market.text11"/></h6>
                                        <#elseif row.appType?number = 1>
                                            <h6 class="card-title pt-2 main-color"><@spring.message "market.text12"/></h6>
                                        <#elseif row.appType?number = 2>
                                            <h6 class="card-title pt-2 main-color"><@spring.message "market.text13"/></h6>
                                        <#elseif row.appType?number = 3>
                                            <h6 class="card-title pt-2 main-color"><@spring.message "market.text14"/></h6>
                                        </#if>
                                        <h5 class="card-title">${row.appName}</h5>
                                        <p id="downloadContent${i}" class="line-content"></p>
                                        <p class="name-area"><@spring.message "download.text4"/> ${row.createDatetime?string["YYYY-MM-dd"]}</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                <#assign i = i + 1>
                </#list>
            <#else>
                <div class="col mb-3">
                    <div class="card minh-480 d-flex flex-column justify-content-center align-items-center">
                        <span class="no-content-box mb-3">
                            <i class="icon-dots-horizontal-double font36"></i>
                        </span>
                        <span class="no-content-text"><@spring.message "download.text5"/></span>
                    </div>
                </div>
            </#if>
    </div>
    <nav aria-label="Page navigation">
        <ul class="pagination d-flex justify-content-center">
            <@pagination.first />
            <@pagination.numbers />
            <@pagination.last />
        </ul>
    </nav>

</section>


<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<#--<script type="text/javascript" src="/assets/js/mypage/download.js">-->
<script>
$( document ).ready(function() {
    <#if s_user.s_seq?number = 0>
        alert("로그인 후 이용가능한 서비스입니다.");
        window.history.back();
    </#if>
    <#if results?size gt 0>
        <#assign i = 1>
        <#list results as row>
            var content${i} = '${row.description}';
            newText${i} = content${i}.replace(/(<([^>]+)>)/ig,"");
            $('#downloadContent${i}').text(newText${i});
            <#assign i = i + 1>
        </#list>
    </#if>
});
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">