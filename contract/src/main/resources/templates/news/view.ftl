<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<div class="sub-title-bg background-base-code background-h3">
    News
</div>

<section class="place-wrap pb-5 pt-5">
    <div class="container px-5">
        <div class="row mb-2">
            <div class="col-12">
                <h2 class="border-bottom py-3">${bbs_info.title!}</h2>
            </div>
        </div>
        
        <div class="row mb-3">
            <div class="col-12">
                ${bbs_info.viewDatetime?string["yyyy.MM.dd"]}
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <#--<div class="w-100 border-top py-4">-->
                    <#--<img src="https://www.poscoict.com/filedata/board_some/201904021015303650_cont.JPG" class="card-img-top" alt="...">-->
                <#--</div>-->
                <#--<div class="w-100 border-bottom">-->
                    <#--<p class="card-text pb-5">-->
                        <#--포스코ICT가 지난 3월 27일~29일 3일간 코엑스에서 개최된 ‘Smart Factory·Automation World 2019’에 참가해 스마트팩토리 솔루션과 구축사례를 선보였다.<br>-->
                        <#--<br>-->
                        <#--‘Smart Factory·Automation World 2019’는 국내 최대 규모의 스마트팩토리 전시회로, 올해는 ‘Digital Transforming in Manufacturing’을﻿ 주제로 개최되었다. 포스코ICT는 이번에 처음 참가해 세계 최초로 연속공정 중후장대 철강산업의 스마트팩토리를 구현한 노하우와 관련 분야 솔루션을 관람객들에게 소개했다.<br>-->
                        <#--<br>                        -->
                        <#--우선 제조현장의 데이터를 실시간 수집해 빅데이터 분석하고 AI를 활용한 최적의 제어를 지원하는 포스코 그룹의 스마트팩토리 플랫폼인 ‘포스프레임(PosFrame)’을 비롯해, PLC와 HMI에 스마트 기술을 더한 ‘포스마스터(PosMaster)’, 산업제어시스템 보안솔루션 ‘포시스(POSIS)’, 산업용 로봇서비스 플랫폼 ‘아이라스(IRaaS)’, ‘스마트안전모’ 등 스마트팩토리 솔루션을 ﻿관람객들에게 선보였다.<br>-->
                        <#--<br>                        -->
                        <#--포스코ICT는 이번 전시회 기간 동안 하루 평균 약 800명 이상의 관람객들이 방문했다고 밝혔다. 특히, 제조기업으로부터 스마트팩토리 솔루션 전반에 대한 제안 및 진단 요청을 받았으며, 관련 솔로션 기업으로부터 사업협력 요청이 이어지기도 했다.<br>-->
                        <#--<br>                    -->
                        <#--포스코ICT 관계자는 “이번 전시회를 통해 포스코ICT 스마트팩토리 솔루션에 대한 고객들의 관심을 확인하고, 고객들에게 어떤 기술과 서비스를 제공해야 할지 방향성을 정립할 수 있는 좋은 계기가 되었다”며 “앞으로 국내 산업의 스마트화 선도 기업 이미지를 더욱 확고히 구축해나갈 계획”이라고 밝혀다.-->
                    <#--</p>-->
                <#--</div>-->
                ${bbs_info.content!}
            </div>

            <div class="col-12 mt-3">
                <#if bbs_info.pre??>
                <a href="/news_view?newsroomId=${bbs_info.pre?number}" class="btn btn-light btn-block">
                    <div class="row">
                        <div class="col-1 text-left border-right">이전글</div>
                        <div class="col-11 text-left">${bbs_info.preTitle}</div>
                    </div>
                </a>
                </#if>
                <#if bbs_info.nex??>
                <a href="/news_view?newsroomId=${bbs_info.nex?number}" class="btn btn-light btn-block">
                    <div class="row">
                        <div class="col-1 text-left border-right">다음글</div>
                        <div class="col-11 text-left">${bbs_info.nexTitle}</div>
                    </div>
                </a>
                </#if>
            </div>

            <div class="col-12">
                <div class="border-top text-right mt-3 pt-3">
                    <a href="/news_list" class="btn btn-info">목록</a>
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