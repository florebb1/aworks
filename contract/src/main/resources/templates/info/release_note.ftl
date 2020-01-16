<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<#--<div class="page-title-section">-->
<#--    <div class="container">-->
<#--        <div class="row">-->
<#--            <div class="col text-center">-->
<#--                <h1 class="main-title-h1">Release Note</h1>-->
<#--                <h2 class="main-title-h2">a.works의 최신 업데이트 내역을 확인하세요.</h2>-->
<#--            </div>-->
<#--        </div>-->
<#--    </div>-->
<#--</div>-->

<div class="sub-title-bg background-base-code background-h2">
    Release Note
</div>

<section class="subpage-wrap-none">
    <div class="container">
        <#--  <div class="row">
            <div class="col pt-5">
                <h3 class="subpage-title">릴리스 노트</h3>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col">
                <div class="subpage-content">
                    사용자가 원하는 대로 다양한 IT 환경에서 다양한 어플리케이션과 협업하도록<br>객체, 문자, 이미지 인식 능력을 높이고, 커뮤니케이션 기능을 강화했습니다.
                </div>
            </div>
        </div>  -->

        <div class="row">
            <div class="col white-bg-none">

                <ul class="nav nav-pills nav-justified my-5" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="tab01-tab" data-toggle="tab" href="#tab01" role="tab" aria-controls="tab01" aria-selected="true">Studio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="tab02-tab" data-toggle="tab" href="#tab02" role="tab" aria-controls="tab02" aria-selected="false">Mini</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="tab03-tab" data-toggle="tab" href="#tab03" role="tab" aria-controls="tab03" aria-selected="false">WorkCenter</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="tab01" role="tabpanel" aria-labelledby="tab01-tab">
                        <div class="row d-flex justify-content-center update-list-wrap-note">

                            <!-- 업데이트 내용이 최신순으로 현재 영역이 반복됨 -->
                            <#if releaseNotes1??>
                                <#list releaseNotes1 as row1>
                                <div class="col-11 py-5">
                                    <div class="p-3">
                                        <h3>${row1.title!}</h3>
                                    </div>
                                    <div class="subpage-content2 text-left pl-3">
                                        ${row1.content!}
                                    </div>
                                </div>
                                </#list>
                            <#else>

                            </#if>

                        </div>
                    </div>
                    <div class="tab-pane fade" id="tab02" role="tabpanel" aria-labelledby="tab02-tab">
                        <div class="row d-flex justify-content-center update-list-wrap-note">
                            <#if releaseNotes2??>
                                <#list releaseNotes2 as row1>
                                    <div class="col-11 py-5">
                                        <div class="p-3">
                                            <h3>${row1.title!}</h3>
                                        </div>
                                        <div class="subpage-content2 text-left pl-3">
                                            ${row1.content!}
                                        </div>
                                    </div>
                                </#list>
                            </#if>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tab03" role="tabpanel" aria-labelledby="tab03-tab">
                        <div class="row d-flex justify-content-center update-list-wrap-note">
                            <#if releaseNotes3??>
                                <#list releaseNotes3 as row1>
                                    <div class="col-11 py-5">
                                        <div class="p-3">
                                            <h3>${row1.title!}</h3>
                                        </div>
                                        <div class="subpage-content2 text-left pl-3">
                                            ${row1.content!}
                                        </div>
                                    </div>
                                </#list>
                            </#if>
                            <!-- 업데이트 내용이 최신순으로 현재 영역이 반복됨 -->
                            <#--  <div class="col-11 py-5">
                                <div class="p-3">
                                    <h3>2019년 03월 31일 (긴급 업데이트)</h3>
                                </div>
                                <div class="subpage-content2 text-left pl-3">
                                    <h5 class="mt-3">업데이트 내용</h5>
                                    <ul>
                                        <li>Instant alerts on the status of your automation health and RPA system state for faster response.</li>
                                        <li>Filtering and search of alerts by severity, message, component, and time leads to easy access of detailed information.</li>
                                        <li>Visual and easy to understand dashboards and charts providing performance insights.</li>
                                        <li>Visibility into job and robot status.</li>
                                        <li>Drill down data including type, status and logs for robots, machines, jobs, and schedules.</li>
                                        <li>Graphical view of license usage for better license management.</li>
                                    </ul>
                                    <h5 class="mt-5">기타기능</h5>
                                    <ul>
                                        <li>Instant alerts on the status of your automation health and RPA system state for faster response.</li>
                                        <li>Filtering and search of alerts by severity, message, component, and time leads to easy access of detailed information.</li>
                                        <li>Visual and easy to understand dashboards and charts providing performance insights.</li>
                                        <li>Visibility into job and robot status.</li>
                                        <li>Drill down data including type, status and logs for robots, machines, jobs, and schedules.</li>
                                        <li>Graphical view of license usage for better license management.</li>
                                    </ul>

                                </div>
                            </div>--> <!-- 반복영역 끝 -->

                            <div class="minh-480"></div>

                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</section>

<#--  <section class="subpage-wrap-none">
    <div class="container">
        <div class="row">
            <div class="col">

                    <div class="update-list-wrap-note font18">
                        <div class="row justify-content-center mb-5 pt-5">

                            <div class="col-2">
                                2019년 03월 31일<br>(긴급 업데이트)
                            </div>
                            <div class="col-9">
                                <ul>
                                    <li>Instant alerts on the status of your automation health and RPA system state for faster response.</li>
                                    <li>Filtering and search of alerts by severity, message, component, and time leads to easy access of detailed information.</li>
                                    <li>Visual and easy to understand dashboards and charts providing performance insights.</li>
                                    <li>Visibility into job and robot status.</li>
                                    <li>Drill down data including type, status and logs for robots, machines, jobs, and schedules.</li>
                                    <li>Graphical view of license usage for better license management.</li>
                                </ul>
                            </div>
                        </div>

                        <div class="row justify-content-center mb-5 pt-5">
                            <div class="col-2">
                                2019년 03월 31일<br>(긴급 업데이트)
                            </div>
                            <div class="col-9">
                                <ul>
                                    <li>Instant alerts on the status of your automation health and RPA system state for faster response.</li>
                                    <li>Filtering and search of alerts by severity, message, component, and time leads to easy access of detailed information.</li>
                                    <li>Visual and easy to understand dashboards and charts providing performance insights.</li>
                                    <li>Visibility into job and robot status.</li>
                                    <li>Drill down data including type, status and logs for robots, machines, jobs, and schedules.</li>
                                    <li>Graphical view of license usage for better license management.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

            </div>
        </div>
    </div>
</section>  -->

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">