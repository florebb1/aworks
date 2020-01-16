$(function(){
    getList(0,true);


    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        var delType = 0;
        fnlicenseDelete(deleteArray, delType);
    });

    $("body").on("click",".licenseModify", function () {
        var seq = $(this).data("seq");
        document.location.href = '/license/licenseModify?seq='+seq;
    });

    $("body").on("click",".licenseDelete", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        var delType = 1;
        fnlicenseDelete(deleteArray, delType);
    });



    $("body").on("click",".statusChange",function(){
        var currentStatus = $(this).data("status");
        var seq = $(this).data("seq");
        if(currentStatus == 0){
            var msg = "사용불가로 변경하시겠습니까?";
            var status = 1;
        }else{
            var msg = "사용가능으로 변경하시겠습니까?";
            var status = 0;
        }
        if(confirm(msg)) {
            $.ajax({
                url: "/license/change_status",
                type: 'PUT',
                dataType: 'JSON',
                data: "seq=" + seq + "&status=" + status,
                success: function (response) {
                    if (response.result) {
                        alert("수정 되었습니다.");
                        // location.reload();
                        getList(0, true);
                    } else {
                        alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                    }
                }
            });
        }
    })
});

function copyToClipboard(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
}

function fnlicenseDelete(deleteArray, delType) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };
    if(delType == 0) {
        if(deleteArray.length <= 0) {
            alert("삭제 대상을 1개 이상 선택해야 합니다.");
            return false;
        }
    }
    if(confirm("선택한 라이센스를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/license/licenseDelete",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result){
                    if(delType == 0) {
                        if (response.data.deleteN == 0) {
                            alert("총 " + deleteArray.length + "선택 중 " + response.data.deleteY + "개 삭제 되었습니다.");
                        } else {
                            alert("총 " + deleteArray.length + "선택 중 " + response.data.deleteY + "개 삭제 되었습니다." + "\n" + response.data.deleteN + "개는 라이선스가 발급되어 삭제불가능합니다.");
                        }
                    }else{
                        if (response.data.deleteN == 0) {
                            alert("삭제 되었습니다.");
                        }else{
                            alert("라이선스가 사용된 건은 삭제가 불가능합니다.");
                        }
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

function licenseViewDetail(seq) {
    document.location.href = '/license/detail?seq='+seq;
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/license/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            var html = "";
            for(var i =0 ; i< response.list.length;i++){
                var no = response.total-(num*$("#row").val()+i);
                if(response.list[i].licenseType == "1"){
                    var licenseType = 'PC형';
                }else if(response.list[i].licenseType == "2"){
                    var licenseType = 'Cloud형';
                }else{
                    var licenseType = 'on-Premise형';
                }

                var startdate = moment(response.list[i].contractStart).format("YYYY-MM-DD");
                var enddate = moment(response.list[i].contractEnd).format("YYYY-MM-DD");
                var today = moment(new Date()).format("YYYY-MM-DD");

                if(enddate != "" && enddate < today){
                    var currentStatus = "종료";
                    // $("#contractStatus").val(3)
                }else if(startdate != "" && startdate > today){
                    var currentStatus = "대기";
                    // $("#contractStatus").val(1);
                }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
                    // $("#contractStatus").val(2);
                    var currentStatus = "사용";
                }else{
                    // $("#contractStatus").val(1);
                    var currentStatus = "대기";
                }
                var count1 = (response.list[i].countUnattended === null ? 0:response.list[i].countUnattended);
                var count2 = (response.list[i].countAttended === null ? 0:response.list[i].countAttended);
                var count3 = (response.list[i].countStudio === null ? 0:response.list[i].countStudio);
                var count4 = (response.list[i].countWorkcenter === null ? 0:response.list[i].countWorkcenter);

                var left1 = count1 - (response.list[i].countUnAttendedUse === null ? 0:response.list[i].countUnAttendedUse);
                var left2 = count2 - (response.list[i].countAttendedUse === null ? 0:response.list[i].countAttendedUse);
                var left3 = count3 - (response.list[i].countStudioUse === null ? 0:response.list[i].countStudioUse);
                var left4 = count4 - (response.list[i].countWorkcenterUse === null ? 0:response.list[i].countWorkcenterUse);
                var errorMsg = "사용가능";

                // console.log(left1);
                // console.log(left2);
                // console.log(left3);
                // console.log(left4);
                var licenseUse = true;
                if(left1 <= 0 && left2 <= 0 && left3 <= 0 && left4 <= 0){
                    licenseUse = false
                    errorMsg = "발급개수 부족"
                }

                if(enddate != "" && enddate < today){
                    licenseUse = false
                    errorMsg = "계약기간 만료"
                }

                if(response.list[i].licenseStatus == 1 ) {

                    licenseUse = false
                    errorMsg = "관리자 사용불가 처리";
                }else{

                }

                html += '<tr>\
                           <td scope="row">\
                                <div class="form-check">\
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+no+'</td>\
                            <td style="cursor: pointer" ><a href="/contract/contractView?contractSeq='+response.list[i].comContractSeq+'" style="text-decoration: underline">'+response.list[i].contractNumber+'</a></td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">';
                            if(response.list[i].contractType == "1"){
                                html += 'Pilot';
                            }else if(response.list[i].contractType == "2"){
                                html += 'PoC';
                            }else{
                                html += '본사업';
                            }


                        html += '<br>'+licenseType+'</td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+moment(response.list[i].contractStart).format("YYYY-MM-DD")+'<br>'+moment(response.list[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+(response.list[i].countUnattended !== null ? response.list[i].countUnattended:"-")+'</td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+(response.list[i].countAttended !== null ? response.list[i].countAttended:"-")+'</td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+(response.list[i].countStudio !== null ? response.list[i].countStudio:"-")+'</td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+(response.list[i].countWorkcenter !== null ? response.list[i].countWorkcenter:"-")+'</td>\
                            <td style="cursor: pointer" onclick="licenseViewDetail('+response.list[i].seq+')">'+currentStatus+'</td>\
                            <td style="cursor: pointer">'+errorMsg+'</td>\
                            <td >\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item statusChange"  data-seq="'+response.list[i].seq+'" data-status="'+response.list[i].licenseStatus+'">\
                                            <i class="icon-compose mr-2"></i>'+(response.list[i].licenseStatus == 0 ? "사용불가로 변경":"사용가능으로 변경")+'\
                                        </button>\
                                        <button type="button" class="more-action-item licenseDelete" data-seq="'+response.list[i].seq+'">\
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
                html += '<tr><td colspan="11" align=center>등록된 License 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#licenseList").html(html);
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