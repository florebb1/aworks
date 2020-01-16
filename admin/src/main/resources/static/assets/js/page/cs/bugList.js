$(function(){
    getList(0,true);

    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        fnBugDelete(deleteArray);
    });

    $("body").on("click",".bugDelete", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        fnBugDelete(deleteArray);
    });



    $('#bugModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        $.ajax({
            url: "/cs/bugModalView?seq="+seq,
            type: 'GET'
            //ascyc: false
        }).done(function (response) {
            $("#bug-modal-view").html(response);
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

function fnBugDelete(deleteArray) {

    var datas = {
        deleteArray : deleteArray.join("|")
    };

    if(confirm("선택한 버그신고를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/cs/bugDelete",
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

function bugViewDetail(seq) {
    document.location.href = '/cs/bugView?seq='+seq;
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/cs/ajax_bug",
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
                            <td onclick="bugViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+no+'</td>\
                            <td onclick="bugViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+response.list[i].title+'</td>\
                            <td onclick="bugViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+response.list[i].loginId+'</td>\
                            <td onclick="bugViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td onclick="bugViewDetail('+response.list[i].seq+')" style="cursor:pointer;">'+(response.list[i].answerYn == 1 ? response.list[i].answerContent:"답변대기중")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/cs/bugView?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new  mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/cs/bugView?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#bugModal" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item bugDelete" data-seq="'+response.list[i].seq+'">\
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
                html += '<tr><td colspan="7" align=center>등록된 버그신고 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#bugList").html(html);
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