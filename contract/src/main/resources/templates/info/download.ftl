<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<#--<div class="page-title-section">-->
<#--    <div class="container">-->
<#--        <div class="row">-->
<#--            <div class="col text-center">-->
<#--                <h1 class="main-title-h1"><@spring.message "trial.text1"/></h1>-->
<#--                <h2 class="main-title-h2"><@spring.message "trial.text2"/></h2>-->
<#--            </div>-->
<#--        </div>-->
<#--    </div>-->
<#--</div>-->

<div class="sub-title-bg background-base-code background-h2">
    Trial Download
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4><@spring.message "trial.text3"/></h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>Trial Download</h5>
            </div>
        </div>
        <hr class="mt-1 mb-5">
    </div>
</section>  -->

<section class="place-wrap-top-none mt-5">
    <div class="container">
        <div class="row">
            <div class="col">

                <form id="trialDownForm">
                    <div class="">
                        <div class="card-body text-center p-5">
                            <h4><@spring.message "trial.text4"/> ${trialDate} <@spring.message "trial.text5"/></h4>
                            <#--<button id="apply32Btn" type="button" class="btn btn-outline-info btn-lg-round btn-lg mt-4 mb-1">Windows 7 32bit<!--<@spring.message "trial.text6"/>&ndash;&gt;</button>-->
                            <input type="hidden" id="bit" name="bit">
                            <h6 style="color:#17a2b8">Trial 다운로드 시 입력하신 이메일로 라이선스가 발급됩니다.<br>다운로드 및 설치 후 라이선스키를 입력하세요.</h6>

                            <#--<button type="button" id="trialExtension" class="btn btn-outline-info btn-lg-round btn-lg mt-1 mb-5" disabled>Extension of trial CloudRPA</button>-->
                            <#--<p>* <@spring.message "trial.text8"/></p>-->
                            <div class="row justify-content-center">
                                <div class="col-8 mb-3">
                                    <hr class="mt-5 mb-5">
                                    <div class="form-row mb-3">
                                        <div class="col-3 d-flex justify-content-end align-items-center">
                                            <span class="mr-3">이름</span>
                                        </div>
                                        <div class="col-7">
                                            <input type="text" class="form-control" id="trialName" name="trialName" aria-describedby="" placeholder="이름을 입력해 주세요" value="" maxlength="10">
                                        </div>
                                    </div>
                                    <div class="form-row mb-3">
                                        <div class="col-3 d-flex justify-content-end align-items-center">
                                            <span class="mr-3"><@spring.message "trial.text9"/></span>
                                        </div>
                                        <div class="col-7">
                                            <input type="text" class="form-control" id="trialEmail" name="trialEmail" aria-describedby="" placeholder="<@spring.message "trial.text10"/>" value="" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-row mb-3">
                                        <div class="col-3 d-flex justify-content-end align-items-center">
                                            <span class="mr-3"><@spring.message "trial.text11"/></span>
                                        </div>
                                        <div class="col-7">
                                            <input type="text" class="form-control" id="trialPhone" name="trialPhone" aria-describedby="" placeholder="<@spring.message "trial.text12"/>" value="" maxlength="11" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                                        </div>
                                    </div>
                                    <div class="form-row mb-3">
                                        <div class="col-3 d-flex justify-content-end align-items-center">
                                            <span class="mr-3"><@spring.message "trial.text13"/></span>
                                        </div>
                                        <div class="col-7">
                                            <input type="text" class="form-control" id="trialCompany" name="trialCompany" aria-describedby="" placeholder="<@spring.message "trial.text14"/>" value="" maxlength="20">
                                        </div>
                                    </div>
                                    <div class="form-row mb-3">
                                        <div class="col-3 d-flex justify-content-end align-items-center">
                                            <span class="mr-3"><@spring.message "trial.text15"/></span>
                                        </div>
                                        <div class="col-7">
                                            <input type="text" class="form-control" id="trialPosition" name="trialPosition" aria-describedby="" placeholder="<@spring.message "trial.text16"/>" value="" maxlength="20">
                                        </div>
                                    </div>
                                    <#--<div class="form-row mb-3">-->
                                        <#--<div class="col-3 d-flex justify-content-end align-items-center">-->
                                            <#--<span class="mr-3">Mac Address</span>-->
                                        <#--</div>-->
                                        <#--<div class="col-5">-->
                                            <#--<input type="text" class="form-control" id="macAddr" name="macAddr" aria-describedby="" placeholder="'-'제외하고 입력해 주세요.">-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <hr class="mt-5 mb-5">
                                    <div class="privacy-text">
                                        <input type="checkbox" id="agree"> A.WORKS의 <a href="/terms" target="_blank">이용약관</a>, <a href="/privacy" target="_blank">개인정보처리방침</a>에 모두 동의합니다.
                                    </div>
                                </div>

                            </div>
                            <button id="apply64Btn" type="button" class="btn btn-outline-info btn-lg-round btn-lg mt-4 mb-1">Windows 10 64bit 다운로드</button>
                            <div class="mt-4 privacy-text"><a href="javascript:void(0)" id="reDownload" >Trial 파일 다운로드 중 문제 발생 시 이 링크를 클릭하여 수동으로 다운로드 하세요</a></div>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</section>
<div id="preparing-file-modal" title="Preparing report..." style="display: none;">
    신청이 완료 되었습니다. 파일 다운로드 중입니다...

    <div class="ui-progressbar-value ui-corner-left ui-corner-right" style="width: 100%; height:22px; margin-top: 20px;"></div>
</div>

<div id="error-modal" title="Error" style="display: none;">
    파일다운로드에 실패했습니다.
</div>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<script src="/assets/js/jquery.blockUI.js"></script>
<script src="/assets/js/jquery.filedownload.min.js"></script>
<!-- custom script 위치 -->
<script type="text/javascript" src="/assets/js/info/download.js"></script>
<script>
    $(document).ready(function() {
        <#--$('#apply32Btn').click(function() {-->
            <#--&lt;#&ndash;document.location.href = "/api/fileDownload?fileUrl=${file32Path}";&ndash;&gt;-->
            <#--&lt;#&ndash;return false;&ndash;&gt;-->
            <#--var email = $('#trialEmail').val();-->
            <#--var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;-->
            <#--var macAddr = $('#macAddr').val();-->
            <#--var regExp2 = /^([0-9A-Fa-f]{2}[:-]?){5}([0-9A-Fa-f]{2})$/i;-->
            <#--if(!regExp.test(email)) {-->
                <#--alert('<@spring.message "trial.text18"/>');-->
                <#--return false-->
            <#--}-->

            <#--if($("#trialPhone").val() == ""){-->
                <#--alert('<@spring.message "trial.text19"/>');-->
                <#--return false;-->
            <#--}-->

            <#--if($("#trialCompany").val() == ""){-->
                <#--alert('<@spring.message "trial.text20"/>');-->
                <#--return false;-->
            <#--}-->
            <#--if(!$("#agree").is(":checked")){-->
                <#--alert('<@spring.message "trial.text21"/>');-->
                <#--return false;-->
            <#--}-->
            <#--var datas = $("#trialDownForm").serialize();-->
            <#--$.ajax({-->
                <#--url: "/api/trialSubmission",-->
                <#--type: 'GET',-->
                <#--dataType: 'JSON',-->
                <#--data: datas,-->
                <#--success: function (response) {-->
                    <#--if(response.result == true) {-->
                        <#--<#if file32Path??>-->
                            <#--alert('<@spring.message "trial.text22"/>');-->
                            <#--&lt;#&ndash;$.fileDownload("/api/fileDownload?fileUrl=${file32Path}", {&ndash;&gt;-->
                                <#--&lt;#&ndash;preparingMessageHtml: "Download 중입니다...",&ndash;&gt;-->
                                <#--&lt;#&ndash;failMessageHtml: "There was a problem generating your report, please try again."&ndash;&gt;-->
                            <#--&lt;#&ndash;});&ndash;&gt;-->


                            <#--&lt;#&ndash;$.fileDownload("${file32Path}");&ndash;&gt;-->
                            <#--return false;-->

                        <#--<#else>-->
                            <#--alert('<@spring.message "trial.text23"/>');-->
                            <#--// location.reload();-->
                        <#--</#if>-->
                    <#--}else {-->
                        <#--alert('<@spring.message "trial.text24"/>');-->
                    <#--}-->
                <#--}-->
            <#--});-->
            <#--alert("준비중입니다.");-->

        <#--});-->

        $('#apply64Btn').click(function() {
            var email = $('#trialEmail').val();
            var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            var macAddr = $('#macAddr').val();
            var regExp2 = /^([0-9A-Fa-f]{2}[:-]?){5}([0-9A-Fa-f]{2})$/i;
            if($("#trialName").val() == ""){
                alert('이름을 입력해 주세요');
                return false;
            }
            if(!regExp.test(email)) {
                alert('<@spring.message "trial.text18"/>');
                return false
            }

            if($("#trialPhone").val() == ""){
                alert('<@spring.message "trial.text19"/>');
                return false;
            }

            if($("#trialCompany").val() == ""){
                alert('<@spring.message "trial.text20"/>');
                return false;
            }
            if(!$("#agree").is(":checked")){
                alert('<@spring.message "trial.text21"/>');
                return false;
            }
            // }else if(macAddr.match(regExp2) == null) {
            //     alert("잘못된 맥어드레스형식입니다. 다시 입력해 주세요.");
            //     return false
            // }
            var datas = $("#trialDownForm").serialize();
            $.blockUI({  message: '<img src="/assets/images/15.gif" />'});
            $.ajax({
                url: "/api/trialSubmission",
                type: 'GET',
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    console.log(response);
                    if(response.result == true) {
                        <#if file64Path??>
                        alert('<@spring.message "trial.text22"/>');
                        <#--document.location.href = "/api/fileDownload?fileUrl=${file64Path}";-->

                        // console.log(123);
                        <#--$.fileDownload("${file64Path}");-->
                        $.fileDownload("${file64Path}");
                        setTimeout(function(){
                            $.unblockUI();
                            location.reload();
                        },3000);

                        // return false;
                        //
                        <#else>

                        alert('<@spring.message "trial.text23"/>');
                        // location.reload();
                        </#if>
                    }else {
                        $.unblockUI();
                        alert(response.msg);
                    }
                }
            });
            // alert("준비중입니다.");
        });

        $("#reDownload").click(function(){
            $.blockUI({  message: '<img src="/assets/images/15.gif" />'});
            // alert(1);
            $.fileDownload("${file64Path}");
            setTimeout(function(){
                $.unblockUI();
            },3000);
            return false;
        })
    });
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">