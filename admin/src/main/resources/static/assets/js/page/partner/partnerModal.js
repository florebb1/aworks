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

    $("#tel").bind("keyup", function(event) {
        var regNumber = /^[0-9]*$/;
        var temp = $("#tel").val();
        if(!regNumber.test(temp)) $("#tel").val(temp.replace(/[^0-9]/g,""));
    });

    $("#bn1").bind("keyup", function(event) {
        var regNumber = /^[0-9]*$/;
        var temp = $("#bn1").val();
        if(!regNumber.test(temp)) $("#bn1").val(temp.replace(/[^0-9]/g,""));
    });

    $("#bn2").bind("keyup", function(event) {
        var regNumber = /^[0-9]*$/;
        var temp = $("#bn2").val();
        if(!regNumber.test(temp)) $("#bn2").val(temp.replace(/[^0-9]/g,""));
    });

    $("#bn3").bind("keyup", function(event) {
        var regNumber = /^[0-9]*$/;
        var temp = $("#bn3").val();
        if(!regNumber.test(temp)) $("#bn3").val(temp.replace(/[^0-9]/g,""));
    });

    $(".btn-save").on("click", function(){

        // 회사명 체크
        if($("#name").val() == null || $("#name").val() == ""){
            $("#nameChkText").text("* 회사명을 정확히 입력해주세요.");
            $("#nameChkText").css("display", "block");
            $("#name").focus();
            return false;
        }

        // 대표전화 체크
        if($("#tel").val() != null && $("#tel").val() != '' && !phonePattern.test($("#tel").val())) {
            $("#telChkText").text("* 대표전화는 앞 2~4자리, 중간 3~4자리, 끝 4자리만 허용합니다.");
            $("#telChkText").css("display", "block");
            $("#tel").focus();
            return false;
        } else if($("#tel").val().length > 11) {
            $("#telChkText").text("* 연락처는 최대 11자리를 넘을 수 없습니다.");
            $("#telChkText").css("display", "block");
            $("#tel").focus();
            return false;
        }

        // 사업자 번호 체크
        var bn1 = $("#bn1").val(), bn2 = $("#bn2").val(), bn3 = $("#bn3").val();
        if((bn1 != null && bn2 != null && bn3 != null) && (bn1 != "" && bn2 != "" && bn3 != "")) {
            var bn1_length = bn1.length, bn2_length = bn2.length, bn3_length = bn3.length;
            if(bn1_length < 3) {
                message();
                $("#bn1").focus();
                return false;
            } else if(bn2_length < 2 || bn2_length > 2) {
                message();
                $("#bn2").focus();
                return false;
            } else if(bn3_length < 5) {
                message();
                $("#bn3").focus();
                return false;
            }
            function message() {
                $("#businessNumberChkText").text("* 사업자 번호를 정확히 입력해주세요.");
                $("#businessNumberChkText").css("display", "block");
            }
        } else {
            bn1 = $("#bn1").val(''), bn2 = $("#bn2").val(''), bn3 = $("#bn3").val('');
        }
        // 사업자번호 자리수 체크 후 정상일 때 값 세팅
        if(bn1_length == 3 && bn2_length == 2 && bn3_length == 5) {
            $("#businessNumber").val(bn1 + "-" + bn2 + "-" + bn3);
            console.log($("#businessNumber").val());
        }

        // 체크 메시지 초기화
        $(".text-danger").text("");
        
        // 등록, 수정 메시지 적용 및 처리
        var message = "";
        if($("#seq").val() == null || $("#seq").val() == "") message = "등록";
        else message = "수정";

        if(confirm("파트너 정보를 "+message+"하시겠습니까?")) {
            var formData = new FormData($("#writeForm")[0]);
            $.ajax({
                url: "/partner/save",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    console.log(response);
                    if(response.result){
                        alert(message+" 되었습니다!");
                        $('#partnerModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert(message+" 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
    });
});