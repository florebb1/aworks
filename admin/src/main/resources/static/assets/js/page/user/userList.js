$(function(){
    getList(0,true);


    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        var levelInfo = 0;
        $(".listCheck").each(function () {
            if($(this).is(":checked")) {
                // if ($(this).data("level") == "2") {
                //     $(this).prop("checked", false);
                //     levelInfo++;
                // } else {
                    deleteArray.push($(this).val());
                // }
            }

        });
        var delType = 0;
        // if(levelInfo > 0){
        //     alert("계약 담당자로 등록 된 사용자는 삭제할 수 없습니다");
        // }
        fnUserDelete(deleteArray, delType);
    });

    $("body").on("click",".userDelete", function () {
        if($(this).data("level") == "2"){
            alert("계약담당자로 등록 된 사용자이므로 삭제할 수 없습니다.");
            return false;
        }
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        var delType = 1;
        fnUserDelete(deleteArray, delType);
    });


    $('#userModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        $.ajax({
            url: "/user/userModalView?seq="+seq,
            type: 'GET'
            //ascyc: false
        }).done(function (response) {
            $("#user-modal-view").html(response);
        });
    });

    $('#userHistoryModal').on('hidden.bs.modal', function (e) {
        $('#myTab a[href="#review"]').tab('show');

        $("#reviewList").empty();
        $('#review-page-selection').empty();

        $("#qnaList").empty();
        $('#qna-page-selection').empty();

        $("#downloadList").empty();
        $('#download-page-selection').empty();
    });

    $('#userHistoryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        console.log(seq);
        downloadList(1, seq, true);
    });

    // 탭 이동 이벤트
    $('#myTab a').on('click', function (e) {
        e.preventDefault();
        $(this).tab('show');
        var userSeq = $("#userSeq").val();
        if(e.target.id == 'review-tab') {
            console.log('review');
            console.log('userSeq : '+userSeq);
            reviewList(1, userSeq, true);
        } else if(e.target.id == 'qna-tab') {
            console.log('qna');
            console.log('userSeq : '+userSeq);
            qnaList(1, userSeq, true);
        } else if(e.target.id == 'download-tab') {
            console.log('download');
            console.log('userSeq : '+userSeq);
            downloadList(1, userSeq, true);
        }
    });



});

// 리뷰 히스토리 호출
function reviewList(num, seq, check) {
    var html = '';
    var datas = {
        seq : seq,
        rvRow : 10 ,
        rvSort : $("#rvSort").val() ,
        rvPage : num ,
        rvOrder : 0
    };

    $.ajax({
        url: "/user/reviewList",
        type: 'POST',
        dataType: 'JSON',
        data: datas,
        ascyc: false
    }).done(function (response) {
        console.log(response);
        $("#rvTotal").val(response.no);
        $("#userSeq").val(response.userSeq);
        var rsList = response.resultsList;
        if(rsList.length > 0) {
            for(var i=0;i<rsList.length;i++) {
                // 등록일
                var no = $("#rvTotal").val()-((num-1)*10+i);
                var createDatetime = getFormatDate(rsList[i].createDatetime);
                html +=
                    '<tr>\n' +
                    '<td>'+no+'</td>\n' +
                    '<td>'+rsList[i].repositorySeq+'</td>\n' +
                    '<td>'+rsList[i].appName+'</td>\n' +
                    '<td>'+createDatetime+'</td>\n' +
                    '<td>'+rsList[i].content+'</td>\n' +
                    '<td>\n' +
                    '<button type="button" class="btn btn-info btn-sm rvModify" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="수정">\n' +
                    '<i class="icon-modify"></i>\n' +
                    '</button>'+
                    '<button type="button" class="btn btn-danger btn-sm rvDelete" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="삭제">\n' +
                    '<i class="icon-delete"></i>\n' +
                    '</button>' +
                    '</td>\n' +
                    '</tr>';
            }
        } else {
            html +=
                '<tr>\n' +
                '<td colspan="6" align="center">등록된 리뷰 내역이 없습니다.</td>\n' +
                '</tr>';
        }

        $("#reviewList").empty();
        $("#reviewList").html(html);

        if(check) {
            var totalPage = $("#rvTotal").val();
            $('#review-page-selection').bootpag({
                total: totalPage
            }).on("page", function(event, num){
                reviewList(num, seq, false);
            });
        }
    });
}

// 질문 히스토리 호출
function qnaList(num, seq, check) {
    var html = '';
    var datas = {
        seq : seq,
        qnaRow : 10 ,
        qnaSort : $("#qnaSort").val() ,
        qnaPage : num ,
        qnaOrder : 0
    };

    $.ajax({
        url: "/user/qnaList",
        type: 'POST',
        dataType: 'JSON',
        data: datas,
        ascyc: false
    }).done(function (response) {
        console.log(response);
        $("#qnaTotal").val(response.no);
        $("#userSeq").val(response.userSeq);
        var rsList = response.resultsList;
        if(rsList.length > 0) {
            for(var i=0;i<rsList.length;i++) {
                // 등록일
                var no = $("#qnaTotal").val()-((num-1)*10+i);
                var createDatetime = getFormatDate(rsList[i].createDatetime);
                html +=
                    '<tr>\n' +
                    '<td>'+no+'</td>\n' +
                    '<td>'+rsList[i].repositorySeq+'</td>\n' +
                    '<td>'+rsList[i].appName+'</td>\n' +
                    '<td>'+createDatetime+'</td>\n' +
                    '<td>'+rsList[i].title+'</td>\n' +
                    '<td>'+rsList[i].content+'</td>\n' +
                    '<td>\n' +
                    '<button type="button" class="btn btn-info btn-sm qnaModify" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="수정">\n' +
                    '<i class="icon-modify"></i>\n' +
                    '</button>'+
                    '<button type="button" class="btn btn-danger btn-sm qnaDelete" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="삭제">\n' +
                    '<i class="icon-delete"></i>\n' +
                    '</button>' +
                    '</td>\n' +
                    '</tr>';
            }
        } else {
            html +=
                '<tr>\n' +
                '<td colspan="7" align="center">등록된 질문 내역이 없습니다.</td>\n' +
                '</tr>';
        }

        $("#qnaList").empty();
        $("#qnaList").html(html);

        if(check) {
            var totalPage = $("#qnaTotal").val();
            $('#qna-page-selection').bootpag({
                total: totalPage
            }).on("page", function(event, num){
                qnaList(num, seq, false);
            });
        }
    });
}

// 질문 히스토리 호출
function downloadList(num, seq, check) {
    var html = '';
    var datas = {
        seq : seq,
        dlRow : 10 ,
        dlSort : $("#dlSort").val() ,
        dlPage : num ,
        dlOrder : 0
    };

    $.ajax({
        url: "/user/downloadList",
        type: 'POST',
        dataType: 'JSON',
        data: datas,
        ascyc: false
    }).done(function (response) {
        console.log(response);
        $("#dlTotal").val(response.no);
        $("#userSeq").val(response.userSeq);
        var rsList = response.resultsList;
        if(rsList.length > 0) {
            for(var i=0;i<rsList.length;i++) {
                // 등록일
                var no = $("#dlTotal").val()-((num-1)*10+i);
                var createDatetime = getFormatDate(rsList[i].createDatetime);
                html +=
                    '<tr>\n' +
                    '<td>'+no+'</td>\n' +
                    '<td>'+rsList[i].repositorySeq+'</td>\n' +
                    '<td>'+rsList[i].appName+'</td>\n' +
                    '<td>'+createDatetime+'</td>\n' +
                    '<td>\n' +
                    '<button type="button" class="btn btn-info btn-sm dlModify" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="수정">\n' +
                    '<i class="icon-modify"></i>\n' +
                    '</button>'+
                    '<button type="button" class="btn btn-danger btn-sm dlDelete" data-seq="'+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="삭제">\n' +
                    '<i class="icon-delete"></i>\n' +
                    '</button>' +
                    '</td>\n' +
                    '</tr>';
            }
        } else {
            html +=
                '<tr>\n' +
                '<td colspan="5" align="center">등록된 다운로드 내역이 없습니다.</td>\n' +
                '</tr>';
        }

        $("#downloadList").empty();
        $("#downloadList").html(html);

        if(check) {
            var totalPage = $("#dlTotal").val();
            $('#download-page-selection').bootpag({
                total: totalPage
            }).on("page", function(event, num){
                downloadList(num, seq, false);
            });
        }
    });
}

// url 복사
function copyToClipboard(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
}

// 사용자 삭제 처리
function fnUserDelete(deleteArray, delType) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };

    if(delType == 0) {
        if(deleteArray.length <= 0) {
            alert("삭제 대상을 1개 이상 선택해야 합니다.");
            return false;
        }
    }

    if(confirm("선택한 사용자를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/user/userDelete",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {

                if(response.result){
                    if(delType == 0) {
                        if (response.data.delN == 0) {
                            alert("총 " + deleteArray.length + "개 중 " + response.data.delY + "개 삭제 되었습니다.");
                        } else {
                            alert("총 " + deleteArray.length + "개 중 " + response.data.delY + "개 삭제 되었습니다." + "\n" + response.data.delN + "개의 계약사용자는 삭제불가능합니다.");
                        }
                    }else{
                        alert("삭제 되었습니다.");
                    }
                    // location.reload();
                    getList(0,true);
                }else{
                    alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                }
            }
        });
    }
}

// 사용자 상세 호출
function userViewDetail(seq) {
    document.location.href = '/user/userView?seq='+seq;
}

// 사용자 리스트 호출
function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/user/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            var html = "";
            for(var i =0 ; i< response.list.length;i++){
                var no = response.total-(num*$("#row").val()+i);
                var name = response.list[i].name;
                if(name == null || name == "") name = "-";
                var phone = response.list[i].phone;
                if(phone == null || phone == "") phone = "-";
                var comName = response.list[i].comName;
                if(comName == null || comName == "") comName = "-";
                var position = response.list[i].position;
                if(position == null || position == "") position = "-";
                var level = response.list[i].level;
                if(level == 2) level = "Contract Admin User";
                else level = "User";
                html += '<tr>\
                            <td scope="row">\
                                <div class="form-check">\
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" data-level="'+response.list[i].level+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+no+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+response.list[i].loginId+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+name+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+phone+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+comName+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+position+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+level+'</td>\
                            <td onclick="userViewDetail('+response.list[i].seq+')">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/user/userView?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/user/userView?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#userHistoryModal" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-user-solid-circle mr-2"></i>사용자 히스토리\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#userModal" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item userDelete" data-seq="'+response.list[i].seq+'" data-level="'+response.list[i].level+'">\
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
                html += '<tr><td colspan="10" align=center>등록된 회원 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#userBodyList").html(html);
            $("#totalCnt").html(response.total);
            console.log(Math.ceil(response.total/parseInt($("#row").val())));
            if(response.total > 0) {
                if(refresh) {
                    $('#paging').bootpag({
                        total: Math.ceil(response.total/parseInt($("#row").val())),
                        page : 1,
                        maxVisible : 5,
                        firstLastUse: true,
                        leaps: true,
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