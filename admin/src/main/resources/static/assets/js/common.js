$(function(){


    // 사이드바
    $('#sidebarCollapse').on('click', function () {
        // console.log(1)
        $('#sidebar').toggleClass('active');
    });

    /* DatePicker Script */
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

// 날짜 포맷 변경
function getFormatDate(date){
    date = new Date(date);
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  // month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;
}

// 숫자 입력
function onlyNumInput(){
    var code = window.event.keyCode;
    console.log(code);
    if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105) || code == 110 || code == 190 || code == 8 || code == 9 || code == 13  || code == 44 || code == 46){

        window.event.returnValue = true;
        return;
    }
    window.event.returnValue = false;
}

// 한글 및 영문 제거
function fn_press_han(obj){
    // console.log(event.keyCode);
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 190  || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 190) return;
    // console.log(obj.value);
    console.log(obj);
    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z!@#$%^&*(),\-=\/`~<>?_+]/g, '');
    obj.value = obj.value.replace("\\.","");
    obj.value = obj.value.replace(/ /gi, "");
    // console.log(obj.value);
}
// url copy
function copyToClipboard(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
}