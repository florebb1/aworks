<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<div class="sub-title-bg background-base-code background-h4">
    <@spring.message "faq.text1"/>
</div>

<section class="place-wrap">
    <div class="container">
        <div class="row">
            <div class="col">

                <div class="bg-light-gray2 p-4 mb-5">
                    <div class="row d-flex justify-content-center">
                        <div class="col-6">
                            <select id="filter" name="filter" class="form-control family-link-select border-radius-none">
                                <option value="0" <#if filter?number = 0>selected</#if>>전체</option>
                                <option value="1" <#if filter?number = 1>selected</#if>>카테고리1</option>
                                <option value="2" <#if filter?number = 2>selected</#if>>카테고리2</option>
                                <option value="3" <#if filter?number = 3>selected</#if>>카테고리3</option>
                                <option value="4" <#if filter?number = 4>selected</#if>>카테고리4</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="card contact-area">
                    <#if faqCount?number gt 0>
                        <#assign i = 1>
                        <#list faq as row>
                            <a class="contact-area-in collapsed" data-toggle="collapse" data-target="#collapse${i}" aria-expanded="false" aria-controls="collapse${i}">
                                <div class="row">
                                    <div class="col-1 d-flex justify-content-center align-items-center">
                                        <div class="contact-label">Q.</div>
                                    </div>
                                    <div class="col-10">
                                        <h5 class="font-w500">${row.title}</h5>
                                    </div>
                                    <div class="col-1 d-flex justify-content-center align-items-center">
                                        <i class="icon-down-arrow font32 span-gray-color"></i>
                                    </div>
                                </div>
                            </a>
                            <div id="collapse${i}" class="collapse" aria-labelledby="heading${i}" data-parent="">
                                <div class="collapse-re-wrap">
                                    <div class="mb-3">${row.content}</div>
                                    <div class="name-area">
                                        <span>관리자</span>
                                        <span>l</span>
                                        <span>${row.createDatetime?string["YYYY-MM-dd"]}</span>
                                    </div>
                                </div>
                            </div>
                            <#assign i = i + 1>
                        </#list>
                    <#else>
                        <div class="minh-480 d-flex justify-content-center align-items-center"><@spring.message "faq.text3"/></div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</section>        

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(document).ready(function(){
        $('#filter').change(function(){
            var filter = $('#filter').val();
            location.href='/faq?filter='+filter;
        });
    });
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">