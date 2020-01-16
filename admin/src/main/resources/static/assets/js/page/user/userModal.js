var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
var passwordPattern = /^(?=.*[a-z0-9])((?=.*\d)|(?=.*\W)).{6,20}$/;
var phonePattern = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;


$(function(){

    $(".input-form").on({
        keyup: function () {
            $(".text-danger").text("");
        },
        change: function () {
            $(".text-danger").text("");
        }
    });

    $("#phone").bind("keyup", function(event) {
        var regNumber = /^[0-9\+]*$/;
        var temp = $("#phone").val();
        if(!regNumber.test(temp))
        {
            $("#phoneChkText").css("display", "block");
            $("#phone").val(temp.replace(/[^0-9\+]/g,""));
        }
    });

    $(".btn-save").on("click", function(){
        // 로그인 아이디 체크 (이메일 주소 형식 체크)
        if($("#loginId").val() == null || $("#loginId").val() == "") {
            if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            $("#loginIdChkText").text("* 아이디를 정확히 입력해주세요.");
            $("#loginIdChkText").css("display", "block");
            $("#loginId").focus();
            return false;
        } else if(!emailPattern.test($("#loginId").val())) {
            if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            $("#loginIdChkText").text("* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.");
            $("#loginIdChkText").css("display", "block");
            $("#loginId").focus();
            return false;
        } 
        // 로그인 ID 중복확인 여부 체크
        if($(".btn-email-duple").data("dupleyn") == "N") {
            $("#loginIdChkText").text("* 아이디 중복확인을 해주세요.");
            $("#loginIdChkText").css("display", "block");
            return false;
        }

        // 사용자 등록, 수정 시 비밀번호 체크
        if($("#seq").val() == null || $("#seq").val() == "") {
            if($("#loginPw").val() == null || $("#loginPw").val() == ""){
                $("#loginPwChkText").text("* 비밀번호를 정확히 입력해 주세요.");
                $("#loginPwChkText").css("display", "block");
                $("#loginPw").focus();
                return false;
            }
            // if(!passwordPattern.test($("#loginPw").val())){
            //     $("#loginPwChkText").text("* 8~20자리의 영문, 숫자, 특수문자를 조합하시기 바랍니다.");
            //     $("#loginPwChkText").css("display", "block");
            //     $("#loginPw").focus();
            //     return false;
            // }
            var checkNumber = $("#loginPw").val().search(/[0-9]/g);
            var checkEnglish = $("#loginPw").val().search(/[a-z]/ig);
            var spe = $("#loginPw").val().search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
            if($("#loginPw").val().length < 8 || $("#loginPw").val().length > 32){

                $("#loginPwChkText").text("* 8~32자리의 영문+숫자+특수문자를 조합하시기 바랍니다.");
                $("#loginPwChkText").css("display", "block");
                $("#loginPw").focus();
                return false;

            }
            if(checkNumber <0 || checkEnglish <0 || spe < 0) {
                $("#loginPwChkText").text("* 8~32자리의 영문+숫자+특수문자를 조합하시기 바랍니다.");
                $("#loginPwChkText").css("display", "block");
                $("#loginPw").focus();
                return false;
            }
            if($("#loginPwAgain").val() == null || $("#loginPwAgain").val() == ""){
                $("#loginPwAgainChkText").text("* 비밀번호를 재입력하시기 바랍니다.");
                $("#loginPwAgainChkText").css("display", "block");
                $("#loginPwAgain").focus();
                return false;
            }
            if($("#loginPwAgain").val() != $("#loginPw").val()){
                $("#loginPwAgainChkText").text("* 비밀번호를 동일하게 입력하시기 바랍니다.");
                $("#loginPwAgainChkText").css("display", "block");
                $("#loginPwAgain").focus();
                return false;
            }
        } else {
            if($("#loginPw").val() != null && $("#loginPw").val() != "") {
                if($("#loginPw").val() == null || $("#loginPw").val() == ""){
                    $("#loginPwChkText").text("* 비밀번호를 정확히 입력해 주세요.");
                    $("#loginPwChkText").css("display", "block");
                    $("#loginPw").focus();
                    return false;
                }
                // if(!passwordPattern.test($("#loginPw").val())){
                //     $("#loginPwChkText").text("* 8~20자리의 영문, 숫자, 특수문자를 조합하시기 바랍니다.");
                //     $("#loginPwChkText").css("display", "block");
                //     $("#loginPw").focus();
                //     return false;
                // }
                var checkNumber = $("#loginPw").val().search(/[0-9]/g);
                var checkEnglish = $("#loginPw").val().search(/[a-z]/ig);
                var spe = $("#loginPw").val().search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
                if($("#loginPw").val().length < 8 || $("#loginPw").val().length > 32){

                    $("#loginPwChkText").text("* 8~32자리의 영문+숫자+특수문자를 조합하시기 바랍니다.");
                    $("#loginPwChkText").css("display", "block");
                    $("#loginPw").focus();
                    return false;

                }
                if(checkNumber <0 || checkEnglish <0 || spe < 0) {
                    $("#loginPwChkText").text("* 8~32자리의 영문+숫자+특수문자를 조합하시기 바랍니다.");
                    $("#loginPwChkText").css("display", "block");
                    $("#loginPw").focus();
                    return false;
                }
                if($("#loginPwAgain").val() == null || $("#loginPwAgain").val() == ""){
                    $("#loginPwAgainChkText").text("* 비밀번호를 재입력하시기 바랍니다.");
                    $("#loginPwAgainChkText").css("display", "block");
                    $("#loginPwAgain").focus();
                    return false;
                }
                if($("#loginPwAgain").val() != $("#loginPw").val()){
                    $("#loginPwAgainChkText").text("* 비밀번호를 동일하게 입력하시기 바랍니다.");
                    $("#loginPwAgainChkText").css("display", "block");
                    $("#loginPwAgain").focus();
                    return false;
                }
            }
        }

        //사용자 이름 체크
        if($("#name").val() == ""){
            $("#nameChkText").text("* 사용자 이름을 정확히 입력해주세요.");
            $("#nameChkText").css("display", "block");
            $("#name").focus();
            return false;
        }

        // 사용자 연락처 체크
        // if($("#phone").val() == null || $("#phone").val() == "") {
        //     $("#phoneChkText").text("* 사용자 연락처를 정확히 입력해주세요.");
        //     $("#phoneChkText").css("display", "block");
        //     $("#phone").focus();
        //     return false;
        // } else
        //     if($("#phone").val().length > 11) {
        //     $("#phoneChkText").text("* 연락처는 최대 11자리를 넘을 수 없습니다.");
        //     $("#phoneChkText").css("display", "block");
        //     $("#phone").focus();
        //     return false;
        // } else if(!phonePattern.test($("#phone").val())) {
        //&& !phonePattern.test($("#phone").val())
        if($("#phone").val() == '') {
            $("#phoneChkText").text("* 연락처를 입력하세요");
            $("#phoneChkText").css("display", "block");
            $("#phone").focus();
            return false;
        }

        // if($("#comName").val() == ""){
        //     // $(".alert-display").append('<p class="text-danger">회사명을 입력하시기 바랍니다.</p>');
        //     $("#comName").focus();
        //     return false;
        // }

        // if($("#position").val() == ""){
        //     // $(".alert-display").append('<p class="text-danger">직함을 입력하시기 바랍니다.</p>');
        //     $("#position").focus();
        //     return false;
        // }

        // if($("#level").val() == null || $("#level").val() == "") {
        //     $("#levelChkText").text("* 레벨을 선택하지 않았습니다. 항목을 선택해 주세요.");
        //     $("#levelChkText").css("display", "block");
        //     $("#level").focus();
        //     return false;
        // }
        // 체크 메시지 초기화
        $(".text-danger").text("");
        
        // 등록, 수정 메시지 적용 및 처리
        var message = "";
        if($("#seq").val() == null || $("#seq").val() == "") message = "등록";
        else message = "수정";

        if(confirm("사용자 정보를 "+message+"하시겠습니까?")) {
            var formData = new FormData($("#writeForm")[0]);
            console.log(formData);
            $.ajax({
                url: "/user/save",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    console.log(response);
                    if(response.result){
                        alert(message+" 되었습니다!");
                        $('#userModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert(message+" 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
    });

    $(".btn-email-duple").on("click", function(){
        var button = $(this);
        var loginId = $("#loginId").val();
        if(loginId == null || loginId == "") {
            if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            $("#loginIdChkText").text("* 아이디를 정확히 입력해주세요.");
            $("#loginIdChkText").css("display", "block");
            $("#loginId").focus();
            return false;
        } else if(!emailPattern.test($("#loginId").val())) {
            if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            $("#loginIdChkText").text("* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.");
            $("#loginIdChkText").css("display", "block");
            $("#loginId").focus();
            return false;
        } else {
            var datas = {
                loginId : loginId
            };
            $.ajax({
                url: "/user/duple_email",
                type: 'POST',
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    if(response.result){
                        button.data("dupleyn", "Y");
                        $("#loginIdChkText").text("* 사용 할 수 있는 아이디 입니다.");
                        $("#loginIdChkText").removeClass("text-danger");
                        $("#loginIdChkText").css("color", "#0080FF");
                        $("#loginIdChkText").css("display", "block");
                    }else{
                        var userSeq = response.userSeq;
                        var seq = $("#seq").val();
                        if(seq != null && seq != "") {
                            if(userSeq == seq) {
                                button.data("dupleyn", "Y");
                                $("#loginIdChkText").text("* 사용 할 수 있는 아이디 입니다.");
                                $("#loginIdChkText").removeClass("text-danger");
                                $("#loginIdChkText").css("color", "#0080FF");
                                $("#loginIdChkText").css("display", "block");
                                return;
                            }
                        }
                        button.data("dupleyn", "N");
                        if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
                        $("#loginIdChkText").text("* 중복된 아이디입니다.");
                        $("#loginIdChkText").css("display", "block");
                    }
                }, error: function (e) {
                    $("#loginIdChkText").text("* 중복확인 실패! 지속될 경우 사이트 관리자에게 문의해주세요.");
                    $("#loginIdChkText").css("display", "block");
                }
            });
        }
    });
});