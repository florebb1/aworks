$(function(){
    $("#btnContactus").click(function(){
        var RegExp2 = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        var name = $("#contactusName").val();
        var email = $("#contactusEmail").val();
        var comname = $("#contactusComName").val();
        var comphone = $("#contactusPhone").val();
        var content = $("#contactusContent").val();
        $('#contactusNameStr').text("");
        $('#contactusEmailStr').text("");
        $('#contactusComNameStr').text("");
        $('#contactusPhoneStr').text("");
        $('#contactusContentStr').text("");
        if(name == ""){
            $('#contactusNameStr').text("이름을 입력해주세요.");
            $('#contactusName').focus();
            return false;
        }

        if(email == ""){
            $('#contactusEmailStr').text("이메일을 입력해주세요.");
            $('#contactusEmail').focus();
            return false;
        }

        if(!RegExp2.test(email)) {
            $('#contactusEmailStr').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#contactusEmail').focus();
            return false;
        }

        if(comname == ""){
            $('#contactusComNameStr').text("회사명을 입력해주세요.");
            $('#contactusComName').focus();
            return false;
        }

        if(comphone == ""){
            $('#contactusPhoneStr').text("연락처를 입력해주세요.");
            $('#contactusPhone').focus();
            return false;
        }

        if(content == ""){
            $('#contactusContentStr').text("문의내용을 입력해주세요.");
            $('#contactusContent').focus();
            return false;
        }

        var datas = $("#contactusFrm").serialize();
        $.ajax({
            url: "/api/contactus",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if (response.result == true) {
                    alert("문의내용이 등록 되었습니다.");
                    $('#contactus-lg').modal("hide");
                }else {
                    alert("문의내용 등록 시 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
                }
            }
        });
    })
})

$(".form-control").keydown(function(key) {
    if (key.keyCode == 13) {
        $("#loginBtn").click();
    }
});
