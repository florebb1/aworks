$(function () {
    var view = getParameter("chk");
    if(!(view == null && view == undefined)) {
        $("#criteria").val(view);
    }else {
        $("#criteria").val(0);
    }
    var page = 0;
    $("#page").val(page);
    $.ajax({
        url: '/market/list',
        type: 'GET',
        dataType: 'json',
        data: {
            page: $("#page").val(),
            search: $("#search").val(),
            criteria: $("#criteria").val(),
            componentArr: $("#componentArr").val(),
            bussinessArr: $("#bussinessArr").val(),
            applicationArr: $("#applicationArr").val()
        },
        success: function (response) {
            console.log(response);
            var list = "";
            for (var i = 0; i < response.list.length; i++) {
                var rating = response.list[i].ratingAvg;
                rating = parseInt(rating) / 5 * 100;
                var updateDatetime = response.list[i].lastUpdate;
                if(updateDatetime === null){
                    updateDatetime = response.list[i].createDatetime;
                }
                var newDate = new Date(updateDatetime);
                var yyyy = newDate.getFullYear();
                var mm = cfSetAddZero(newDate.getMonth()+1);
                var dd = cfSetAddZero(newDate.getDate());
                var formattedDate = yyyy + "-" + mm + "-" + dd;
                list += '<div class="col-4 mb-3">'
                    + '<a href="/market/view?marketId='+response.list[i].seq+'" class="card">';
                    if(response.list[i].security != null && parseInt(response.list[i].security) !== 0) {
                        list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                            + '<i class="icon-security-on font28"></i>'
                            + '</span>'
                    }
                    list += '<div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">'
                    + '<img src="/assets/images/kcu.png" alt="...">'
                    + '<h5 class="card-title mt-3">'+response.list[i].appName+'</h5>'
                    + '</div>'
                    + '<hr>'
                    + '<div class="card-body text-center">';
                    if(parseInt(response.list[i].appType) === 0){
                        list += '<h5 class="card-title">Process</h5>'
                    }else if(parseInt(response.list[i].appType) === 1){
                        list += '<h5 class="card-title">Task</h5>'
                    }else if(parseInt(response.list[i].appType) === 2){
                        list += '<h5 class="card-title">Event Item</h5>'
                    }else if(parseInt(response.list[i].appType) === 3){
                        list += '<h5 class="card-title">Connector</h5>'
                    }
                    if(isEmpty(response.list[i].summary)){
                        list += '<p class="line-content">'+response.list[i].summary+'</p>';
                    }else {
                        list += '<p class="line-content">요약 설명이 존재하지 않습니다.</p>';
                    }
                    list += '<p class="date-content">Update '+formattedDate+'</p>'
                    + '</div>'
                    + '<hr>'
                    + '<div class="row pl-3 pr-3 pb-3 card-point">'
                    // + '<div class="col text-left">'
                    // + '<div class="star-rating"><span style="width:'+rating+'%;"></span></div>'
                    // + '</div>'
                    + '<div class="col text-center">'
                    + '<span class="mr-3"><i class="icon-download_log"></i>&ensp;'+response.list[i].downloadCnt+'</span>'
                    + '<span><i class="icon-Thumbsup"></i>&ensp;'+response.list[i].likeCnt+'</span>'
                    + '</div>'
                    + '</div>'
                    + '</a>'
                    + '</div>'
            }
            $("#appList").empty();
            $("#appList").append(list);
            var contentCtn = $(".card").length;
            $("#totalCount").html(contentCtn);
        }
    });
    // 전체리셋버튼 클릭시 이벤트
    $('#chkReset').click(function(){
        $("input[name=component]").prop('checked', false);
        $("input[name=bussiness]").prop('checked', false);
        $("input[name=application]").prop('checked', false);
        arraySaved();
    });
    // 각 요소별 리셋버튼 클릭시 이벤트
    $('#componentCencel').click(function(){
        $("input[name=component]").prop('checked', false);
        arraySaved();
    });
    // 각 요소별 리셋버튼 클릭시 이벤트
    $('#BICencel').click(function(){
        $("input[name=bussiness]").prop('checked', false);
        arraySaved();
    });
    // 각 요소별 리셋버튼 클릭시 이벤트
    $('#appCencel').click(function(){
        $("input[name=application]").prop('checked', false);
        arraySaved();
    });
    $("input[name=component],input[name=bussiness],input[name=application]").change(function(){
        arraySaved();
    });
    // 정렬 기준 selectbox 변경시 이벤트
    $("#criteria").change(function(){
        var page = 0;
        $("#page").val(page);
        $.ajax({
            url: '/market/list',
            type: 'GET',
            dataType: 'json',
            data: {
                page: $("#page").val(),
                search: $("#search").val(),
                criteria: $("#criteria").val(),
                componentArr: $("#componentArr").val(),
                bussinessArr: $("#bussinessArr").val(),
                applicationArr: $("#applicationArr").val()
            },
            success: function (response) {
                var list = "";
                for (var i = 0; i < response.list.length; i++) {
                    var rating = response.list[i].ratingAvg;
                    rating = parseInt(rating) / 5 * 100;
                    var updateDatetime = response.list[i].lastUpdate;
                    var newDate = new Date(updateDatetime);
                    var yyyy = newDate.getFullYear();
                    var mm = cfSetAddZero(newDate.getMonth()+1);
                    var dd = cfSetAddZero(newDate.getDate());
                    var formattedDate = yyyy + "-" + mm + "-" + dd;
                    list += '<div class="col-4 mb-3">'
                        + '<a href="/market/view?marketId='+response.list[i].seq+'" class="card">';
                    if(response.list[i].security != null && parseInt(response.list[i].security) !== 0) {
                        list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                            + '<i class="icon-security-on font28"></i>'
                            + '</span>'
                    }
                        list += '<div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">'
                        + '<img src="/assets/images/kcu.png" alt="...">'
                        + '<h5 class="card-title mt-3">'+response.list[i].appName+'</h5>'
                        + '</div>'
                        + '<hr>'
                        + '<div class="card-body text-center">';
                        if(parseInt(response.list[i].appType) === 0){
                            list += '<h5 class="card-title">Process</h5>'
                        }else if(parseInt(response.list[i].appType) === 1){
                            list += '<h5 class="card-title">Task</h5>'
                        }else if(parseInt(response.list[i].appType) === 2){
                            list += '<h5 class="card-title">Event Item</h5>'
                        }else if(parseInt(response.list[i].appType) === 3){
                            list += '<h5 class="card-title">Connector</h5>'
                        }
                        if(isEmpty(response.list[i].summary)){
                            list += '<p class="line-content">'+response.list[i].summary+'</p>';
                        }else {
                            list += '<p class="line-content">요약 설명이 존재하지 않습니다.</p>';
                        }
                        list += '<p class="date-content">Update '+formattedDate+'</p>'
                        + '</div>'
                        + '<hr>'
                        + '<div class="row pl-3 pr-3 pb-3 card-point">'
                        // + '<div class="col text-left">'
                        // + '<div class="star-rating"><span style="width:'+rating+'%;"></span></div>'
                        // + '</div>'
                        + '<div class="col text-center">'
                        + '<span class="mr-3"><i class="icon-download_log"></i>&ensp;'+response.list[i].downloadCnt+'</span>'
                        + '<span><i class="icon-Thumbsup"></i>&ensp;'+response.list[i].likeCnt+'</span>'
                        + '</div>'
                        + '</div>'
                        + '</a>'
                        + '</div>'
                }
                $("#appList").empty();
                $("#appList").append(list);
                var contentCtn = $(".card").length;
                $("#totalCount").html(contentCtn);
            }
        });
    });
    // 검색버튼 클릭시 이벤트
    $("#searchBtn").click(function(){
        var page = 0;
        var serch = $("#search").val();
        $("#page").val(page);
        $.ajax({
            url: '/market/list',
            type: 'GET',
            dataType: 'json',
            data: {
                page: $("#page").val(),
                search: $.trim(serch),
                criteria: $("#criteria").val(),
                componentArr: $("#componentArr").val(),
                bussinessArr: $("#bussinessArr").val(),
                applicationArr: $("#applicationArr").val()
            },
            success: function (response) {
                var list = "";
                for (var i = 0; i < response.list.length; i++) {
                    var rating = response.list[i].ratingAvg;
                    rating = rating / 5 * 100;
                    var updateDatetime = response.list[i].lastUpdate;
                    var newDate = new Date(updateDatetime);
                    var yyyy = newDate.getFullYear();
                    var mm = cfSetAddZero(newDate.getMonth()+1);
                    var dd = cfSetAddZero(newDate.getDate());
                    var formattedDate = yyyy + "-" + mm + "-" + dd;
                    list += '<div class="col-4 mb-3">'
                        + '<a href="/market/view?marketId='+response.list[i].seq+'" class="card">';
                    if(response.list[i].security != null && parseInt(response.list[i].security) !== 0) {
                        list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                            + '<i class="icon-security-on font28"></i>'
                            + '</span>'
                    }
                        list += '<div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">'
                        + '<img src="/assets/images/kcu.png" alt="...">'
                        + '<h5 class="card-title mt-3">'+response.list[i].appName+'</h5>'
                        + '</div>'
                        + '<hr>'
                        + '<div class="card-body text-center">';
                        if(parseInt(response.list[i].appType) === 0){
                            list += '<h5 class="card-title">Process</h5>'
                        }else if(parseInt(response.list[i].appType) === 1){
                            list += '<h5 class="card-title">Task</h5>'
                        }else if(parseInt(response.list[i].appType) === 2){
                            list += '<h5 class="card-title">Event Item</h5>'
                        }else if(parseInt(response.list[i].appType) === 3){
                            list += '<h5 class="card-title">Connector</h5>'
                        }
                        if(isEmpty(response.list[i].summary)){
                            list += '<p class="line-content">'+response.list[i].summary+'</p>';
                        }else {
                            list += '<p class="line-content">요약 설명이 존재하지 않습니다.</p>';
                        }
                        list += '<p class="date-content">Update '+formattedDate+'</p>'
                        + '</div>'
                        + '<hr>'
                        + '<div class="row pl-3 pr-3 pb-3 card-point">'
                        // + '<div class="col text-left">'
                        // + '<div class="star-rating"><span style="width:'+rating+'%;"></span></div>'
                        // + '</div>'
                        + '<div class="col text-center">'
                        + '<span class="mr-3"><i class="icon-download_log"></i>&ensp;'+response.list[i].downloadCnt+'</span>'
                        + '<span><i class="icon-Thumbsup"></i>&ensp;'+response.list[i].likeCnt+'</span>'
                        + '</div>'
                        + '</div>'
                        + '</a>'
                        + '</div>'
                }
                $("#appList").empty();
                $("#appList").append(list);
                var contentCtn = $(".card").length;
                $("#totalCount").html(contentCtn);
            }
        });
    });
    //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
    $(window).scroll(function(){
        var doc_h = $(document).height();
        var win_h = $(window).height();
        var win_s = $(window).scrollTop();
        win_s = Math.ceil(win_s);
        if(win_s >= doc_h - win_h) {
            var page = $("#page").val();
            page = parseInt(page) + 1;
            // 해당 페이지에 들어갈 수 있는 컨텐츠 수
            var content = page * 12;
            // 실제 앱 리스트 갯수
            var contentCtn = $(".card").length;
            if(content == contentCtn){
                var page = parseInt($("#page").val());
                page++;
                $("#page").val(page);
                $.ajax({
                    url: '/market/list',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        page: $("#page").val(),
                        search: $("#search").val(),
                        criteria: $("#criteria").val(),
                        componentArr: $("#componentArr").val(),
                        bussinessArr: $("#bussinessArr").val(),
                        applicationArr: $("#applicationArr").val()
                    },
                    success: function (response) {
                        var list = "";
                        for (var i = 0; i < response.list.length; i++) {
                            var rating = response.list[i].ratingAvg;
                            rating = rating / 5 * 100;
                            var updateDatetime = response.list[i].lastUpdate;
                            var newDate = new Date(updateDatetime);
                            var yyyy = newDate.getFullYear();
                            var mm = cfSetAddZero(newDate.getMonth()+1);
                            var dd = cfSetAddZero(newDate.getDate());
                            var formattedDate = yyyy + "-" + mm + "-" + dd;
                            list += '<div class="col-4 mb-3">'
                                + '<a href="/market/view?marketId='+response.list[i].seq+'" class="card">';
                            if(response.list[i].security != null && parseInt(response.list[i].security) !== 0) {
                                list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                                    + '<i class="icon-security-on font28"></i>'
                                    + '</span>'
                            }
                                list += '<div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">'
                                + '<img src="/assets/images/kcu.png" alt="...">'
                                + '<h5 class="card-title mt-3">'+response.list[i].appName+'</h5>'
                                + '</div>'
                                + '<hr>'
                                + '<div class="card-body text-center">';
                                if(parseInt(response.list[i].appType) === 0){
                                    list += '<h5 class="card-title">Process</h5>'
                                }else if(parseInt(response.list[i].appType) === 1){
                                    list += '<h5 class="card-title">Task</h5>'
                                }else if(parseInt(response.list[i].appType) === 2){
                                    list += '<h5 class="card-title">Event Item</h5>'
                                }else if(parseInt(response.list[i].appType) === 3){
                                    list += '<h5 class="card-title">Connector</h5>'
                                }
                                if(isEmpty(response.list[i].summary)){
                                    list += '<p class="line-content">'+response.list[i].summary+'</p>';
                                }else {
                                    list += '<p class="line-content">요약 설명이 존재하지 않습니다.</p>';
                                }
                                list += '<p class="date-content">Update '+formattedDate+'</p>'
                                + '</div>'
                                + '<hr>'
                                + '<div class="row pl-3 pr-3 pb-3 card-point">'
                                // + '<div class="col text-left">'
                                // + '<div class="star-rating"><span style="width:'+rating+'%;"></span></div>'
                                // + '</div>'
                                + '<div class="col text-center">'
                                + '<span class="mr-3"><i class="icon-download_log"></i>&ensp;'+response.list[i].downloadCnt+'</span>'
                                + '<span><i class="icon-Thumbsup"></i>&ensp;'+response.list[i].likeCnt+'</span>'
                                + '</div>'
                                + '</div>'
                                + '</a>'
                                + '</div>'
                        }
                        $("#appList").append(list);
                        var contentCtn = $(".card").length;
                        $("#totalCount").html(contentCtn);
                    }
                });
            }else if(content > contentCtn) {
                var page = parseInt($("#page").val());
                $("#page").val(page);
                $.ajax({
                    url: '/market/list',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        page: $("#page").val(),
                        search: $("#search").val(),
                        criteria: $("#criteria").val(),
                        componentArr: $("#componentArr").val(),
                        bussinessArr: $("#bussinessArr").val(),
                        applicationArr: $("#applicationArr").val(),
                        contentCtn: contentCtn
                    },
                    success: function (response) {
                        var list = "";
                        for (var i = 0; i < response.list.length; i++) {
                            var rating = response.list[i].ratingAvg;
                            rating = rating / 5 * 100;
                            var updateDatetime = response.list[i].lastUpdate;
                            var newDate = new Date(updateDatetime);
                            var yyyy = newDate.getFullYear();
                            var mm = cfSetAddZero(newDate.getMonth()+1);
                            var dd = cfSetAddZero(newDate.getDate());
                            var formattedDate = yyyy + "-" + mm + "-" + dd;
                            list += '<div class="col-4 mb-3">'
                                + '<a href="/market/view?marketId='+response.list[i].seq+'" class="card">';
                            if(response.list[i].security != null && parseInt(response.list[i].security) !== 0) {
                                list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                                    + '<i class="icon-security-on font28"></i>'
                                    + '</span>'
                            }
                            list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                                + '<i class="icon-security-on font28"></i>'
                                + '</span>'
                                + '<div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">'
                                + '<img src="/assets/images/kcu.png" alt="...">'
                                + '<h5 class="card-title mt-3">'+response.list[i].appName+'</h5>'
                                + '</div>'
                                + '<hr>'
                                + '<div class="card-body text-center">'
                                if(parseInt(response.list[i].appType) === 0){
                                    list += '<h5 class="card-title">Process</h5>'
                                }else if(parseInt(response.list[i].appType) === 1){
                                    list += '<h5 class="card-title">Task</h5>'
                                }else if(parseInt(response.list[i].appType) === 2){
                                    list += '<h5 class="card-title">Event Item</h5>'
                                }else if(parseInt(response.list[i].appType) === 3){
                                    list += '<h5 class="card-title">Connector</h5>'
                                }
                                if(isEmpty(response.list[i].summary)){
                                    list += '<p class="line-content">'+response.list[i].summary+'</p>';
                                }else {
                                    list += '<p class="line-content">요약 설명이 존재하지 않습니다.</p>';
                                }
                                list += '<p class="date-content">Update '+formattedDate+'</p>'
                                + '</div>'
                                + '<hr>'
                                + '<div class="row pl-3 pr-3 pb-3 card-point">'
                                // + '<div class="col text-left">'
                                // + '<div class="star-rating"><span style="width:'+rating+'%;"></span></div>'
                                // + '</div>'
                                + '<div class="col text-center">'
                                + '<span class="mr-3"><i class="icon-download_log"></i>&ensp;'+response.list[i].downloadCnt+'</span>'
                                + '<span><i class="icon-Thumbsup"></i>&ensp;'+response.list[i].likeCnt+'</span>'
                                + '</div>'
                                + '</div>'
                                + '</a>'
                                + '</div>'
                        }
                        $("#appList").append(list);
                        var contentCtn = $(".card").length;
                        $("#totalCount").html(contentCtn);
                    }
                });
            }
        }
    });
});
function cfSetAddZero(target) {
    var num = parseInt(target);
    if(num < 10) {
        num = "0" + num;
    }
    return num.toString();
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

function arraySaved () {
    var page = 0;
    $("#page").val(page);
    var componentArr = [];
    $("input[name=component]").each(function(){
        if($(this).is(":checked")){
            componentArr.push($(this).val());
        }

    });
    var bussinessArr = [];
    $("input[name=bussiness]").each(function(){
        if($(this).is(":checked")){
            bussinessArr.push($(this).val());
        }
    });
    var applicationArr = [];
    $("input[name=application]").each(function(){
        if($(this).is(":checked")){
            bussinessArr.push($(this).val());
        }
    });
    $("#componentArr").val(componentArr.join("|"));
    $("#bussinessArr").val(bussinessArr.join("|"));
    $("#applicationArr").val(applicationArr.join("|"));

    $.ajax({
        url: '/market/list',
        type: 'GET',
        dataType: 'json',
        data: {
            page: $("#page").val(),
            search: $("#search").val(),
            criteria: $("#criteria").val(),
            componentArr: $("#componentArr").val(),
            bussinessArr: $("#bussinessArr").val(),
            applicationArr: $("#applicationArr").val()
        },
        success: function (response) {
            var list = "";
            for (var i = 0; i < response.list.length; i++) {
                var rating = response.list[i].ratingAvg;
                rating = rating / 5 * 100;
                var updateDatetime = response.list[i].lastUpdate;
                var newDate = new Date(updateDatetime);
                var yyyy = newDate.getFullYear();
                var mm = cfSetAddZero(newDate.getMonth()+1);
                var dd = cfSetAddZero(newDate.getDate());
                var formattedDate = yyyy + "-" + mm + "-" + dd;
                list += '<div class="col-4 mb-3">'
                    + '<a href="/market/view?marketId='+response.list[i].seq+'" class="card">';
                if(response.list[i].security == 1) {
                    list += '<span class="certification" data-toggle="tooltip" data-placement="top" title="aworks Certification">'
                        + '<i class="icon-security-on font28"></i>'
                        + '</span>'
                }
                    list += '<div class="category-img d-flex flex-column justify-content-center align-items-center pt-3">'
                    + '<img src="/assets/images/kcu.png" alt="...">'
                    + '<h5 class="card-title mt-3">'+response.list[i].appName+'</h5>'
                    + '</div>'
                    + '<hr>'
                    + '<div class="card-body text-center">'
                    if(parseInt(response.list[i].appType) === 0){
                        list += '<h5 class="card-title">Process</h5>'
                    }else if(parseInt(response.list[i].appType) === 1){
                        list += '<h5 class="card-title">Task</h5>'
                    }else if(parseInt(response.list[i].appType) === 2){
                        list += '<h5 class="card-title">Event Item</h5>'
                    }else if(parseInt(response.list[i].appType) === 3){
                        list += '<h5 class="card-title">Connector</h5>'
                    }
                    if(isEmpty(response.list[i].summary)){
                        list += '<p class="line-content">'+response.list[i].summary+'</p>';
                    }else {
                        list += '<p class="line-content">요약 설명이 존재하지 않습니다.</p>';
                    }
                    list += '<p class="date-content">Update '+formattedDate+'</p>'
                    + '</div>'
                    + '<hr>'
                    + '<div class="row pl-3 pr-3 pb-3 card-point">'
                    // + '<div class="col text-left">'
                    // + '<div class="star-rating"><span style="width:'+rating+'%;"></span></div>'
                    // + '</div>'
                    + '<div class="col text-center">'
                    + '<span class="mr-3"><i class="icon-download_log"></i>&ensp;'+response.list[i].downloadCnt+'</span>'
                    + '<span><i class="icon-Thumbsup"></i>&ensp;'+response.list[i].likeCnt+'</span>'
                    + '</div>'
                    + '</div>'
                    + '</a>'
                    + '</div>'
            }
            $("#appList").empty();
            $("#appList").append(list);
            var contentCtn = $(".card").length;
            $("#totalCount").html(contentCtn);
        }
    });
}
