<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<style>
.p-chart-02:after {
  content: "프로세스 등록";
}
.p-chart-02:before {
  content: "실험 / 모니터링";
}
</style>


<div class="page-title-section-new">
    <div class="section-titlewrap-bg"></div>
    <div class="page-title-section-new-in">
        <div class="container mt-5">
            <div class="row">
                <div class="col text-center">
                    <h1 class="main-title-h1-new">Platform</h1>
                    <h2 class="main-title-h2-new">Work Intelligent Platform, a.works</h2>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="row d-flex justify-content-center">
        <div class="col-10 h-100 d-flex flex-column justify-content-center align-items-center platform-top-new">
            <div class="black-mask-rgba"></div>
        </div>
    </div>
</div>


<#--  <div class="page-title-section">
    <div class="container">
        <div class="row">
            <div class="col text-center">
                <h1 class="main-title-h1"><@spring.message "platform.text1"/></h1>
                <h2 class="main-title-h2">"<@spring.message "platform.text2"/>"</h2>
                <div class="main-title-div">
                    <@spring.message "platform.text3"/>
                </div>
            </div>
        </div>
    </div>
</div>  -->



<section class="subpage-wrap-nones mt-5">
    <div class="container">
        <div class="row d-flex justify-content-center">
            <div class="col-3">
                <div class="h-100 d-flex flex-column justify-content-center align-items-center">
                    <img src="/assets/images/platform/01_folder.png" class="mb-4" style="width:120px;"/>
                </div>
            </div>
            <div class="col-7">
                <div class="h-100 d-flex flex-column justify-content-center align-items-start">
                    <h2 class="mb-3">기존 업무, 기존 IT 인프라 그대로</h2>
                    <div class="subpage-content2 text-left">
                        웹을 열어 Data를 수집하는 것 부터, 보고서를 작성해 메일로 발송하는 등,<br>
                        a.works에서 자동화 프로세스 전 단계를 구현할 수 있습니다.<br>
                        기존 IT 인프라 변경없이, Back Office 업무 자동화가 필요한<br>
                        모든 부서의 업무를 자동화하고 컨트롤합니다.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="subpage-wrap-bluegray">
    <div class="container">
        <div class="row d-flex justify-content-center">
            <div class="col-3">
                <div class="h-100 d-flex flex-column justify-content-center align-items-center">
                    <img src="/assets/images/platform/02_map.png" class="mb-4" style="width:120px;"/>
                </div>
            </div>
            <div class="col-7">
                <div class="h-100 d-flex flex-column justify-content-center align-items-start">
                    <h2 class="mb-3">a.works의 KeyWord, 확장성</h2>
                    <div class="subpage-content2 text-left">
                        a.works는 API를 기반으로 얼마든지 확장할 수 있습니다. 다양한 AI 솔루션과 접목해<br>
                        사람과 상호작용하고 인지기반의 의사결정이 필요한 업무도 자동화할 수 있습니다.<br>
                        이용자의 니즈와 아이디어에 따라 원하는 형태로 활용해 보세요.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="subpage-wrap-nones">
    <div class="container">
        <div class="row d-flex justify-content-center">
            <div class="col-3">
                <div class="h-100 d-flex flex-column justify-content-center align-items-center">
                    <img src="/assets/images/platform/03_cloud.png" class="mb-4" style="width:120px;"/>
                </div>
            </div>
            <div class="col-7">
                <div class="h-100 d-flex flex-column justify-content-center align-items-start">
                    <h2 class="mb-3">Automation, Easy to Start</h2>
                    <div class="subpage-content2 text-left">
                        여타 RPA 솔루션들이 On-Premise 서비스만 제공하는 것과 달리, a.works는<br>
                        국내 최초로 Cloud RPA도 서비스합니다. Cloud RPA는 초기 비용이 낮고<br>
                        사용량 만큼 과금하므로 고객이 RPA를 도입하는 데에 부담이 적습니다. a.works는<br>
                        국내 IT 환경과 한국인의 업무 패턴에 맞는 기능, UI를 채택해 고객 편의성을 높였습니다.<br>
                        가까운 곳에서 신속히 대응해 드리겠습니다.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="subpage-wrap-black">
    <div class="container">
        <div class="row">
            <div class="col">
                <h3 class="subpage-title pt-5">세가지 핵심 컴포넌트가 유기적으로 결합해 a.works 플랫폼을 구성합니다.</h3>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col d-flex justify-content-center align-items-center">
                <img src="/assets/images/platform/04_studio.png" class="w-75"/>
            </div>
            <div class="col d-flex justify-content-center align-items-center">
                <img src="/assets/images/platform/05_workcenter.png" class="w-75"/>
            </div>
            <div class="col d-flex justify-content-center align-items-center">
                <img src="/assets/images/platform/06_robot.png" class="w-75"/>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col d-flex flex-column justify-content-center align-items-center">
                <div class="font18">자동화 프로세스를 구현하는</div>
                <h3>Studio</h3>
            </div>
            <div class="col d-flex flex-column justify-content-center align-items-center">
                <div class="font18">RPA 자원을 최적화하는</div>
                <h3>WorkCenter</h3>
            </div>
            <div class="col d-flex flex-column justify-content-center align-items-center">
                <div class="font18">실수없이 업무를 완수하는</div>
                <h3>Robot</h3>
            </div>
        </div>
    </div>
</section>

<section class="subpage-wrap py-5 border-top">
    <div class="container my-4">
        <div class="row">
            <div class="col-6 d-flex flex-column justify-content-center align-items-center">
                <h2>Video</h2>
                <h5>핵심기능TEXT</h5>
            </div>
            <div class="col-6">
                <div class="platform-bottom border">
                    <div class="h-100">
                        <div class="h-100 d-flex flex-column justify-content-center align-items-center">
                            <a href="#" data-toggle="modal" data-backdrop="static" data-target="#video-platform-md" class="text-white black-mask-rgba-play"><i class="icon-play-outline font4rem"></i></a>
                            <div class="black-mask-rgba"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal fade" id="video-platform-md" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-xlx modal-dialog-centered" role="document">
        <div class="modal-content border-radius-none">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <iframe class="yt_player_iframe" width="1280" height="720" src="https://www.youtube.com/embed/cXvVuCrLgV0?rel=0&amp;controls=1&amp;showinfo=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>
    </div>
</div>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(function(){
        $("#video-md").on('hidden.bs.modal', function (e) {
            var leg=$('.yt_player_iframe').attr("src");
            $('.yt_player_iframe').attr("src",leg);
        })
    })
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">