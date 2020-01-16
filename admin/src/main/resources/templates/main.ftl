<#include "/layout/base.ftl">
<!-- Main content -->
<div class="content">

    <div class="container" style="min-width:1020px;">

        <div class="row mb-4">
            <div class="col">
                <div class="dashboard-wrap">
                    <h6>회원 현황</h6><!-- # 계약회원 현황 title -->
                    <div class="w-line-box"><!-- # dashboard grid white box 시작 -->
                        <div class="row">
                            <div class="col d-flex flex-column justify-content-center align-items-center" style="height:160px;"><!-- # 계약회원 현황 좌측 시작 -->
                                <h5>전체 회원</h5>
                                <#--<h1><#if userCnt??>${userCnt.trialUserCnt + userCnt.userCnt + userCnt.contractUserCnt}<#else>0</#if>명</h1>-->
                                <h1><#if userCnt??>${userCnt.userCnt + userCnt.contractUserCnt}<#else>0</#if>명</h1>
                            </div><!-- # 계약회원 현황 좌측 끝 -->
                            <div class="col" style="height:160px;"><!-- # 계약회원 현황 우측 시작 -->
                                <div class="row">
                                    <div class="col-auto" style="height:80px;"><!-- local user 아이콘 -->

                                    </div>
                                    <div class="col d-flex flex-column justify-content-center"><!-- local user data -->
                                        <h6>일반 회원</h6>
                                        <h3><#if userCnt??>${userCnt.userCnt}<#else>0</#if></h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-auto" style="height:80px;"><!-- cloud user 아이콘 -->

                                    </div>
                                    <div class="col d-flex flex-column justify-content-center"><!-- local user data -->
                                        <h6>계약 회원</h6>
                                        <h3><#if userCnt??>${userCnt.contractUserCnt}<#else>0</#if>명</h3>
                                    </div>
                                </div>
                            </div><!-- # 계약회원 현황 우측 끝 -->
                        </div>
                    </div><!-- # dashboard grid white box 끝 -->
                </div>
            </div>
            <div class="col">
                <div class="dashboard-wrap">
                    <h6>계약회사 현황</h6><!-- # 일반회원 현황 title -->
                    <div class="w-line-box"><!-- # dashboard grid white box 시작 -->
                        <div class="row">
                            <div class="col-7"><!-- 일반회원 현황 좌측 차트 -->
                                <div id="chart-a" class="pl-3 pr-3" style="height:160px;"></div>
                            </div>
                            <div class="col-5 d-flex flex-column justify-content-center align-items-center"><!-- 일반회원 현황 우측 data -->
                                <#--<h6>전체회원</h6>-->
                                <h2>${companyCount}개</h2>
                            </div>
                        </div>
                    </div><!-- # dashboard grid white box 끝 -->
                </div>
            </div>
            <div class="col">
                <div class="dashboard-wrap">
                    <h6>레퍼지토리 현황</h6>
                    <div class="w-line-box"><!-- # dashboard grid white box 시작 -->
                        <div class="row">
                            <div class="col d-flex flex-column justify-content-center align-items-center" style="height:160px;"><!-- 일반회원 현황 좌측 차트 -->
                                <div></div>
                                <h6>등록된 콘텐츠</h6>
                                <h2>${repositoryCount}개</h2>
                            </div>
                            <#--<div class="col d-flex flex-column justify-content-center align-items-center" style="height:160px;"><!-- 일반회원 현황 우측 data &ndash;&gt;-->
                            <#--<div></div>-->
                            <#--<h6>콘텐츠 질문/답변</h6>-->
                            <#--<h2>219,606개</h2>-->
                            <#--</div>-->
                        </div>
                    </div><!-- # dashboard grid white box 끝 -->
                </div>
            </div>
        </div>
<#--        <div class="row mb-4">-->
<#--            <div class="col">-->
<#--                <div class="dashboard-wrap">-->
<#--                    <h6>매출 현황</h6>-->
<#--                    <div class="w-line-box"><!-- # dashboard grid white box 시작 &ndash;&gt;-->
<#--                        <div class="row">-->
<#--                            <div class="col-7"><!-- 일반회원 현황 좌측 차트 &ndash;&gt;-->
<#--                                <div id="chart-b" class="pl-3 pr-3" style="height:160px;"></div>-->
<#--                            </div>-->
<#--                            <div class="col-5 d-flex flex-column justify-content-center align-items-center"><!-- 일반회원 현황 우측 data &ndash;&gt;-->
<#--                                <h6>마지막 업데이트 2019.01.10</h6>-->
<#--                                <h2>23,314,000원</h2>-->
<#--                            </div>-->
<#--                        </div>-->
<#--                    </div><!-- # dashboard grid white box 끝 &ndash;&gt;-->
<#--                </div>-->
<#--            </div>-->

        <div class="row mb-4">
            <div class="col">
                <div class="dashboard-wrap">
                    <h6>라이선스 / 시험버전 다운로드 현황</h6>
                    <div class="w-line-box"><!-- # dashboard grid white box 시작 -->
                        <#--  <div id="chart-c" style="height:340px;"></div>  -->
                        <div class="row">
                            <div class="col-5"><!-- 일반회원 현황 좌측 차트 -->
                                <div id="chart-c" class="pl-3 pr-3" style="height:200px;"></div>
                            </div>
                            <div class="col-2 d-flex flex-column justify-content-center align-items-center"><!-- 일반회원 현황 우측 data -->
                                <h6>등록된 콘텐츠</h6>
                                <h2>12,500개</h2>
                            </div>
                            <div class="col-5"><!-- 일반회원 현황 우측 data -->
                                <div id="chart-d" class="pl-3 pr-3" style="height:200px;"></div>
                            </div>
                        </div>
                    </div><!-- # dashboard grid white box 끝 -->
                </div>
            </div>
        </div>
        <div class="row mb-4">
            <div class="col">
                <div class="dashboard-wrap">
                    <h6>1:1문의관리</h6>
                    <div class="w-line-box pt-1 pb-1">
                        <#if bbsOnetooneList??>
                            <#list bbsOnetooneList as row>
                                <#if row.qnaType != 2>
                                    <ul class="list-group">
                                        <li class="list-group-item">
                                            <span class="badge badge-<#if row.answerYn = 0>secondary<#else>success</#if> miw60">
                                                <#if row.answerYn = 0>미처리<#else>답변완료</#if>
                                            </span>
                                            ${row.title!}
                                            <span class="float-right">${row.createDatetime?string["yyyy-MM-dd"]}</span>
                                        </li>
                                    </ul>
                                </#if>
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="dashboard-wrap">
                    <h6>버그신고</h6>
                    <div class="w-line-box pt-1 pb-1">
                        <#if bbsOnetooneList??>
                            <#list bbsOnetooneList as row>
                                <#if row.qnaType = 2>
                                    <ul class="list-group" onclick="">
                                        <li class="list-group-item">
                                            <span class="badge badge-<#if row.answerYn = 0>secondary<#else>success</#if> miw60">
                                                <#if row.answerYn = 0>미처리<#else>답변완료</#if>
                                            </span>
                                            ${row.title!}
                                            <span class="float-right">${row.createDatetime?string["yyyy-MM-dd"]}</span>
                                        </li>
                                    </ul>
                                </#if>
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript">
    // chart-a 일반회원 현황
    var dom = document.getElementById("chart-a");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    app.title = '';

    option = {
        color: ['#871dce'],
        tooltip : {
            trigger: 'axis',
            axisPointer : {
                type : 'shadow'
            }
        },
        grid: {
            top: '10px',
            left: '0%',
            right: '0%',
            bottom: '0%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['8월', '9월', '10월', '11월', '12월'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'신규회원',
                type:'bar',
                barWidth: '30%',
                data:[100, 152, 200, 334, 390]
            }
        ]
    };
    
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

    // chart-b 매출현황

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

    // chart-c 라이선스 & 시험버전 다운로드 현황 1
    var dom = document.getElementById("chart-c");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    app.title = '';

    option = {
        color: ['#53c074'],
        tooltip : {
            trigger: 'axis',
            axisPointer : {
                type : 'shadow'
            }
        },
        grid: {
            top: '10px',
            left: '0%',
            right: '0%',
            bottom: '0%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['1월','2월','3월','4월','5월','6월','7월','8월', '9월', '10월', '11월', '12월'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'신규회원',
                type:'bar',
                barWidth: '30%',
                data:[100, 152, 200, 100, 211, 100, 152, 200, 334, 390, 400, 452]
            }
        ]
    };
    ;
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

    // chart-c 라이선스 & 시험버전 다운로드 현황 2
    var dom = document.getElementById("chart-d");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    option = {
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        grid: {
            top: '10px',
            left: '0%',
            right: '0%',
            bottom: '0%',
            containLabel: true
        },
        series : [
            {
                name: 'ex',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],

                label: {
                    normal: {
                        formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                        rich: {
                            b: {
                                fontSize: 16,
                                lineHeight: 33
                            },
                            per: {
                                color: '#eee',
                                backgroundColor: '#334455',
                                padding: [2, 4],
                                borderRadius: 2
                            }
                        }
                    }
                },

                data:[
                    {value:335, name:'ex1'},
                    {value:310, name:'ex2'},
                    {value:234, name:'ex3'},
                    {value:135, name:'ex4'},
                    {value:1548, name:'ex5'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">