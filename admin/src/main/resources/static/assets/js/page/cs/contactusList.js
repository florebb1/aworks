$(function(){
    getList(0,true);


    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        var delType = 0;
        fnContactusDelete(deleteArray, delType);
    });

    $("body").on("click",".contactusDelete", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        var delType = 1;
        fnContactusDelete(deleteArray, delType);
    });



    $('#contactusModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        $.ajax({
            url: "/cs/contactusModalView?seq="+seq,
            type: 'GET'
            //ascyc: false
        }).done(function (response) {
            $("#contactus-modal-view").html(response);
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

function fnContactusDelete(deleteArray, delType) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };
    if(delType == 0) {
        if(deleteArray.length <= 0) {
            alert("삭제 대상을 1개 이상 선택해야 합니다.");
            return false;
        }
    }
    if(confirm("선택한 제휴문의을 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/cs/contactusDelete",
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

function contactusViewDetail(seq) {
    document.location.href = '/cs/contactusView?seq='+seq;
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/cs/ajax_contactus",
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
                            <td onclick="contactusViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+no+'</td>\
                            <td onclick="contactusViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+response.list[i].name+'</td>\
                            <td onclick="contactusViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+response.list[i].email+'</td>\
                            <td onclick="contactusViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+response.list[i].comName+'</td>\
                            <td onclick="contactusViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+response.list[i].comPhone+'</td>\
                            <td onclick="contactusViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/cs/contactusView?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/cs/contactusView?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item contactusDelete" data-seq="'+response.list[i].seq+'">\
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
                html += '<tr><td colspan="7" align=center>등록된 제휴문의 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#contactusList").html(html);
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