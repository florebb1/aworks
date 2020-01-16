<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">
<#import "../pagination.ftl" as pagination />

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
            <#if results?size gt 0>
                <#assign i = 1>
                <#list results as row>
                    <div class="col-12 mb-3">
                        <a href="/board/view?noticeId=${row.seq?number}" class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-1">
                                        <div class="notice-date d-flex flex-column justify-content-center align-items-center h-100 pr-1">
                                            <h3>${row.createDatetime?string["dd"]}</h3>
                                            <p>${row.createDatetime?string["YYYY.MM"]}</p>
                                        </div>
                                    </div>
                                    <div class="col-11 column-left-area2">
                                        <h5 class="card-title pt-2">${row.title}</h5>
                                        <p id="noticeContent${i}" class="line-content3"></p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                <#assign i = i + 1>
                </#list>
            <#else>
                <div class="col minh-360 d-flex justify-content-center align-items-center">
                    <@spring.message "board.text3"/>
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


    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<#--<script type="text/javascript" src="/assets/js/market/view.js">-->
<script>
    $( document ).ready(function() {
        <#if results?size gt 0>
            <#assign i = 1>
            <#list results as row>
                var content${i} = '${row.content}';
                newText${i} = content${i}.replace(/(<([^>]+)>)/ig,"");
                $('#noticeContent${i}').text(newText${i});
                <#assign i = i + 1>
            </#list>
        </#if>
    });
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">