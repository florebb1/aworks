<style>
    .text-danger {
        display: none;
    }
</style>

<div class="modal-body pa-0">
    <form id="writeForm">
        <div id="contentMain" class="input-display">
            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">관리자 정보</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>아이디</span>
                </div>
                <div class="col-9">
                        <input type="text" class="form-control input-form" name="adminId" id="adminId" placeholder="" required=""
                               value="<#if admin??>${admin.adminId}</#if>" readonly>
                        <div class="text-info-mih" >
                            <small id="adminIdChkText" class="form-text text-danger"></small>
                        </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>비밀번호</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                8~20자의 영문+숫자+특수문자를 조합하여 입력하세요. 안전한 이용을 위하여 아이디와 다르게 설정하시기 바랍니다.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <input type="password" class="form-control input-form" name="adminPw" id="adminPw" placeholder="" required="">
                    <div class="text-info-mih">
                        <small id="adminPwChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>비밀번호 확인</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                비밀번호 확인을 위하여 동일한 비밀번호를 다시 입력해 주세요.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <input type="password" class="form-control input-form" id="adminPwAgain" placeholder="" required="">
                    <div class="text-info-mih">
                        <small id="adminPwAgainChkText" class="form-text text-danger">* 비밀번호가 동일하지 않습니다. 동일한 비밀번호를 입력해 주세요.</small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>관리자명</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                사용할 이름을 입력해 주세요.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control input-form" name="adminName" id="adminName" placeholder="" required=""
                           value="<#if admin??>${admin.adminName!}</#if>" readonly>
                    <div class="text-info-mih">
                        <small id="adminNameChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>이메일</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                이메일 형식으로 입력해 주세요
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control input-form" placeholder="" required="" name="adminEmail" id="adminEmail"
                           value="<#if admin??>${admin.adminEmail!}</#if>">
                    <div class="text-info-mih">
                        <small id="adminEmailChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>연락처</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                연락처를 ‘-’를 제외한 나머지 번호만 입력해 주세요. 예) '01012345678' or '+821012345678'
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control input-form" placeholder="" required="" name="adminPhone" id="adminPhone"
                           value="<#if admin??>${admin.adminPhone!}</#if>">
                    <div class="text-info-mih">
                        <small id="adminPhoneChkText" class="form-text text-danger">* 특수문자는 사용 할 수 없습니다.</small>
                    </div>
                </div>
            </div>
                
            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">환경설정</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>라이선스 만료 통보 1차</span>
                </div>
                <div class="col-9">
                    <select class="form-control input-form" name="licenseDate1" id="licenseDate1">
                        <option value="" <#if amdin?? && admin.licenseDate1??><#else>selected</#if>>선택해주세요</option>
                        <option value="0" <#if admin?? && admin.licenseDate1?? && admin.licenseDate1 = 0>selected</#if>>5일</option>
                        <option value="1" <#if admin?? && admin.licenseDate1?? && admin.licenseDate1 = 1>selected</#if>>15일</option>
                        <option value="2" <#if admin?? && admin.licenseDate1?? && admin.licenseDate1 = 2>selected</#if>>30일</option>
                    </select>
                    <div class="text-info-mih">
                        <small id="licenseDate1ChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>라이선스 만료 통보 2차</span>
                </div>
                <div class="col-9">
                    <select class="form-control input-form" name="licenseDate2" id="licenseDate2">
                        <option value="" <#if amdin?? && admin.licenseDate2??><#else>selected</#if>>선택해주세요</option>
                        <option value="0" <#if admin?? && admin.licenseDate2?? && admin.licenseDate2 = 0>selected</#if>>5일</option>
                        <option value="1" <#if admin?? && admin.licenseDate2?? && admin.licenseDate2 = 1>selected</#if>>15일</option>
                        <option value="2" <#if admin?? && admin.licenseDate2?? && admin.licenseDate2 = 2>selected</#if>>30일</option>
                    </select>
                    <div class="text-info-mih">
                        <small id="licenseDate2ChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>라이선스 만료 통보 3차</span>
                </div>
                <div class="col-9">
                    <select class="form-control input-form" name="licenseDate3" id="licenseDate3">
                        <option value="" <#if amdin?? && admin.licenseDate3??><#else>selected</#if>>선택해주세요</option>
                        <option value="0" <#if admin?? && admin.licenseDate3?? && admin.licenseDate3 = 0>selected</#if>>5일</option>
                        <option value="1" <#if admin?? && admin.licenseDate3?? && admin.licenseDate3 = 1>selected</#if>>15일</option>
                        <option value="2" <#if admin?? && admin.licenseDate3?? && admin.licenseDate3 = 2>selected</#if>>30일</option>
                    </select>
                    <div class="text-info-mih">
                        <small id="licenseDate3ChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <#--<div class="form-row">-->
                <#--<div class="col-3 main-form-title">-->
                    <#--<span>교육안내 담당자 / 이메일</span>-->
                <#--</div>-->
                <#--<div class="col-3">-->
                    <#--<input type="text" class="form-control input-form" placeholder="담당자명" id="chargerName1" name="chargerName1" maxlength="20">-->
                <#--</div>-->
                <#--<div class="col-6">-->
                    <#--<input type="text" class="form-control input-form" placeholder="이메일" id="chargerEmail1" name="chargerEmail1" maxlength="50">-->
                <#--</div>-->
            <#--</div>-->
            <#--<div class="form-row">-->
                <#--<div class="col-3 main-form-title">-->
                    <#--<span>1:1문의 담당자 / 이메일</span>-->
                <#--</div>-->
                <#--<div class="col-3">-->
                    <#--<input type="text" class="form-control input-form" placeholder="담당자명" id="chargerName2" name="chargerName2" maxlength="20">-->
                <#--</div>-->
                <#--<div class="col-6">-->
                    <#--<input type="text" class="form-control input-form" placeholder="이메일" id="chargerEmail2" name="chargerEmail2" maxlength="50">-->
                <#--</div>-->
            <#--</div>-->
        </div>
    </form>
</div>
<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save">수 정</button>
</div>

<script>
    var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    var passwordPattern = /^(?=.*[a-z0-9])((?=.*\d)|(?=.*\W)).{6,20}$/;
    var phonePattern = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

    $(document).ready(function () {
        $(".input-form").on({
            keyup: function () {
                $(".text-danger").text("");
            },
            change: function () {
                $(".text-danger").text("");
            }
        });
        $("#adminPhone").bind("keyup", function(event) {
            var regNumber = /^[0-9\+]*$/;
            var temp = $("#adminPhone").val();
            if(!regNumber.test(temp)) $("#adminPhone").val(temp.replace(/[^0-9\+]/g,""));
        });




        $(".btn-save").on("click", function(){
            // 로그인 아이디 체크 (이메일 주소 형식 체크)
            if($("#adminId").val() == null || $("#adminId").val() == "") {
                if(!$("#adminIdChkText").hasClass("text-danger")) $("#adminIdChkText").addClass("text-danger");
                $("#adminIdChkText").text("* 아이디를 정확히 입력해주세요.");
                $("#adminIdChkText").css("display", "block");
                $("#adminId").focus();
                return false;
            }
            // else if(!emailPattern.test($("#loginId").val())) {
            //     if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            //     $("#loginIdChkText").text("* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.");
            //     $("#loginIdChkText").css("display", "block");
            //     $("#loginId").focus();
            //     return false;
            // }
            // // 로그인 ID 중복확인 여부 체크
            // if($(".btn-email-duple").data("dupleyn") == "N") {
            //     $("#loginIdChkText").text("* 아이디 중복확인을 해주세요.");
            //     $("#loginIdChkText").css("display", "block");
            //     return false;
            // }

            if($("#adminPw").val() != null && $("#adminPw").val() != "") {
                if($("#adminPw").val() == null || $("#adminPw").val() == ""){
                    $("#adminPwChkText").text("* 비밀번호를 정확히 입력해 주세요.");
                    $("#adminPwChkText").css("display", "block");
                    $("#adminPw").focus();
                    return false;
                }
                var checkNumber = $("#adminPw").val().search(/[0-9]/g);
                var checkEnglish = $("#adminPw").val().search(/[a-z]/ig);
                var spe = $("#adminPw").val().search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
                //
                // if(!passwordPattern.test($("#adminPw").val())){
                //     $("#adminPwChkText").text("* 6~20자리의 영문, 숫자, 특수문자를 2개 이상 조합하시기 바랍니다.");
                //     $("#adminPwChkText").css("display", "block");
                //     $("#adminPw").focus();
                //     return false;
                // }
                if($("#adminPw").val().length < 8 || $("#adminPw").val().length > 20){

                    $("#adminPwChkText").text("* 8~20자리의 영문+숫자+특수문자를 조합하시기 바랍니다.");
                    $("#adminPwChkText").css("display", "block");
                    $("#adminPw").focus();
                    return false;

                }
                if(checkNumber <0 || checkEnglish <0 || spe < 0) {
                    $("#adminPwChkText").text("* 8~20자리의 영문+숫자+특수문자를 조합하시기 바랍니다.");
                    $("#adminPwChkText").css("display", "block");
                    $("#adminPw").focus();
                    return false;
                }
                if($("#adminPwAgain").val() == null || $("#adminPwAgain").val() == ""){
                    $("#adminPwAgainChkText").text("* 비밀번호를 재입력하시기 바랍니다.");
                    $("#adminPwAgainChkText").css("display", "block");
                    $("#adminPwAgain").focus();
                    return false;
                }
                if($("#adminPwAgain").val() != $("#adminPw").val()){
                    $("#adminPwAgainChkText").text("* 비밀번호를 동일하게 입력하시기 바랍니다.");
                    $("#adminPwAgainChkText").css("display", "block");
                    $("#loginPwAgain").focus();
                    return false;
                }
            }
            // console.log(emailPattern.test($("#adminEmail").val()));
            if(!emailPattern.test($("#adminEmail").val())){
                $("#adminEmailChkText").text("* 이메일 형태로 입력해주세요.");
                $("#adminEmailChkText").css("display", "block");
                return false;
            }

            if($("#adminPhone").val().length > 11) {
                $("#adminPhoneChkText").text("* 연락처는 최대 11자리를 넘을 수 없습니다.");
                $("#adminPhoneChkText").css("display", "block");
                $("#adminPhone").focus();
                return false;
            }
                // } else if(!phonePattern.test($("#phone").val())) {
            // } else if($("#adminPhone").val() != null && $("#adminPhone").val() != '' && !phonePattern.test($("#adminPhone").val())) {
            //     $("#adminPhoneChkText").text("* 연락처는 앞 2~4자리, 중간 3~4자리, 끝 4자리만 허용합니다.");
            //     $("#adminPhoneChkText").css("display", "block");
            //     $("#adminPhone").focus();
            //     return false;
            // }

            // 체크 메시지 초기화
            $(".text-danger").text("");

            if(confirm("관리자 정보를 수정 하시겠습니까?")) {
                var datas = $("#writeForm").serialize();
                $.ajax({
                    url: "/adminInfoSave",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("수정 되었습니다!");
                            $('#adminInfoModal').modal("hide"); //닫기
                            location.reload();
                        }else{
                            alert("수정 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                        }
                    }
                });
            }
        });
    });
</script>