$(function(){
    getList(0,true);
    $("body").on("click",".newWindowView", function () {
        var seq = $(this).data("seq");
        window.open('/repository/repositoryView?seq='+seq, '_blank');
    });

    $("body").on("click",".urlCopy", function () {
        console.log(1111);
        var seq = $(this).data("seq");
        copyToClipboard(location.host + '/repository/repositoryView?seq='+seq);
        alert("URL이 복사되었습니다");
    });

    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        if(deleteArray.length > 0) {
            fnRecommDelete(deleteArray);
        } else {
            alert("삭제 할 추천아이템을 선택해야 합니다.");
        }
    });

    $("body").on("click",".recommDelete", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        fnRecommDelete(deleteArray);
    });

    $('#recommModal').on('hidden.bs.modal', function (e) {
        $('#recommSearchList').empty();
        $('#page-selection').empty();
    });

    $('#recommModal').on('shown.bs.modal', function (event) {
        recommSearch(0, true);
    });

    // checkbox all check
    $("#recommAllChk").click(function(){
        if($(this).is(":checked")){
            $(".recommChk").prop("checked",true);
        }else{
            $(".recommChk").prop("checked",false);
        }
    });

    // checkbox 예외처리
    $(".recommChk").on("change", function(){
        var class_length = $(".recommChk").length;
        var checked_length = 0;
        $(".recommChk").each(function(){
            if($(this).is(":checked")) checked_length++;
        });

        if($(this).is(":checked")) {
            if(class_length <= checked_length) $("#recommAllChk").prop("checked", true);
        } else {
            $("#recommAllChk").prop("checked", false);
        }
    });

    $("#btnSave").on("click", function () {
        var chkArray = [];
        var checked_length = 0;
        $(".recommChk").each(function(){
            if($(this).is(":checked")) {
                chkArray.push($(this).val());
                checked_length++;
            }
        });
        if(checked_length <= 0) {
            alert("콘텐츠를 1개 이상 선택해야 합니다.");
            return false;
        } else {
            if(confirm("선택한 콘텐츠를 추천 아이템으로 등록하시겠습니까?")) {
                var datas = {
                    chkArray : chkArray.join("|")
                };
                $.ajax({
                    url: "/repository/recommInsert",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        if(response.result){
                            alert("추천 아이템으로 등록되었습니다.");
                            location.reload();
                        }else{
                            alert("추천 아이템 등록 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                        }
                    }
                });
            }
        }
    });


    $("#recommSearchForm").submit(function(){
        if($("#datestart").val() != "" && $("#dateend").val() == ""){
            alert("검색 날짜를 입력하시기 바랍니다.");
            return false;
        }
        if($("#datestart").val() == "" && $("#dateend").val() != ""){
            alert("검색 날짜를 입력하시기 바랍니다.");
            return false;
        }
        if($("#datestart").val() != "" && $("#dateend").val() != ""){
            if($("#datestart").val() > $("#dateend").val()){
                alert("검색 날짜를 다시 설정하시기 바랍니다.");
                return false;
            }

        }
        $('#page-selection').empty();
        recommSearch(0, true);
        return false;
    })

    $("body").on("click", ".sorting", function(){
        // var fullStringClassName = $(this).attr("class");
        // var className = fullStringClassName.substring(45);
        var sortName = $(this).data("sort");
        var orderby = $(this).data("orderby");
        $(".sorting").children("i").removeClass("icon-caret-down").removeClass("icon-caret-up").addClass("icon-sort-arrows-couple-pointing-up-and-down");
        $(".sorting").each(function(){
            $(this).data("orderby","1");
        })
        if(orderby == "1"){
            $(this).data("orderby","0");
        }else{
            $(this).data("orderby","1");
        }
        $("#sort").val(sortName);
        $("#order").val(orderby);

        if($(this).data("orderby") == "0"){
            $(this).children("i").removeClass("icon-sort-arrows-couple-pointing-up-and-down").removeClass("icon-caret-up").addClass("icon-caret-down");
        }else{
            $(this).children("i").removeClass("icon-sort-arrows-couple-pointing-up-and-down").removeClass("icon-caret-down").addClass("icon-caret-up");
        }
        getList(0,true);
    });

    $("body").on("click", ".sorting-m", function(){
        console.log(11111);
        // var fullStringClassName = $(this).attr("class");
        // var className = fullStringClassName.substring(45);
        var sortName = $(this).data("sort");
        var orderby = $(this).data("orderby");
        $(".sorting-m").children("i").removeClass("icon-caret-down").removeClass("icon-caret-up").addClass("icon-sort-arrows-couple-pointing-up-and-down");
        $(".sorting-m").each(function(){
            $(this).data("orderby","1");
        })
        if(orderby == "1"){
            $(this).data("orderby","0");
        }else{
            $(this).data("orderby","1");
        }
        $("#sort-m").val(sortName);
        $("#order-m").val(orderby);

        if($(this).data("orderby") == "0"){
            $(this).children("i").removeClass("icon-sort-arrows-couple-pointing-up-and-down").removeClass("icon-caret-up").addClass("icon-caret-down");
        }else{
            $(this).children("i").removeClass("icon-sort-arrows-couple-pointing-up-and-down").removeClass("icon-caret-down").addClass("icon-caret-up");
        }
        recommSearch(0,true);
    });
});

function copyToClipboard(val) {
    console.log(val);
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
    console.log(3333);
}

function fnRecommDelete(deleteArray) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };
    if(confirm("선택한 추천 아이템을 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/repository/recommDelete",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result){
                    alert("삭제 되었습니다.");
                    // location.reload();
                    getList(0,true);
                }else{
                    alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                }
            }
        });
    }
}

function repositoryViewDetail(seq) {
    document.location.href = '/repository/repositoryView?seq='+seq;
}

// 등록된 콘텐츠 조회
function recommSearch(num, check) {
    var html = '';

    var datas = {
        row : 10 ,
        sort : $("#sort-m").val() ,
        page : num ,
        order : $("#order-m").val() ,
        startDate : $("#datestart").val() ,
        endDate : $("#dateend").val() ,
        searchType : $("#searchType").val() ,
        searchWord : $("#searchWord").val()
    };

    $.ajax({
        url: "/repository/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        ascyc: false
    }).done(function (response) {
        console.log(response);
        $("#total-m").val(response.no);
        var rsList = response.list;
        if(rsList.length > 0) {
            for(var i=0;i<rsList.length;i++) {
                var no = $("#total-m").val()-((num-1)*10+i);
                // 타입
                var appType = rsList[i].appType;
                if(appType == 0) appType = 'Process';
                else if(appType == 1) appType = 'Task';
                else if(appType == 2) appType = 'Event Item';
                else appType = 'Connector';

                // 생성일
                var createDatetime = getFormatDate(rsList[i].createDatetime);

                // 마지막 업데이트일
                var lastUpdate = rsList[i].lastUpdate;
                if(lastUpdate != null && lastUpdate != "") lastUpdate = getFormatDate(lastUpdate);
                else lastUpdate = '-';

                html +=
                '<tr>\n' +
                    '<td scope="row">\n' +
                        '<div class="form-check">\n' +
                            '<input class="form-check-input position-static recommChk" name="seqs" type="checkbox" value="'+rsList[i].seq+'" aria-label="...">\n' +
                        '</div>\n' +
                    '</td>\n' +
                    '<td>'+no+'</td>\n' +
                    '<td>'+appType+'</td>\n' +
                    '<td>'+rsList[i].appName+'</td>\n' +
                    '<td>'+createDatetime+'</td>\n' +
                    '<td>'+lastUpdate+'</td>\n' +
                    '<td>'+rsList[i].downloadCnt+'</td>\n' +
                    '<td>'+rsList[i].qnaCnt+'</td>\n' +
                    '<td>'+rsList[i].review+'</td>\n' +
                    // '<td>\n' +
                    //     '<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">\n' +
                    //         '<i class="icon-newpage"></i>\n' +
                    //     '</button>\n' +
                    //     '<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="URL 복사">\n' +
                    //         '<i class="icon-urlcopy"></i>\n' +
                    //     '</button>\n' +
                    // '</td>\n' +
                '</tr>';
            }
        } else {
            html +=
            '<tr>\n' +
                '<td colspan="10" align="center">등록된 콘텐츠가 없습니다.</td>\n' +
            '</tr>';
        }

        $("#recommSearchList").empty();
        $("#recommSearchList").html(html);

        if(check) {
            console.log(check);
            $('#page-selection').bootpag({
                total: Math.ceil(response.total/parseInt($("#row").val())),
                page : 1,
                maxVisible : 5,
                firstLastUse: true,
                first: '<<',
                last: '>>',
                next: '>',
                prev: '<'
            }).on("page", function(event, num){
                recommSearch(num, false);
            });
        }
    });
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/repository/ajax_recomm",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            var html = "";
            if(response.list.length > 0) {
                for(var i =0 ; i< response.list.length;i++){
                    var no = response.total-(num*$("#row").val()+i);
                    var lastUpdate = response.list[i].lastUpdate;
                    if(lastUpdate == null || lastUpdate == "") lastUpdate = "-";
                    else lastUpdate = getFormatDate(lastUpdate);

                    html += '<tr>\
                           <td scope="row">\
                                <div class="form-check">\
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td style="cursor: pointer">'+no+'</td>\
                            <td style="cursor: pointer">';
                    if(response.list[i].appType == 0){
                        html += 'Process';
                    }else if(response.list[i].appType == 1){
                        html += 'Task';
                    }else if(response.list[i].appType == 2){
                        html += 'Event Item';
                    }else{
                        html += 'Connector';
                    }
                    html += '</td>\
                            <td style="cursor: pointer">'+response.list[i].appName+'</td>\
                            <td style="cursor: pointer">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td style="cursor: pointer">'+lastUpdate+'</td>\
                            <td style="cursor: pointer">'+response.list[i].downloadCnt+'</td>\
                            <td style="cursor: pointer">'+response.list[i].qnaCnt+'</td>\
                            <td style="cursor: pointer">'+response.list[i].review+'</td>\
                            <td>\
                                <div class="btn-group btn-group-action">\
                                    <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">\
                                        <i class="icon-navigation-more font12"></i>\
                                    </button>\
                                    <div class="dropdown-menu">\
                                        <button type="button" class="dropdown-item newWindowView" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="dropdown-item urlCopy" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="dropdown-item recommDelete" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-trash1 mr-2"></i>삭제\
                                        </button>\
                                    </div>\
                                </div>\
                            </td>\
                        </tr>';
                }
            } else {
                html +=
                    '<tr>\
                        <td colspan="10" align="center">검색된 추천 아이템이 존재하지 않습니다.</td>\
                    </tr>';
            }
            $("#recommList").html(html);
            $("#totalCnt").html(response.total);
            if(response.total > 0) {
                if(refresh) {
                    $('#paging').bootpag({
                        total: Math.ceil(response.total/parseInt($("#row").val())),
                        page : 1,
                        maxVisible : 5,
                        firstLastUse: true,
                        first: '<<',
                        last: '>>',
                        next: '>',
                        prev: '<'
                    }).on("page", function (event, num) {
                        getList(num-1, false);

                    });
                }
            }else {
                // if(refresh) {
                //     $('#paging').bootpag({
                //         total: 1,
                //         page : 1,
                //         maxVisible : 5,
                //         firstLastUse: true,
                //         first: '<<',
                //         last: '>>',
                //         next: '>',
                //         prev: '<'
                //     }).on("page", function (event, num) {
                //         getList(num-1, false);
                //
                //     });
                // }
                $("#paging").html("");
            }
        }
    });
}