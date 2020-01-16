$(function(){
    // 페이지 로드시 리스트 호출
    getList(0,true);
    // tooltip 호출
    $('[data-toggle="tooltip"]').tooltip()

    // 체크 삭제 로직
    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });

        listDelete(deleteArray);
    });

    // 개별 삭제 로직
    $("body").on("click",".listDel", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        listDelete(deleteArray);
    });

});

// 리스트 삭제 시 호출
function listDelete(deleteArray) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };

    if(confirm("선택한 ABBYY 라이센스를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/abbyy/licenseDelete",
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


// 리스트 호출 함수
function getList(num,refresh){
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/abbyy/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            var html = "";
            for(var i =0 ; i< response.list.length;i++){
                var no = response.total-(num*$("#row").val()+i);
                html += '<tr>\
                           <td scope="row">\
                                <div class="form-check">\
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/abbyy/detail?seq='+response.list[i].seq+'\'">'+no+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/abbyy/detail?seq='+response.list[i].seq+'\'">'+response.list[i].comName+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/abbyy/detail?seq='+response.list[i].seq+'\'">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/abbyy/detail?seq='+response.list[i].seq+'\'">'+moment(response.list[i].startDate).format("YYYY-MM-DD")+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/abbyy/detail?seq='+response.list[i].seq+'\'">'+moment(response.list[i].endDate).format("YYYY-MM-DD")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/abbyy/detail?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/abbyy/detail?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item listUrlModify" title="수정" data-url="/abbyy/registrationForm?seq='+response.list[i].seq+'">\
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item listDel" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-trash1 mr-2"></i>삭제\
                                        </button>\
                                    </div>\
                                </div>\
                            </td>\
                        </tr>';
            }
            if(html == ""){
                html += '<tr><td colspan="7" align=center>등록된 abbyy 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#abbyyList").html(html);
            $("#totalCnt").html(response.total);
            // 페이징 새로고침일 경우 페이징 플러그인 호출
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
        }
    });
}

// 엑셀다운로드 함수
function excelDownload(){

    $("#abbyyListByExeclBody").html("");

    var chkValueArr = [];
    $(".listCheck").each(function () {
        if($(this).is(":checked")) chkValueArr.push($(this).val());
    });
    if(chkValueArr <= 0) {
        alert("ABBYY 라이선스를 1개 이상 선택해야합니다.");
    } else {
        var datas = { chkValueArr : chkValueArr.join("|") };
        $.ajax({
            url: "/abbyy/execlDownList",
            type: 'POST',
            dataType: 'JSON',
            data: datas
        }).done(function (response) {
            console.log(response);
            var abbyyList = response.list;
            var html = '';
            for(var i=0;i<abbyyList.length;i++) {
                var comName = abbyyList[i].comName;
                if(comName == null || comName == "") comName = "";

                var createDatetime = getFormatDate(abbyyList[i].createDatetime);

                var startDate = getFormatDate(abbyyList[i].startDate);

                var endDate = getFormatDate(abbyyList[i].endDate);

                html =
                    '<tr>' +
                    '<td>'+abbyyList[i].seq+'</td>'+
                    '<td>'+comName+'</td>'+
                    '<td>'+createDatetime+'</td>'+
                    '<td>'+startDate+'</td>'+
                    '<td>'+endDate+'</td>'+
                    '</tr>';
                $("#abbyyListByExeclBody").append(html);
            }

            var filename = "abbyyLicenseList.xlsx";
            /* create new workbook */
            var workbook = XLSX.utils.book_new();

            /* convert table 'table1' to worksheet named "Sheet1" */
            var ws1 = XLSX.utils.table_to_sheet(document.getElementById('abbyyListByExeclTable'));
            XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

            XLSX.writeFile(workbook, filename);
        });
    }
}