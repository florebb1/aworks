<!doctype html>
<html lang="ko">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- CSS -->
    <link rel="stylesheet" href="/assets/css/bootstrap.css"/>
    <link rel="stylesheet" href="/assets/css/bootstrap-reboot.css"/>
    <link rel="stylesheet" href="/assets/css/style.css"/>
    <link rel="stylesheet" href="/assets/css/icon.css"/>
    <link rel="stylesheet" href="/assets/css/gijgo.min.css"/>
    <!-- favicons -->
    <link rel="shortcut icon" href="/assets/images/mark.ico" type="image/x-icon">
    <link rel="icon" href="/assets/images/mark.ico" type="image/x-icon">
    <!-- title -->
    <title>a.works Super</title>
</head>

<body>
<div class="login-wrapper">
    <div class="login-body-wrapper d-flex align-items-center">
        <form class="form-signin" id="findPasswordForm" autocomplete="off" role="form" style="display: block">


            <div class="text-center mb-5">
                <h1><i class="icon-logo white-color"></i></h1>
                <!-- <img class="mb-4" src="/docs/4.2/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
                <p>Welcome Portal Administrator</p>
            </div>


            <div><i class="icon-tel mr-2"></i>연락처</div>
            <div class="form-group mt-2">
                <#--<input type="text" name="username" id="inputEmail" class="form-control login-input-form" placeholder="Email address" required="" autocomplete="off" tabindex="-1">-->
                <#--<label for="inputEmail">아이디를 입력해 주세요.</label>-->
                <input type="text" name="adminPhone" id="adminPhone" class="form-control findpw-input-form" placeholder="- 제외 입력" autocomplete="off" tabindex="-1">
                <#--  <label for="adminPhone">연락처를 입력해 주세요.</label>  -->
                <#--<div id="adminPhoneChkText" class="text-warning" style="display: none"></div>-->
            </div>

            <div><i class="icon-at-symbol mr-2"></i>이메일</div>
            <div class="form-group mt-2">
                <#--<input type="password" name="password" id="inputPassword" class="form-control password login-input-form" placeholder="Password" required="" autocomplete="off">-->
                <#--<label for="inputPassword">비밀번호를 입력해 주세요.</label>-->
                <input type="text" name="adminEmail" id="adminEmail" class="form-control findpw-input-form" placeholder="Email Address" autocomplete="off">
                <#--  <label for="adminEmail">이메일주소를 입력해 주세요.</label>  -->

            </div>

            <div class="min-26px mb3">
                <div id="adminPhoneChkText" class="text-warning" style="display: none"></div>
                <div id="adminEmailChkText" class="text-warning" style="display: none"></div>
            </div>

            <button class="btn btn-lg btn-primary btn-block border-radius-none mt-3" id="btnEmailGo" type="button">임시 비밀번호 발송</button>


        </form>
    </div>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="//code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/gijgo.min.js"></script>
<script src="/assets/js/main.js"></script>
<script>
    $(document).ready(function(){
        // $(".findpw-input-form").on({
        //     keyup: function () {
        //         $(".text-danger").text("");
        //     },
        //     change: function () {
        //         $(".text-danger").text("");
        //     }
        // });

        $("#adminPhone").on("keyup", function(){
            $("#adminPhoneChkText").text("");
        });
        $("#adminEmail").on("keyup", function(){
            $("#adminEmailChkText").text("");
        });

        // 정산 담당자 연락처 정규식 체크
        $("#adminPhone").bind("keyup", function(event) {
            var regNumber = /^[0-9]*$/;
            var temp = $("#adminPhone").val();
            if(!regNumber.test(temp))
            {
                $("#adminPhoneChkText").css("display", "block");
                $("#adminPhone").val(temp.replace(/[^0-9]/g,""));
            }
        });
        $("#btnEmailGo").on("click", function () {
            var phonePattern = /\d{2,4}-\d{3,4}-\d{4}/;
            if($("#adminPhone").val() == null || $("#adminPhone").val() == "") {
                $("#adminPhoneChkText").text("* 연락처를 정확히 입력해주세요.");
                $("#adminPhoneChkText").css("display", "block");
                return false;
            } else if($("#adminPhone").val().length > 11) {
                $("#adminPhoneChkText").text("* 연락처는 최대 11자리를 넘을 수 없습니다.");
                $("#adminPhoneChkText").css("display", "block");
                return false;
            } else if(phonePattern.test($("#adminPhone").val())) {
                $("#adminPhoneChkText").text("* 연락처는 앞 2~4자리, 중간 3~4자리, 끝 4자리만 허용합니다.");
                $("#adminPhoneChkText").css("display", "block");
                return false;
            }

            // var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            var emailPattern = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
            if($("#adminEmail").val() == null || $("#adminEmail").val() == "") {
                $("#adminEmailChkText").text("* 이메일주소를 정확히 입력해주세요.");
                $("#adminEmailChkText").css("display", "block");
                return false;
            } else if(!emailPattern.test($("#adminEmail").val())) {
                $("#adminEmailChkText").text("* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.");
                $("#adminEmailChkText").css("display", "block");
                return false;
            }

            var datas = $("#findPasswordForm").serialize();
            $.ajax({
                url: "/admin/findPassword",
                type: 'POST',
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    var messeage = response.message;
                    console.log(response);
                    if(response.result){
                        alert("임시 비밀번호가 발급되었습니다.\n발송된 이메일을 확인 후 로그인해주세요.");
                        location.href="/login";
                    }else{
                        if(response.message != null && response.message != "") {
                            alert(response.message);
                        } else {
                            alert("임시 비밀번호 발급실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                        }
                    }
                }
            });
        });
    });
</script>
</body>
</html>
