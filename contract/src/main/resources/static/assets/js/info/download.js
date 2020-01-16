$(document).ready(function(){
    // $('.form-control').change(function(){
    //     if($('#trialEmail').val() == null || $('#trialEmail').val() == "") {
    //         $('#apply32Btn').attr("disabled", true);
    //         $('#apply64Btn').attr("disabled", true);
    //         return false
    //     }else if($('#trialPhone').val() == null || $('#trialPhone').val() == "") {
    //         $('#apply32Btn').attr("disabled", true);
    //         $('#apply64Btn').attr("disabled", true);
    //         return false
    //     }else if($('#trialCompany').val() == null || $('#trialCompany').val() == "") {
    //         $('#apply32Btn').attr("disabled", true);
    //         $('#apply64Btn').attr("disabled", true);
    //         return false
    //     }else if($('#trialPosition').val() == null || $('#trialPosition').val() == "") {
    //         $('#apply32Btn').attr("disabled", true);
    //         $('#apply64Btn').attr("disabled", true);
    //         return false
    //     }else if($('#macAddr').val() == null || $('#macAddr').val() == "") {
    //         $('#apply32Btn').attr("disabled", true);
    //         $('#apply64Btn').attr("disabled", true);
    //         return false
    //     }else {
    //         $('#apply32Btn').attr("disabled", false);
    //         $('#apply64Btn').attr("disabled", false);
    //         $('#trialExtension').attr("disabled", false);
    //     }
    // });

    $('#trialPhone').on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    $('#trialExtension').click(function(){
        var datas = $("#trialDownForm").serialize();
        $.ajax({
            url: "/api/trialExtension",
            type: 'GET',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result == true) {
                    alert("Trial 사용기간이 30일 연장되었습니다.");
//                     location.reload();
                }else {
                    alert("Trial 사용기간 연장 신청중 오류가 발생하였습니다. 다시 시도해주세요.");
                }
            }
        });
    });
});