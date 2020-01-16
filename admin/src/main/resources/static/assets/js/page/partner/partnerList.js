$(function(){
    getList(0,true);


    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });

        fnPartnerDelete(deleteArray);
    });

    $("body").on("click",".partnerDelete", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        fnPartnerDelete(deleteArray);
    });


    $('#partnerModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        console.log(seq);
        $.ajax({
            url: "/partner/partnerModalView?seq="+seq,
            type: 'GET'
            //ascyc: false
        }).done(function (response) {
            $("#partner-modal-view").html(response);
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

function fnPartnerDelete(deleteArray) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };

    if(confirm("선택한 파트너를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/partner/partnerDelete",
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

function partnerViewDetail(seq) {
    document.location.href = '/partner/partnerView?seq='+seq;
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/partner/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            var html = "";
            if(response.list.length > 0) {
                for(var i =0 ; i< response.list.length;i++){
                    var no = response.total-(num*$("#row").val()+i);
                    var tel = response.list[i].tel;
                    if(tel == null || tel == "") tel = "-";
                    var address = response.list[i].address;
                    if(address == null || address == "") address = "-";
                    var businessNumber = response.list[i].businessNumber;
                    if(businessNumber == null || businessNumber == "") businessNumber = "-";
                    html += '<tr>\
                        <td scope="row">\
                            <div class="form-check">\
                                <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                            </div>\
                            </td>\
                            <td onclick="partnerViewDetail('+response.list[i].seq+')">'+no+'</td>\
                            <td onclick="partnerViewDetail('+response.list[i].seq+')">'+response.list[i].name+'</td>\
                            <td onclick="partnerViewDetail('+response.list[i].seq+')">'+tel+'</td>\
                            <td onclick="partnerViewDetail('+response.list[i].seq+')">'+address+'</td>\
                            <td onclick="partnerViewDetail('+response.list[i].seq+')">'+businessNumber+'</td>\
                            <td onclick="partnerViewDetail('+response.list[i].seq+')">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/partner/partnerView?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/partner/partnerView?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#partnerModal" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item partnerDelete" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-trash1 mr-2"></i>삭제\
                                        </button>\
                                    </div>\
                                </div>\
                            </td>\
                        </tr>';
                }
            } else {
                html += '<tr>\
                            <td colspan="9" align="center">등록된 파트너사가 존재하지 않습니다.</td>\
                        </tr>';
            }


            $("#partnerList").html(html);
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