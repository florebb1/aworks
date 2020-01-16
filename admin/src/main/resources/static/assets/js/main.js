/*!
# A.Works Super script
# Laidback david 2019.01.06
*/

$(document).ready(function () {

    $('#adminInfoModal').on('show.bs.modal', function (event) {
        console.log(1111);
        $.ajax({
            url: "/adminInfo?adminId=administrator",
            type: 'POST'
            //ascyc: false
        }).done(function (response) {
            $("#adminInfo-modal-view").html(response);
        });
    });

    // 첨부파일 라벨링 적용
    $(document).on('change', '.custom-file-input', function (event) {
        $(this).next('.custom-file-label').html(event.target.files[0].name);
    });

    var Request = function()
    {
        this.getParameter = function( name )
        {
            var rtnval = "";
            var nowAddress = unescape(location.href);
            var parameters = (nowAddress.slice(nowAddress.indexOf("?")+1,nowAddress.length)).split("&");

            for(var i = 0 ; i < parameters.length ; i++)
            {
                var varName = parameters[i].split("=")[0];
                if(varName.toUpperCase() == name.toUpperCase())
                {
                    rtnval = parameters[i].split("=")[1];
                    break;
                }
            }
            return rtnval;
        }
    };

    var request = new Request();
    var loginChk = request.getParameter("message");
    if(loginChk != null && loginChk != "") {
        $("#loginChkText").text("* 로그인 정보가 올바르지 않습니다. 다시 시도하세요.");
        $("#loginChkText").css("display", "block");
    }

    $(".login-input-form").on("keyup", function () {
        $("#loginChkText").css("display", "none");
    });

    $('.modal').on('hidden.bs.modal', function (e) {
        $('small').text("");
        try{
            $(this).find('form')[0].reset()
        }catch(e){

        }

    });

});

