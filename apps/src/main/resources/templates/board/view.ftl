<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">

<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "board.text1"/></h1>
    <div><@spring.message "board.text2"/></div>
</section>

<section class="place-wrap">
    <div class="container">

        <div class="row">
            <div class="col-9">

            </div>
        </div>

        <div class="row">
            <div class="col-12 mb-3">
                <div class="notice-body">
                    <h3>${board.title}</h3>
                    <p class="span-gray-color">${board.createDatetime?string["yyyy-MM-dd"]}</p>
                    <#if file??>
                        <#assign i = 1>
                        <#list file as row>
                            <#if row.originalFileName??>
                                <a href="/api/fileDownload?fileUrl=${row.fileName}">${row.originalFileName}</a>
                            <#else>
                                <a href="/api/fileDownload?fileUrl=${row.fileName}"><@spring.message "board.text4"/>${i}</a>
                                <#assign i = i + 1>
                            </#if>
                        </#list>
                    </#if>
                    <hr>
                    <div>${board.content}</div>
                </div>
            </div>

            <div class="col-12 mb-3 text-center">
                <button type="button" class="btn btn-info" onclick="location.replace('/board/list');"><@spring.message "board.text5"/></button>
            </div>

            <div class="col-12 b-afore-notice-wrap">
                <#if board.pre??>
                    <a href="/board/view?noticeId=${board.pre?number}" class="card b-afore-notice">
                        <div class="row">
                            <div class="col-1">
                                <div class="font-w700"><@spring.message "board.text6"/></div>
                            </div>
                            <div class="col-11">
                                <div>${board.preTitle}</div>
                            </div>
                        </div>
                    </a>
                </#if>
                <#if board.nex??>
                    <a href="/board/view?noticeId=${board.nex?number}" class="card b-afore-notice">
                        <div class="row">
                            <div class="col-1">
                                <div class="font-w700"><@spring.message "board.text7"/></div>
                            </div>
                            <div class="col-11">
                                <div>${board.nexTitle}</div>
                            </div>
                        </div>
                    </a>
                </#if>
            </div>
        </div>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<#--<script type="text/javascript" src="/assets/js/market/view.js">-->
<script>
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">