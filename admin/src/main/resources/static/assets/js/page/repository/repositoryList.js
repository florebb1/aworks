$(function(){
    getList(0,true);


    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        var delType = 0;
        fnRepositoryDelete(deleteArray, delType);
    });

    $("body").on("click",".repositoryDelete", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        var delType = 1;
        fnRepositoryDelete(deleteArray, delType);
    });



    $("body").on("click",".btn-activation", function () {
        var chkArray = [];
        $(".listCheck").each(function () {
           if($(this).is(":checked")) chkArray.push($(this).val());
        });
        var chkArrayLength = chkArray.length;
        activateRepository(chkArray, chkArrayLength);
    });
    $("body").on("click",".btn-deactivation", function () {
        var chkArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkArray.push($(this).val());
        });
        var chkArrayLength = chkArray.length;
        unActivateRepository(chkArray, chkArrayLength);
    });
    $("body").on("click",".activation", function () {
        var seq = $(this).data("seq");
        var chkArray = [];
        var chkArrayLength = chkArray.length;
        activateRepository(chkArray, chkArrayLength);
    });
    $("body").on("click",".deactivation", function () {
        var seq = $(this).data("seq");
        var chkArray = [];
        chkArray.push(seq);
        var chkArrayLength = chkArray.length;
        unActivateRepository(chkArray, chkArrayLength);
    });

    $('#repositoryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        $.ajax({
            url: "/repository/repositoryModalView?seq="+seq,
            type: 'GET'
            //ascyc: false
        }).done(function (response) {
            $("#repository-modal-view").html(response);
        });
    });


});

function copyToClipboard(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
}

function fnRepositoryDelete(deleteArray, delType) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };
    if(delType == 0) {
        if(deleteArray.length <= 0) {
            alert("삭제 대상을 1개 이상 선택해야 합니다.");
            return false;
        }
    }
    if(confirm("선택한 레파지토리를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/repository/repositoryDelete",
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

function activateRepository(chkArray, chkArrayLength) {
    var datas = {
        chkArray : chkArray.join("|")
    };
    if(chkArrayLength <= 0 ) {
        alert("활성화 대상을 1개이상 선택해야 합니다.");
        return false;
    }
    if(confirm("선택한 레파지토리를 활성화 하시겠습니까?")) {
        $.ajax({
            url: "/repository/activateRepository",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result){
                    alert("활성화 되었습니다.");
                    location.reload();
                }else{
                    alert("활성화 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                }
            }
        });
    }
}

function unActivateRepository(chkArray, chkArrayLength) {
    var datas = {
        chkArray : chkArray.join("|")
    };
    if(chkArrayLength <= 0 ) {
        alert("비활성화 대상을 1개이상 선택해야 합니다.");
        return false;
    }
    if(confirm("선택한 레파지토리를 비활성화 하시겠습니까?")) {
        $.ajax({
            url: "/repository/unActivateRepository",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result){
                    alert("비활성화 되었습니다.");
                    location.reload();
                }else{
                    alert("비활성화 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                }
            }
        });
    }
}

function repositoryViewDetail(seq) {
    document.location.href = '/repository/repositoryView?seq='+seq;
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/repository/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            var html = "";
            for(var i =0 ; i< response.list.length;i++){
                var no = response.total-(num*$("#row").val()+i);
                html += '<tr>\
                           <td scope="row">\
                                <div class="form-check">\
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+no+'</td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">';

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
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+response.list[i].appName+'</td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td> \
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+(response.list[i].lastUpdate !== null ? moment(response.list[i].lastUpdate).format("YYYY-MM-DD"):"")+'</td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+response.list[i].downloadCnt+'</td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+response.list[i].qnaCnt+'</td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+response.list[i].review+'</td>\
                            <td style="cursor: pointer" onclick="repositoryViewDetail('+response.list[i].seq+')">'+(response.list[i].status == 0 ? "노출":"비노출")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/repository/repositoryView?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/repository/repositoryView?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item activation"  data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-view-show mr-2"></i>노출시키기\
                                        </button>\
                                        <button type="button" class="more-action-item deactivation" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-view-hide mr-2"></i>비노출시키기\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#repositoryModal" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item repositoryDelete" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-trash1 mr-2"></i>삭제\
                                        </button>\
                                    </div>\
                                </div>\
                            </td>\
                        </tr>';

                // <tr>
                //     <td colspan="11" align="center">사용자가 없습니다.</td>
                //     </tr>

            }
            if(html == ""){
                html += '<tr><td colspan="11" align=center>등록된 레포지토리 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#repositoryList").html(html);
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