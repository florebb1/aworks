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
        <form class="form-signin" id="loginForm" autocomplete="off" role="form" action="/auth" method="post" style="display: block">


            <div class="text-center mb-5">
                <h1><i class="icon-logo white-color"></i></h1>
                <!-- <img class="mb-4" src="/docs/4.2/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
                <p>Welcome Portal Administrator</p>
            </div>


            <div><i class="icon-user2 mr-2"></i>아이디</div>
            <div class="form-group mb-3 mt-2">
                <input type="text" name="username" id="inputEmail" class="form-control login-input-form" placeholder="ID" autocomplete="off" tabindex="-1">
                <#--  <label for="inputEmail">아이디를 입력해 주세요.</label>  -->
            </div>

            <div><i class="icon-lock-closed mr-2"></i>비밀번호</div>
            <div class="form-group mt-2">
                <input type="password" name="password" id="inputPassword" class="form-control password login-input-form" placeholder="Password" autocomplete="off">
                <#--  <label for="inputPassword">비밀번호를 입력해 주세요.</label>  -->
            </div>
            <div class="min-26px mb-3">
                <div id="loginChkText" class="text-warning" style="display: none"></div>
            </div>

            <div class="checkboxmb-3 mt-3">
                <div class="row">
                    <div class="col">
                        <label>
                            <input type="checkbox" id="saveForUserId" value="remember-me"> 아이디 기억하기
                        </label>
                    </div>
                    <div class="col text-right">
                        <a href="/findPassword">비밀번호 찾기</a>
                    </div>
                </div>
            </div>

            <button class="btn btn-lg btn-primary btn-block border-radius-none" type="submit">로그인</button>



        </form>
    </div>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="/assets/js/bootstrap.min.js"></script>
<script src="/assets/js/gijgo.min.js"></script>
<script src="/assets/js/main.js"></script>
<script>
    $(document).ready(function(){
        // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
        var inputEmail = getCookie("inputEmail");

        $("#inputEmail").val(inputEmail);
        $("#inputPassword").val("");
        var saveId = getCookie("saveId");
        if(saveId == "Y"){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
            $("#saveForUserId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
        }

        $("#saveForUserId").change(function(){ // 체크박스에 변화가 있다면,
            if($("#saveForUserId").is(":checked")){ // ID 저장하기 체크했을 때,
                // var inputEmail = $("#inputEmail").val();
                // setCookie("inputEmail", inputEmail, 365); // 365일 동안 쿠키 보관
                setCookie("saveId","Y",365);
            }else{ // ID 저장하기 체크 해제 시,
                // deleteCookie("inputEmail");
                deleteCookie("saveId");
            }
        });

        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
        $("#inputEmail").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
            if($("#saveForUserId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
                var inputEmail = $("#inputEmail").val();
                setCookie("inputEmail", inputEmail, 365); // 365일 동안 쿠키 보관
            }
        });

        $("#loginForm").submit(function(){
            if($("#saveForUserId").is(":checked")){ // ID 저장하기 체크했을 때,
                var inputEmail = $("#inputEmail").val();
                setCookie("inputEmail", inputEmail, 365); // 365일 동안 쿠키 보관
                setCookie("saveId","Y",365);
            }else{ // ID 저장하기 체크 해제 시,
                deleteCookie("inputEmail");
                deleteCookie("saveId");
            }
        })
    });

    function do_login(){
        if($('#username').val() == ''){
            $('.modal-body').html('<span>아이디를 입력하세요.</span>');
            $('.bs-example-modal-sm').modal('show');
            return false;
        }
        if($('#password').val() == ''){
            $('.modal-body').html('<span>비밀번호를 입력하세요.</span>');
            $('.bs-example-modal-sm').modal('show');
            return false;
        }
        $('#form_login').submit();
    }

    function setCookie(cookieName, value, exdays){
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
        document.cookie = cookieName + "=" + cookieValue;
    }

    function getCookie(cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if(start != -1){
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    }

    function deleteCookie(cookieName){
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }
</script>
</body>
</html>
