<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<div class="sub-title-bg background-base-code background-h4">
    <h1><@spring.message "contactus.text1"/></h1>
</div>

<section class="place-wrap">
    <div class="container">
        <div class="row">
            <div class="col">
                <h3 class="text-center pb-3">A.WORKS 솔루션 관련 문의를 주시면 확인하여 연락드리겠습니다.</h3>
                <form id="contactusFrm">
                    <div class="card">
                        <div class="card-body">

                            <div class="form-group">
                                <label for=""><@spring.message "contactus.text3"/>*</label>
                                <input type="text" class="form-control border-radius-none" id="contactusName" name="name" aria-describedby="" placeholder="<@spring.message "contactus.text11"/>" maxlength="10">
                            </div>
                            <div class="form-group">
                                <label for=""><@spring.message "contactus.text4"/>*</label>
                                <input type="text" class="form-control border-radius-none" id="contactusEmail" name="email" aria-describedby="" placeholder="<@spring.message "contactus.text12"/>" maxlength="30">
                            </div>
                            <div class="form-group">
                                <label for=""><@spring.message "contactus.text5"/>*</label>
                                <input type="text" class="form-control border-radius-none" id="contactusComName" name="comName" aria-describedby="" placeholder="<@spring.message "contactus.text13"/>" maxlength="20">
                            </div>
                            <div class="form-group">
                                <label for=""><@spring.message "contactus.text6"/>*</label>
                                <input type="text" class="form-control border-radius-none" id="contactusPhone" name="comPhone" aria-describedby="" placeholder="<@spring.message "contactus.text14"/>" oninput="fn_maxLengthCheck(this)" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" maxlength="11">
                            </div>
                            <div class="form-group">
                                <label for=""><@spring.message "contactus.text7"/>*</label>
                                <textarea class="form-control border-radius-none" name="content" id="contactusContent" rows="10" placeholder="<@spring.message "contactus.text15"/>" maxlength="500"></textarea>
                            </div>

                            <div class="privacy-text text-center pt-2 mb-3">
                                <input type="checkbox" id="agree"> A.WORKS의 <a href="/terms" target="_blank">이용약관</a>, <a href="/privacy" target="_blank">개인정보처리방침</a>에 모두 동의합니다.
                            </div>
                        </div>
                    </div>
                    <div class="p-3 text-center">
                        <button type="button" id="cencel" class="btn btn-secondary border-radius-none"><@spring.message "contactus.text9"/></button>
                        <button type="button" id="send" class="btn btn-info border-radius-none"><@spring.message "contactus.text10"/></button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(document).ready(function () {
        //등록버튼 이벤트
        $("#send").click(function() {
            var RegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
            var name = $("#contactusName").val();
            var email = $("#contactusEmail").val();
            var comname = $("#contactusComName").val();
            var comphone = $("#contactusPhone").val();
            var content = $("#contactusContent").val();
            // $('#contactusNameStr').text("");
            // $('#contactusEmailStr').text("");
            // $('#contactusComNameStr').text("");
            // $('#contactusPhoneStr').text("");
            // $('#contactusContentStr').text("");
            if(name == ""){
                alert('<@spring.message "contactus.text11"/>');
                $('#contactusName').focus();
                return false;
            }

            if(email == ""){
                alert('<@spring.message "contactus.text12"/>');
                $('#contactusEmail').focus();
                return false;
            }

            if(!RegExp.test(email)) {
                alert('<@spring.message "contactus.text16"/>');
                $('#contactusEmail').focus();
                return false;
            }

            if(comname == ""){
                alert('<@spring.message "contactus.text13"/>');
                $('#contactusComName').focus();
                return false;
            }

            if(comphone == ""){
                alert('<@spring.message "contactus.text14"/>');
                $('#contactusPhone').focus();
                return false;
            }

            if(content == ""){
                alert('<@spring.message "contactus.text15"/>');
                $('#contactusContent').focus();
                return false;
            }

            if(!$("#agree").is(":checked")){
                alert("이용약관 및 개인정보처리방침에 동의해 주시기 바랍니다.");
                return false;
            }
            if(confirm("Contact Us를 등록하시겠습니까?")) {
                var datas = $("#contactusFrm").serialize();
                $.ajax({
                    url: "/api/contactus",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        if (response.result == true) {
                            alert('<@spring.message "contactus.text17"/>');
                            $("#contactusFrm")[0].reset();
                            document.location.href = '/';
                            // $('#contactus-lg').modal("hide");
                        } else {
                            alert('<@spring.message "contactus.text18"/>');
                        }
                    }
                });
            }
            // var datas = $("#directFrom").serialize();
            // $.ajax({
            //     url: "/api/qna",
            //     type: 'POST',
            //     data: datas,
            //     dataType: 'JSON',
            //         success: function (response) {
            //             if(response.result == true) {
            //                 alert("등록 처리 되었습니다.");
            //                 location.href = "/qna"
            //             }else {
            //                 alert("등록중 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
            //             }
            //         }
            // });
        });

        $("#cencel").click(function() {
            var answer = confirm("취소 하시면 입력된 내용이 초기화 됩니다. 취소하시겠습니까?");
            if (answer) {
                history.back();
            }
        });


    });
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">