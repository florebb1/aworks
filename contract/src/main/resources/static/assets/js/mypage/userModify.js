$(document).ready(function () {
    // 유저정보 검색
    // $.ajax({
    //     url: "/mypage/info",
    //     type: 'GET',
    //     data: {
    //         loginId: $('#profileId').val()
    //     },
    //     dataType: 'JSON',
    //     success: function (response) {
    //         if(response.result == true) {
    //             if(response.user.name != null || response.user.name != "") {
    //                 $('#profileName').val(response.user.name);
    //             }
    //             if(response.user.phone != null || response.user.phone != "") {
    //                 $('#profileContact').val(response.user.phone);
    //             }
    //             if(response.user.comName != null || response.user.comName != "") {
    //                 $('#profileCompany').val(response.user.comName);
    //             }
    //             if(response.user.position != null || response.user.position != "") {
    //                 $('#profilePosition').val(response.user.position);
    //             }
    //         }else {
    //             alert("사용자 정보를 불러오는데 실패했습니다.");
    //             location.href = "/"
    //         }
    //     }
    // });

    //등록버튼 이벤트
    $("#profileBtn").click(function() {
        // var name = $('#profileName').val();
        // if(name == null || name == "") {
        //     alert("닉네임을 입력해 주세요.");
        //     return false
        // }
        if($("#profileName").val() == ""){
            alert("이름을 입력하세요.");
            return false;
        }

        if($("#profileContact").val() == ""){
            alert("연락처를 입력하세요.");
            return false;
        }
        if(confirm("정보를 수정하시겠습니까?")) {
            var datas = $("#profileForm").serialize();
            $.ajax({
                url: "/mypage/edit",
                type: 'POST',
                data: datas,
                dataType: 'JSON',
                success: function (response) {
                    if (response.result == true) {
                        alert("수정 처리 되었습니다.");
                        location.reload();
                    } else {
                        alert("수정중 오류가 발생했습니다.");
                    }
                }
            })
        }
    });
    //비밀번호 입력시 이벤트
    $("#originPw").change(function() {
        var pwVal = $.trim($('#originPw').val());
        var checkNumber = pwVal.search(/[0-9]/g);
        var checkEnglish = pwVal.search(/[a-z]/ig);
        if(pwVal == "") {
            $('#originPasswordHelp').text("비밀번호를 입력해주세요.");
            return false
        }else if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/.test(pwVal)){
            $('#originPasswordHelp').text("숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.");
            return false
        }else if(checkNumber <0 || checkEnglish <0) {
            $('#originPasswordHelp').text("숫자와 영문자를 혼용하여야 합니다.");
            return false
        }else {
            $('#originPasswordHelp').text("");
        }
    });
    $("#newPw").change(function() {
        var pwVal = $.trim($('#newPw').val());
        var checkNumber = pwVal.search(/[0-9]/g);
        var checkEnglish = pwVal.search(/[a-z]/ig);
        if(pwVal == "") {
            $('#newPasswordHelp').text("비밀번호를 입력해주세요.");
            return false
        }else if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/.test(pwVal)){
            $('#newPasswordHelp').text("숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.");
            return false
        }else if(checkNumber <0 || checkEnglish <0) {
            $('#newPasswordHelp').text("숫자와 영문자를 혼용하여야 합니다.");
            return false
        }else {
            $('#newPasswordHelp').text("");
        }
    });

    //비밀번호 수정 버튼
    $("#changPwBtn").click(function() {
        $('#changePwId').val($('#profileId').val());
        var pwVal = $.trim($('#originPw').val());
        var pwVal2 = $.trim($('#newPw').val());
        var pwVal3 = $.trim($('#newPw2').val());
        var checkNumber = pwVal.search(/[0-9]/g);
        var checkEnglish = pwVal.search(/[a-z]/ig);
        var checkNumber2 = pwVal2.search(/[0-9]/g);
        var checkEnglish2 = pwVal2.search(/[a-z]/ig);
        if (pwVal == "") {
            $('#originPasswordHelp').text("기존 비밀번호를 입력해주세요.");
            $('#originPw').focus();
            return false
        } else if (pwVal2 == "") {
            $('#newPasswordHelp').text("새로운 비밀번호를 입력해주세요.");
            $('#newPw').focus();
            return false
        } else if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/.test(pwVal)) {
            $('#originPasswordHelp').text("숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.");
            return false
        } else if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/.test(pwVal2)) {
            $('#newPasswordHelp').text("숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.");
            return false
        } else if (checkNumber < 0 || checkEnglish < 0) {
            $('#originPasswordHelp').text("숫자와 영문자를 혼용하여야 합니다.");
            return false
        } else if (checkNumber2 < 0 || checkEnglish2 < 0) {
            $('#newPasswordHelp').text("숫자와 영문자를 혼용하여야 합니다.");
            return false
        }else if(pwVal == pwVal2) {
            $('#newPasswordHelp').text("기존 비밀번호와 동일한 비밀번호입니다.");
            $('#newPw').focus();
            return false
        }else if(pwVal2 != pwVal3) {
            $('#newPasswordHelp2').text("비밀번호를 동일하게 입력해주세요.");
            $('#newPw2').focus();
            return false
        }else {
            $('#originPasswordHelp').text("");
            $('#newPasswordHelp').text("");
            $('#newPasswordHelp2').text("");
        }
        var datas = $("#changePwForm").serialize();
        $.ajax({
            url: "/mypage/pwModify",
            type: 'POST',
            data: datas,
            dataType: 'JSON',
            success: function (response) {
                console.log(response);
                if(response.result == true) {
                    alert("변경 처리 되었습니다.");
                    $('#change-pw-md').modal("hide");
                }else {
                    alert("변경중 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
                }
            }
        })
    });
});