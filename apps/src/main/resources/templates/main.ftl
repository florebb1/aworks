<#include "/layout/base.ftl">
<#include "/layout/header.ftl">
<section class="main-hero d-flex flex-column justify-content-center align-items-center">
    <h1>a.works Repository</h1>
    <div class="mb-3"><@spring.message "main.text1"/></div>
    <button type="button" class="btn btn-outline-light"><@spring.message "main.text2"/></button>
</section>

<section class="popularity-app">
    <div class="container">

        <div class="row">
            <div class="col text-center pb-5">
                <h4><@spring.message "main.text3"/></h4>
            </div>
        </div>

        <div class="row">
            <#if popular?size gt 0>
                <#assign num=1>
                <#list popular as row>
                    <#if row.ratingAvg??>
                        <#assign rating=row.ratingAvg?number/ 5 * 100 >
                    <#else>
                        <#assign rating = 0>
                    </#if>
                    <div class="col-3">
                        <a href="/market/view?marketId=${row.seq?c}" class="card">
                        <#if row.security?number gt 0>
                            <span class="certification" data-toggle="tooltip" data-placement="top" title="a.works Certification">
                                <i class="icon-security-on font28"></i>
                            </span>
                        </#if>
                        <div class="rankmark d-flex justify-content-center align-items-center">
                            <span>TOP${num}</span>
                        </div>
                        <div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">
                            <img src="/assets/images/kcu.png" alt="...">
                            <h5 class="card-title mt-3">${row.appName}</h5>
                        </div>
                        <hr>
                        <div class="card-body minh-150 text-center">
                            <#if row.appType?number=0>
                                <h5 class="card-title">Process</h5>
                            <#elseif row.appType?number=1>
                                <h5 class="card-title">Task</h5>
                            <#elseif row.appType?number=2>
                                <h5 class="card-title">Event Item</h5>
                            <#elseif row.appType?number=3>
                                <h5 class="card-title">Connector</h5>
                            </#if>
                            <#if row.summary??>
                                <div class="line-content">${row.summary}</div>
                            <#else>
                                <div class="line-content"><@spring.message "main.text4"/></div>
                            </#if>
                            <#if row.lastUpdate??>
                                <p class="date-content">Update ${row.lastUpdate?string["YYYY-MM-dd"]}</p>
                            <#else>
                                <p class="date-content">Update ${row.createDatetime?string["yyyy-MM-dd"]}</p>
                            </#if>
                        </div>
                        <hr>
                        <div class="row pl-3 pr-3 pb-3 card-point">
                            <#--<div class="col text-left">-->
                                <#--<div class="star-rating"><span style="width:${rating}%;"></span></div>-->
                            <#--</div>-->
                            <div class="col text-center">
                                <span>
                                    <i class="icon-download_log mr-1"></i> ${row.downloadCnt}
                                </span>
                                <span class="ml-3">
                                    <i class="icon-Thumbsup mr-1"></i> ${row.likeCnt}
                                </span>
                            </div>
                        </div>
                        </a>
                    </div>
                <#assign num=num+1>
                </#list>
            <#else>
                <div class="col minh-360 d-flex flex-column justify-content-center align-items-center">
                    <span class="no-content-box mb-3">
                        <i class="icon-box font36"></i>
                    </span>
                    <span class="no-content-text"><@spring.message "main.text5"/></span>
                </div>
            </#if>
        </div>

        <div class="row">
            <div class="col text-center mt-5 more-btn">
                <a href="/market?chk=2"><@spring.message "main.text6"/></a>
            </div>
        </div>

    </div>
</section>

<section class="recommended-item">
    <div class="container h-100">
        <div class="row">
            <div class="col-3">
                <div class="recommended-item-card d-flex flex-column justify-content-center align-items-start">
                    <h2><@spring.message "main.text7"/></h2>
                    <div class="min-width160"><@spring.message "main.text8"/></div>
                </div>
            </div>
            <div class="col-9">

                <div id="recipeCarousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner row" role="listbox">
                    <#if recomm?size gt 0>
                        <#assign num = 1>
                        <#list recomm as row>
                            <#if row.ratingAvg??>
                                <#assign rating=row.ratingAvg?number/ 5 * 100 >
                            <#else>
                                <#assign rating = 0>
                            </#if>
                            <#if num = 1>
                                <div class="carousel-item active">
                            <#else>
                                <div class="carousel-item">
                            </#if>
                                <a href="/market/view?marketId=${row.seq?c}" class="col-4 card">
                                    <#if row.security?number gt 0>
                                        <span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">
                                            <i class="icon-security-on font28"></i>
                                        </span>
                                    </#if>
                                <div class="rankmark d-flex justify-content-center align-items-center">
                                    <span>TOP${num}</span>
                                </div>
                                <div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">
                                    <img src="/assets/images/kcu.png" alt="...">
                                    <h5 class="card-title mt-3">${row.appName}</h5>
                                </div>
                                <hr>
                                <div class="card-body minh-160 text-center">
                                    <#if row.appType?number=0>
                                        <h5 class="card-title">Process</h5>
                                    <#elseif row.appType?number=1>
                                        <h5 class="card-title">Task</h5>
                                    <#elseif row.appType?number=2>
                                        <h5 class="card-title">Event Item</h5>
                                    <#elseif row.appType?number=3>
                                        <h5 class="card-title">Connector</h5>
                                    </#if>
                                    <#if row.summary??>
                                        <p class="line-content">${row.summary}</p>
                                    <#else>
                                        <p class="line-content"><@spring.message "main.text4"/></p>
                                    </#if>
                                    <#if row.lastUpdate??>
                                        <p class="date-content">Update ${row.lastUpdate?string["YYYY-MM-dd"]}</p>
                                    <#else>
                                        <p class="date-content">Update ${row.createDatetime?string["yyyy-MM-dd"]}</p>
                                    </#if>
                                </div>
                                <hr>
                                <div class="row pl-3 pr-3 pb-3 card-point">
<#--                                    <div class="col text-left">-->
<#--                                        <div class="star-rating"><span style="width:${rating}%;"></span></div>-->
<#--                                    </div>-->
                                    <div class="col text-center">
                                        <span>
                                            <i class="icon-download_log mr-1"></i> ${row.downloadCnt}
                                        </span>
                                        <span class="ml-3">
                                            <i class="icon-Thumbsup mr-1"></i> ${row.likeCnt}
                                        </span>
                                    </div>

                                </div>
                                </a>
                            </div>
                            <#assign num = num+1>
                        </#list>
                    <#else>
                        <div class="col minh-360 d-flex flex-column justify-content-center align-items-center">
                            <span class="no-content-box mb-3">
                                <i class="icon-box font36"></i>
                            </span>
                            <span class="no-content-text"><@spring.message "main.text5"/></span>
                        </div>
                    </#if>
                    </div>
                    <#if recomm?size gt 3>
                        <a class="carousel-control-prev" href="#recipeCarousel" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#recipeCarousel" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </#if>
                </div>

            </div>
        </div>
    </div>
</section>


<section class="new-update-app">
    <div class="container">
        <div class="row">
            <div class="col text-center pb-5">
                <h4><@spring.message "main.text9"/></h4>
            </div>
        </div>
        <div class="row">
        <#if update?size gt 0>
            <#list update as row>
                <#if row.ratingAvg??>
                    <#assign rating=row.ratingAvg?number/ 5 * 100 >
                <#else>
                    <#assign rating = 0>
                </#if>
                <div class="col-4">
                    <a href="/market/view?marketId=${row.seq?c}" class="card"">
                    <div class="card-body">
                        <#if row.security??>
                        <#if row.security?number gt 0>
                            <span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">
                                <i class="icon-security-on font28"></i>
                            </span>
                        </#if>
                        </#if>
                        <div class="newmark d-flex justify-content-center align-items-center">
                            <span>NEW</span>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <div class="category-img d-flex flex-column justify-content-center align-items-center pr-1">
                                    <img src="/assets/images/kcu.png" alt="...">
                                    <h5 class="card-title h5-no-wrap mt-3">${row.appName}</h5>
                                </div>
                            </div>
                            <div class="col-8 column-left-area">
                                <#if row.appType?number=0>
                                    <h5 class="card-title mt-3">Process</h5>
                                <#elseif row.appType?number=1>
                                    <h5 class="card-title mt-3">Task</h5>
                                <#elseif row.appType?number=2>
                                    <h5 class="card-title mt-3">Event Item</h5>
                                <#elseif row.appType?number=3>
                                    <h5 class="card-title mt-3">Connector</h5>
                                </#if>
                                <#if row.summary??>
                                    <div class="line-content2">${row.summary}</div>
                                <#else>
                                    <div class="line-content2"><@spring.message "main.text4"/></div>
                                </#if>
                                <#if row.lastUpdate??>
                                    <p class="date-content">Update ${row.lastUpdate?string["YYYY-MM-dd"]}</p>
                                </#if>
                                <div class="row pt-2 card-point">
                                    <#--<div class="col text-left">-->
                                        <#--<div class="star-rating"><span style="width:${rating}%;"></span></div>-->
                                    <#--</div>-->

                                    <div class="col">
                                        <span>
                                            <i class="icon-download_log mr-1"></i> ${row.downloadCnt}
                                        </span>
                                        <span class="ml-3">
                                            <i class="icon-Thumbsup mr-1"></i> ${row.likeCnt}
                                        </span>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                    </a>
                </div>
            </#list>
        <#else>
            <div class="col minh-360 d-flex flex-column justify-content-center align-items-center">
                <span class="no-content-box mb-3">
                    <i class="icon-box font36"></i>
                </span>
                <span class="no-content-text"><@spring.message "main.text10"/></span>
            </div>
        </#if>
        </div>
        <div class="row">
            <div class="col text-center mt-5 more-btn">
                <a href="/market?chk=1"><@spring.message "main.text6"/></a>
            </div>
        </div>
    </div>
</section>

<section class="popularity-app">
    <div class="container">
        <div class="row">
            <div class="col text-center pb-5">
                <h4><@spring.message "main.text11"/></h4>
            </div>
        </div>
        <div class="row">
            <#if notice?size gt 0>
                <#assign i = 1>
                <#list notice as row>
                    <div class="col-12 mb-3">
                        <a href="/board/view?noticeId=${row.seq?c}" class="card">
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
                <div class="col minh-360 d-flex flex-column justify-content-center align-items-center">
                    <span class="no-content-box mb-3">
                        <i class="icon-announcement font36"></i>
                    </span>
                    <span class="no-content-text"><@spring.message "main.text12"/></span>
                </div>
            </#if>
        </div>
    </div>
</section>

<section class="contract-area">
    <div class="container h-100">
        <div class="row h-100">
            <div class="col d-flex flex-column justify-content-center align-items-start">
                <h5><@spring.message "main.text13"/></h5>
                <div><@spring.message "main.text14"/></div>
            </div>
            <div class="col d-flex justify-content-end align-items-center">
                <button type="button" class="btn btn-outline-dark"><@spring.message "main.text15"/></button>
            </div>
        </div>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $( document ).ready(function() {
        <#if notice?size gt 0>
        <#assign i = 1>
            <#list notice as row>
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