/* ### Main Top Nav fixed Animation  ### */

$(window).on("scroll", function() {
    if($(window).scrollTop() > 0) {
        $(".header").addClass("active");
    } else {
        $(".header").removeClass("active");
    }
});

/* ### Sub Top Nav fixed Animation  ### */

$(window).on("scroll", function() {
    if($(window).scrollTop() > 0) {
        $(".sub-header").addClass("active");
    } else {
        $(".sub-header").removeClass("active");
    }
});

/* ### Middle Recommend item Carousel  ### */

$('#recipeCarousel').carousel({
    interval: 10000
});

$('.carousel .carousel-item').each(function(){
    var next = $(this).next();
    if (!next.length) {
        next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));

    if (next.next().length>0) {
        next.next().children(':first-child').clone().appendTo($(this));
    }
    else {
        $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
    }
});

/* ### Tooltip  ### */

$(function () {
    $('[data-toggle="tooltip"]').tooltip();

    var url = $(location).attr('pathname');
    var market = "/market";
    var board = "/board";
    if(url.search(market) !== -1){
       $("#market").addClass("active");
    }
    if(url.search(board) !== -1){
        $("#support").addClass("active");
    }
    // 첨부파일 라벨링 적용
    $(document).on('change', '.custom-file-input', function (event) {
        $(this).next('.custom-file-label').html(event.target.files[0].name);
    });

    // 임시 비밀번호 발급 번튼 클릭 이벤트
    $('#findPwBtn').click(function(){
        var idVal = $.trim($('#findPwEmail').val());
        var regExp2 = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        if(idVal == "") {
            $('#findPwEmailHelp').text("이메일을 입력해주세요.");
            $('#findPwEmail').focus();
            return false;
        }else if(idVal.match(regExp2) == null) {
            $('#findPwEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#findPwEmail').focus();
            return false;
        }else {
            $('#findPwEmailHelp').text("");
        }
        var datas = $("#findPwFrm").serialize();
        $.ajax({
            url: "/api/searchPw",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result == true) {
                    alert("이메일로 임시 비밀번호 발송되었습니다.");
                    $('#find-pw-md').modal("hide");
                }else {
                    $('#findPwEmailHelp').text("가입된 정보가 없습니다. 다시 확인해주시기 바랍니다");
                    $('#findPwEmail').focus();
                }
            }
        });
    });
    //로그인 아이디 변경시
    $('#loginId').change(function(){
        var idVal = $.trim($('#loginId').val());
        var idRegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        if(idVal == "") {
            $('#loginEmailHelp').text("이메일을 입력해주세요.");
            $('#loginId').focus();
            return false;
        }else {
            $('#loginEmailHelp').text("");
        }
        if(idVal.match(idRegExp) == null) {
            $('#loginEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#loginId').focus();
            return false;
        }else {
            $('#loginEmailHelp').text("");
        }
    });
    $('#loginPw').change(function(){
        var pwVal = $('#loginPw').val();
        if(pwVal == "") {
            $('#loginPasswordHelp').text("비밀번호를 입력해주세요.");
            $('#loginPw').focus();
            return false;
        }else {
            $('#loginPasswordHelp').text("");
        }
    });

    // 로그인 버튼 클릭 이벤트
    $('#loginBtn').click(function(){
        var idVal = $.trim($('#loginId').val());
        var pwVal = $.trim($('#loginPw').val());
        var idRegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        var checkNumber = pwVal.search(/[0-9]/g);
        var checkEnglish = pwVal.search(/[a-z]/ig);
        // var pwcheck = /^[a-zA-Z0-9]{8,20}$/;
        var spe = pwVal.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
        if(idVal == "") {
            $('#loginEmailHelp').text("이메일을 입력해주세요.");
            $('#loginId').focus();
            return false;
        }else if(idVal.match(idRegExp) == null) {
            $('#loginEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#loginId').focus();
            return false;
        }else if(pwVal == "") {
            $('#loginPasswordHelp').text("비밀번호를 입력해주세요.");
            $('#loginPw').focus();
            return false;
        }else if(pwVal.length < 8 || pwVal.length > 20) {
            $('#loginPasswordHelp').text("8~20자리로 입력해주시기 바랍니다.");
            $('#loginPw').focus();
            return false;
        }else if(checkNumber <0 || checkEnglish <0 || spe < 0) {
            $('#loginPasswordHelp').text("숫자+영문자+특수문자를 혼용하여야 합니다.");
            $('#loginPw').focus();
            return false;
        }else {
            $('#loginEmailHelp').text("");
            $('#loginPasswordHelp').text("");
        }
        var datas = $("#loginFrm").serialize();
        $.ajax({
            url: "/api/login",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result == true) {
                    if($("#loginSave").prop("checked")){
                        setCookie("loginId", idVal, 365);
                    }else {
                        deleteCookie("loginId");
                    }
                    // sessionStorage.setItem("loginId", idVal);
                    // sessionStorage.setItem("loginName", response.user.name);
                    // sessionStorage.setItem("profileImg", response.user.profileImg);
                    // $('#login-md').modal("hide");
                    location.reload();
                }else {
                    $('#loginPasswordHelp').text("가입된 정보가 없습니다. 다시 확인해주시기 바랍니다.");
                    $('#loginPw').val("");
                    $('#loginId').focus();
                }
            }
        });
    });
    // 회원가입 폼 아이디 입력 변경시
    $('#signId').change(function(){
        var idVal = $.trim($('#signId').val());
        var RegExp2 = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        if(idVal == "") {
            $('#signEmailHelp').text("이메일을 입력해주세요.");
            $('#signId').focus();
            return false;
        }else if(!RegExp2.test(idVal)) {
            $('#signEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#signId').focus();
            return false;
        }else {
            $('#signEmailHelp').text("");
        }
    });
    // 회원가입 폼 비밀번호 입력 변경시
    $('#signPw').change(function(){
        var pwVal = $.trim($('#signPw').val());
        var checkNumber = pwVal.search(/[0-9]/g);
        var checkEnglish = pwVal.search(/[a-z]/ig);
        // var pwcheck = /^[a-zA-Z0-9]{8,20}$/;
        var spe = pwVal.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
        if(pwVal == ""){
            $('#signPasswordHelp').text("비밀번호를 입력해주세요.");
            return false;
        }
        if(pwVal.length < 8 || pwVal.length > 20){

            $('#signPasswordHelp').text("8~20자리로 입력해주시기 바랍니다.");
            // $('#signPw').val('').focus();
            return false;

        }

        if(checkNumber <0 || checkEnglish <0 || spe < 0) {
            $('#signPasswordHelp').text("숫자+영문자+특수문자를 혼용하여야 합니다.");
            // $('#signPw').val('').focus();
            return false;
        }else {
            $('#signPasswordHelp').text("");
        }
        return true;
    });
    $('#signPw2').change(function(){
        var pwVal = $.trim($('#signPw').val());
        var pwVal2 = $.trim($('#signPw2').val());
        if(pwVal == ""){
            $('#signPasswordHelp').text("비밀번호를 입력해주세요.");
        }else if(pwVal != pwVal2){
            $('#signPasswordHelp2').text("비밀번호확인이 일치하지 않습니다.");
            return false;
        }else {
            $('#signPasswordHelp2').text("");
        }
        return true;
    });

    // 회원가입 버튼 클릭 이벤트
    $('#signBtn').click(function(){
        var idVal = $.trim($('#signId').val());
        var idVal2 = $.trim($('#signId2').val());
        var pwVal = $.trim($('#signPw').val());
        var pwVal2 = $.trim($('#signPw2').val());
        var checkNumber = pwVal.search(/[0-9]/g);
        var checkEnglish = pwVal.search(/[a-z]/ig);
        var RegExp2 = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        var spe = pwVal.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
        if(idVal == "") {
            $('#signEmailHelp').text("이메일을 입력해주세요.");
            $('#signId').focus();
            return false;
        }else if(!RegExp2.test(idVal)) {
            $('#signEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#signId').focus();
            return false;
        }else if(idVal2 == "") {
            $('#signEmailHelp').text("이메일 중복확인을 해주세요.");
            return false;
        }else if(idVal != idVal2) {
            $('#signEmailHelp').text("가입 시 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
            $('#signId').focus();
            return false;
        }
        if(pwVal == "") {
            $('#signPasswordHelp').text("비밀번호를 입력해주세요.");
            return false;
        }
        if(pwVal.length < 8 || pwVal.length > 20){

            $('#signPasswordHelp').text("8~20자리로 입력해주시기 바랍니다.");
            // $('#signPw').val('').focus();
            return false;

        }
        if(checkNumber <0 || checkEnglish <0 || spe < 0) {
            $('#signPasswordHelp').text("숫자+영문자+특수문자를 혼용하여야 합니다.");
            return false;
        }
        if(pwVal != pwVal2) {
            $('#signPasswordHelp2').text("비밀번호와 비밀번호 확인이 다릅니다. 다시 확인해주시기 바랍니다.");
            $('#signPw2').focus();
            return false;
        }else {
            $('#signEmailHelp').text("");
            $('#signPasswordHelp').text("");
            $('#signPasswordHelp2').text("");
        }
        var datas = $("#signFrm").serialize();
        $.ajax({
            url: "/api/signup",
            type: 'POST',
            dataType: 'JSON',
            data: {
                loginId: idVal,
                loginPw: pwVal
            },
            success: function (response) {
                if (response.result == true) {
                    alert("가입 처리 되었습니다.");
                    $('#join-md').modal("hide");
                }else {
                    alert("가입 시 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
                }
            }
        });
    });
    // 회원가입 아이디 중복체크
    $('#signIdChk').click(function(){
        var idVal = $.trim($('#signId').val());
        var idRegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
        if(idVal == "") {
            $('#signEmailHelp').text("아이디가 빈값입니다.");
            return false;
        }else {
            $('#signEmailHelp').text("");
        }
        if(idVal.match(idRegExp) == null) {
            $('#signEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#signId').focus();
            return false;
        }else {
            $('#signId2').val(idVal);
            $('#signEmailHelp').text("");
        }
        $.ajax({
            url: "/api/idChk",
            type: 'POST',
            dataType: 'JSON',
            data: {
                loginId: idVal
            },
            success: function (response) {
                if (response.result == true) {
                    $("#signId2").val(idVal);
                    $('#signEmailHelp').text("사용가능한 이메일입니다.");
                }else {
                    $('#signEmailHelp').text("이메일이 중복입니다.");
                }
            }
        });
    });

    $('.modal').on('hidden.bs.modal', function (e) {
        $('small').text("");
        $(this).find('form')[0].reset()
    });
    $('#login-md').on('show.bs.modal', function (e) {
        var id = getCookie("loginId");
        if(id !== ""){
            $("#loginId").val(id);
            $("#loginSave").prop('checked', true);
        }
    });
    //로그아웃
    $('#logout').click(function(){
        location.reload();
    });
});
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
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
function isEmpty(str) {
    if (str == null || typeof str == 'undefined' || str == 'null' || str == '')
        return false;
    else
        return true;
}
var getParameter = function (param) {
    var returnValue;
    var url = location.href;
    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
    for (var i = 0; i < parameters.length; i++) {
        var varName = parameters[i].split('=')[0];
        if (varName.toUpperCase() == param.toUpperCase()) {
            returnValue = parameters[i].split('=')[1];
            return decodeURIComponent(returnValue);
        }
    }
};
function paging(pageValue) {
    if(window.location.search != "") {
        var query = window.location.search.replace("?", "");
        query = query.split("&");
        query.forEach(function (one, i) {
            console.log(one.indexOf("page="));
            if (one.indexOf("page=") > -1) {
                query.splice(i, 1);
            }
        });
        query.push("page=" + pageValue);
        query = query.join("&");
        document.location.href = "?"+query;
    }else{
        document.location.href = "?page="+pageValue;
    }
}