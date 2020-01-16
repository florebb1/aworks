
/* ### Main Top Nav fixed Animation  ### */

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
    if (str == null || str == 'null' || typeof str == 'undefined' || str == '')
        return false;
    else
        return true;
}

$(window).on("scroll", function() {
    if($(window).scrollTop() > 0) {
        $(".new-header").addClass("active");
    } else {
        $(".new-header").removeClass("active");
    }
});

/* ### Sub Top Nav fixed Animation  ### */

$(window).on("scroll", function() {
    if($(window).scrollTop() > 0) {
        $(".new-sub-header").addClass("active");
    } else {
        $(".new-sub-header").removeClass("active");
    }
});

/* ### Middle Recommend item Carousel  ### */

$('#recipeCarousel').carousel({
    interval: 10000
});

// $('.carousel .carousel-item').each(function(){
//     var next = $(this).next();
//     if (!next.length) {
//         next = $(this).siblings(':first');
//     }
//     next.children(':first-child').clone().appendTo($(this));

//     if (next.next().length>0) {
//         next.next().children(':first-child').clone().appendTo($(this));
//     }
//     else {
//         $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
//     }
// });

/* ### page-section dotted navigation  ### */

$(document).ready(function() {
    // $('a[href*=\\#]').bind('click', function(e) {
    //     e.preventDefault();
    //     var target = $(this).attr("href");
    //     $('html, body').stop().animate({
    //             scrollTop: $(target).offset().top
    //     }, 100, function() {
    //             location.hash = target;
    //     });
    //     return false;
    // });
    $('#datestart').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true,
        clearBtn: true

    });
    $('#dateend').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true,
        clearBtn: true
    });

});

$(window).scroll(function() {
    var scrollDistance = $(window).scrollTop();
    $('.page-section').each(function(i) {
        if ($(this).position().top <= scrollDistance) {
            $('.navigation a.active').removeClass('active');
            $('.navigation a').eq(i).addClass('active');
        }
    });
}).scroll();

var findPwBtn = function(){
    var idVal = $.trim($('#findPwEmail').val());
    // var regExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    var regExp2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
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
            console.log(response);
            if(response.result == true) {
                alert("이메일로 임시 비밀번호 발송되었습니다.");
                $('#find-pw-md').modal("hide");
            }else {
                $('#findPwEmailHelp').text("이메일을 다시 확인해주시기 바랍니다");
                $('#findPwEmail').focus();
            }
        }
    });
}

var loginIdChange = function(){
    var idVal = $.trim($('#loginId').val());
    // var idRegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    var idRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
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
}

var loginPwChange = function(){
    var pwVal = $('#loginPw').val();
    if(pwVal == "") {
        $('#loginPasswordHelp').text("비밀번호를 입력해주세요.");
        $('#loginPw').focus();
        return false;
    }else {
        $('#loginPasswordHelp').text("");
    }
}

var loginBtnClick = function(){
    var idVal = $.trim($('#loginId').val());
    var pwVal = $.trim($('#loginPw').val());
    // var idRegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    var idRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
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
        $('#loginPasswordHelp').text("이메일 혹은 비밀번호를 다시 확인해주시기 바랍니다.");
        $('#loginPw').focus();
        return false;
    }else if(pwVal.length < 8 || pwVal.length > 20) {
        $('#loginPasswordHelp').text("이메일 혹은 비밀번호를 다시 확인해주시기 바랍니다.");
        $('#loginPw').focus();
        return false;
    }else if(checkNumber <0 || checkEnglish <0 || spe < 0) {
        $('#loginPasswordHelp').text("이메일 혹은 비밀번호를 다시 확인해주시기 바랍니다.");
        $('#loginPw').focus();
        return false;
    }
    $('#loginEmailHelp').text("");
    $('#loginPasswordHelp').text("");
    var datas = $("#loginFrm").serialize();
    $.ajax({
        url: "/api/login",
        type: 'POST',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            if(response.result == true) {
                if($("#loginSave").prop("checked")){
                    setCookie("loginId", idVal, 365);
                }else {
                    deleteCookie("loginId");
                }
                location.reload();
            }else {
                $('#loginPasswordHelp').text("이메일 혹은 비밀번호를 다시 확인해주시기 바랍니다.");
                $('#loginPw').val("");
                $('#loginId').focus();
            }
        }
    });
}

var signIdChange = function(){
    var idVal = $.trim($('#signId').val());
    // var RegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    var RegExp2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
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
}

var signPwChange = function(){
    var pwVal = $.trim($('#signPw').val());
    var checkNumber = pwVal.search(/[0-9]/g);
    var checkEnglish = pwVal.search(/[a-z]/ig);
    // var pwcheck = /^[a-zA-Z0-9]{8,20}$/;
    var spe = pwVal.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
    if(pwVal == ""){
        $('#signPasswordHelp').text("비밀번호를 입력하세요.");
        return false;
    }
    if(pwVal.length < 8 || pwVal.length > 32){

        $('#signPasswordHelp').text("8~32자리 영문+숫자+특수문자로 입력하세요");
        // $('#signPw').val('').focus();
        return false;

    }

    if(checkNumber <0 || checkEnglish <0 || spe < 0) {
        $('#signPasswordHelp').text("8~32자리 영문+숫자+특수문자로 입력하세요");
        // $('#signPw').val('').focus();
        return false;
    }else {
        $('#signPasswordHelp').text("");
    }
    return true;
}

var signBtnClick = function(){
    var idVal = $.trim($('#signId').val());
    var idVal2 = $.trim($('#signId2').val());
    var pwVal = $.trim($('#signPw').val());
    var pwVal2 = $.trim($('#signPw2').val());
    var checkNumber = pwVal.search(/[0-9]/g);
    var checkEnglish = pwVal.search(/[a-z]/ig);
    // var RegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    var RegExp2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    var spe = pwVal.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

    switch(true){
        case (idVal == ''):
            $('#signEmailHelp').text("이메일을 입력하세요.");
            $('#signId').focus();
            return false;
            break;
        case (!RegExp2.test(idVal)):
            $('#signEmailHelp').text("잘못된 이메일형식입니다. 다시 입력해 주세요.");
            $('#signId').focus();
            return false;
            break;
        case (idVal2 == ""):
            $('#signEmailHelp').text("이메일 중복확인을 해주세요.");
            return false;
            break;
        case (idVal != idVal2):
            $('#signEmailHelp').text("이메일 중복확인을 해주세요.");
            $('#signId').focus();
            return false;
            break;
        case (pwVal == ""):
            $('#signPasswordHelp').text("비밀번호를 입력하세요.");
            return false;
            break;
        case (pwVal.length < 8 || pwVal.length > 32):
            $('#signPasswordHelp').text("8~32자리 영문+숫자+특수문자로 입력하세요");
            return false;
            break;
        case (checkNumber <0 || checkEnglish <0 || spe < 0):
            $('#signPasswordHelp').text("8~32자리 영문+숫자+특수문자로 입력하세요");
            return false;
            break;
        case (pwVal != pwVal2):
            $('#signPasswordHelp2').text("비밀번호를 동일하게 입력하세요");
            $('#signPw2').focus();
            return false;
            break;
        case ($("#name").val() == ""):
            $('#signNameHelp').text("이름을 입력하세요.");
            return false;
            break;
        case ($("#phone").val() == ""):
            $('#signPhoneHelp').text("연락처를 입력하세요.");
            return false;
            break;
        default:
            $('#signEmailHelp').text("");
            $('#signPasswordHelp').text("");
            $('#signPasswordHelp2').text("");
    }

    if(!$("#agree").is(":checked")){
        alert("이용약관 및 개인정보처리방침에 동의해 주시기 바랍니다.");
        return false;
    }

    var datas = $("#signFrm").serialize();
    $.ajax({
        url: "/api/signup",
        type: 'POST',
        dataType: 'JSON',
        data: {
            loginId: idVal,
            loginPw: pwVal,
            name : $("#name").val(),
            phone : $("#phone").val()
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
}

var signIdChkClick = function(){
    var idVal = $.trim($('#signId').val());
    // var idRegExp = /[a-z0-9_]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    var idRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if(idVal == "") {
        $('#signEmailHelp').text("이메일을 입력하세요.");
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
}
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

    // 임시 비밀번호 발급 번튼 클릭 이벤트
    $('#findPwBtn').click(function(){
        findPwBtn();

    });
    //로그인 아이디 변경시
    $('#loginId').change(function(){
        loginIdChange();

    });
    $('#loginPw').change(function(){
        loginPwChange();

    });

    // 로그인 버튼 클릭 이벤트
    $('#loginBtn').click(function(){
        loginBtnClick();

    });
    // 회원가입 폼 아이디 입력 변경시
    $('#signId').change(function(){
        signIdChange();

    });


    // 회원가입 폼 비밀번호 입력 변경시
    $('#signPw').change(function(){
        signPwChange();
    });

    $('#name').change(function(){
        $('#signNameHelp').text("");
    });

    $('#phone').change(function(){
        $('#signPhoneHelp').text("");
    });
    // 회원가입 버튼 클릭 이벤트
    $('#signBtn').click(function(){
        signBtnClick();
    });
    // 회원가입 아이디 중복체크
    $('#signIdChk').click(function(){
        signIdChkClick();
    });
    $('.modal').on('hidden.bs.modal', function (e) {
        $('small').text("");
        try{
            $(this).find('form')[0].reset()
        }catch(e){

        }

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

    $(document).on('change', '.custom-file-input', function (event) {
        $(this).next('.custom-file-label').html(event.target.files[0].name);
    });

});

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

function onlyNumDecimalInput(){
    var code = window.event.keyCode;
    // console.log(code);
    if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105) || code == 110 || code == 190 || code == 8 || code == 9 || code == 13 || code == 46 || code == 44){

        window.event.returnValue = true;
        return;
    }
    window.event.returnValue = false;
}

function onlyNumInput(){
    var code = window.event.keyCode;
    // console.log(code);
    if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105) || code == 110 || code == 190 || code == 8 || code == 9 || code == 13  || code == 44){

        window.event.returnValue = true;
        return;
    }
    window.event.returnValue = false;
}
function fn_press_han(obj){
    // console.log(event.keyCode);
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190 || event.keyCode == 32 || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 190) return;
    // console.log(obj.value);
    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]/g, '');
    // console.log(obj.value);
}