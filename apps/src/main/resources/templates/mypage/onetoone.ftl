<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">
<#import "../pagination.ftl" as pagination />

<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "onetoone.text1"/></h1>
    <div><@spring.message "onetoone.text2"/></div>
</section>

<section class="place-wrap">
    <div class="container">
        <div class="row">
            <div class="col-12 mb-3">
                <div class="card contact-area">
                    <#if results?size gt 0>
                        <#assign i = 1>
                        <#list results as row>
                            <#if row.qnaType?number = 0 || row.qnaType?number = 2>
                                <a data-toggle="collapse" href="#contact${i}" role="button" aria-expanded="false" aria-controls="contact${i}" class="contact-area-in collapsed">
                                    <div class="row">
                                        <div class="col-1 d-flex justify-content-center align-items-start">
                                            <#if row.answerYn?number = 0>
                                                <div class="contact-label"><@spring.message "onetoone.text3"/></div>
                                            <#else>
                                                <div class="contact-label-active"><@spring.message "onetoone.text4"/></div>
                                            </#if>
                                        </div>
                                        <div class="col-10">
                                            <#if row.qnaType?number = 0>
                                                <h6 class="main-color"><@spring.message "onetoone.text5"/></h6>
                                            <#elseif row.qnaType?number = 2>
                                                <h6 class="main-color"><@spring.message "onetoone.text6"/></h6>
                                            </#if>
                                            <h5 class="font-w700">${row.title}</h5>
                                            <div class="mb-3">${row.content}</div>
                                            <div class="name-area">
                                                <#if row.userName??>
                                                    <span>${row.userName}</span>
                                                <#else>
                                                    <span><@spring.message "onetoone.text7"/></span>
                                                </#if>

                                                <span>l</span>
                                                <span>${row.createDatetime?string["yyyy-MM-dd"]}</span>
                                            </div>
                                        </div>
                                        <div class="col-1 d-flex justify-content-center align-items-center">
                                            <#if row.answerYn?number gt 0>
                                                <i class="icon-down-arrow font32 span-gray-color"></i>
                                            </#if>
                                        </div>
                                    </div>
                                </a>
                                <#if row.answerYn?number gt 0>
                                    <div class="collapse multi-collapse" id="contact${i}">
                                        <div class="collapse-re-wrap">
                                            <div class="mb-3">${row.answerContent}</div>
                                            <#if files??>
                                                <#assign x = 1>
                                                <#list files as file>
                                                    <#if row.seq = file.bbsSeq>
                                                        <a href="/api/fileDownload?fileUrl=${file.fileName}"><@spring.message "onetoone.text8"/>${x}</a>
                                                        <#assign x = x + 1>
                                                    </#if>
                                                </#list>
                                            </#if>
                                            <div class="name-area">
                                                <span><@spring.message "onetoone.text9"/></span>
                                                <span>l</span>
                                                <span>${row.updateDatetime?string["yyyy-MM-dd"]}</span>
                                            </div>

                                        </div>
                                    </div>
                                </#if>
                            <#assign i = i + 1>
                            </#if>
                        </#list>
                    <#else>
                        <div class="minh-480 d-flex flex-column justify-content-center align-items-center">
                            <span class="no-content-box mb-3">
                                <i class="icon-dots-horizontal-double font36"></i>
                            </span>
                            <span class="no-content-text"><@spring.message "onetoone.text10"/></span>
                        </div>
                    </#if>

                </div>
            </div>
        </div>
        <nav aria-label="Page navigation">
            <ul class="pagination d-flex justify-content-center">
                <@pagination.first />
                <@pagination.numbers />
                <@pagination.last />
            </ul>
        </nav>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(document).ready(function () {
        <#if s_user.s_seq?number = 0>
            alert('<@spring.message "onetoone.text11"/>');
            window.history.back();
        </#if>
    });
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">