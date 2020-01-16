$(function(){
    // 리스트 호출
    getList(0,true);

    //회원 등록 및 수정 모달 오픈시 호출
    $("#companyModal").on("show.bs.modal", function(event){

        var button = $(event.relatedTarget)
        if(button.data("seq") != ""){
            $("#comName").val(button.data("comname"));
            $("#bComName").val(button.data("comname"));
            $("#comPhone").val(button.data("comphone"));
            $("#comEmail").val(button.data("comemail"));
            $("#seq").val(button.data("seq"));
            $(".statusArea").show();
            $("input:radio[name='status']:radio[value='"+button.data("status")+"']").prop("checked",true);
            $("#companyModalCenterTitle").text('회사수정');

        }else{
            $("#seq").val("");
            $(".statusArea").hide();
            $("#companyModalCenterTitle").text('회사등록');
        }
    })

    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        var deleteY = 0;
        var deleteN = 0;
        $(".listCheck").each(function () {
            if($(this).is(":checked")) {
                if($(this).data("count") > 0){
                    ++deleteN;
                    $(this).prop("checked",false);
                }else{
                    ++deleteY;
                    deleteArray.push($(this).val());
                }

            }
        });
        var delType = 0;
        listDelete(deleteArray, delType,deleteY,deleteN);
    });

    $("body").on("click",".contractDelete", function () {
        var count = $(this).data("count");
        if(count == 0) {
            var comSeq = $(this).data("seq");
            var deleteArray = [];
            deleteArray.push(comSeq);
            var delType = 1;
            listDelete(deleteArray, delType,1,0);
        }else{
            alert("계약이 존재하는 회사는 삭제가 불가능합니다.");
            return false;
        }
    });

    // 회사 저장
    $(".btn-save").click(function(){
        var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        switch(true){
            case ($("#comName").val() == ""):
                alert("회사명을 입력하세요");
                $("#comName").focus();
                return false;
                break;
            case ($("#comEmail").val() != "" && !emailPattern.test($("#comEmail").val())):
                alert("이메일 형태로 입력하시기 바랍니다.")
                $("#comPhone").focus();
                return false;
                break;
            default:
                console.log("save");
        }

        if($("#seq").val() == ""){
            var msg = "회사를 등록 하시겠습니까?";
            var msg2 = "등록 되었습니다.";
            var url = "/company/write";
            var method = "POST";
        }else{
            var msg = "회사를 수정 하시겠습니까?";
            var msg2 = "수정 되었습니다.";
            var url = "/company/update";
            var method = "PUT";
        }
        if(confirm(msg)) {
            var datas = $("#writeForm").serialize();
            $.ajax({
                url: url,
                type: method,
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    if (response.result) {
                        alert(msg2);
                        document.location.reload();
                    } else {
                        if(response.errorCode == "-1"){
                            alert("회사명이 중복입니다. 확인후 다시 입력해주시기 바랍니다.");
                            return false;
                        }else{
                            alert("수정 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                        }

                    }
                }
            });
        }
    })
});
var deleteProcess = function(deleteArray, delType,deleteY,deleteN){
    var datas = { deleteArray : deleteArray.join("|") };
    if(confirm("선택한 회사를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/company/delete",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                if(response.result){
                    if(delType == 0) {
                        alert("총 " + (deleteY + deleteN) + "선택 중 " + deleteY + "개 삭제 되었습니다." + "\n" + deleteN + "개는 계약이 존재하여 삭제불가능합니다.");
                        // location.reload();
                        getList(0, true);
                    }else{
                        alert("삭제 되었습니다.");
                        // location.reload();
                        getList(0,true);
                    }
                }else{
                    alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                }
            }
        });
    }
}

// 회사 삭제 처리 이벤트
function listDelete(deleteArray, delType,deleteY,deleteN) {

    if((deleteY+deleteN) == 0 && deleteArray.length <= 0) {
        alert("삭제 대상을 1개 이상 선택해야 합니다.");
        return false;
    }

    if(deleteY > 0){
        deleteProcess(deleteArray, delType,deleteY,deleteN);
    }else{
        alert("총 "+(deleteY+deleteN)+"선택 중 "+deleteY+"개 삭제 되었습니다."+"\n"+deleteN+"개는 계약이 존재하여 삭제불가능합니다.");
        $("#allCheck").prop("checked",false);
    }

}
// 리스트 호출
function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/company/ajax_list",
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
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" data-count="'+response.list[i].countContract+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/company/view?seq='+response.list[i].seq+'\'">'+no+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/company/view?seq='+response.list[i].seq+'\'">'+response.list[i].comName+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/company/view?seq='+response.list[i].seq+'\'">'+response.list[i].comPhone+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/company/view?seq='+response.list[i].seq+'\'">'+response.list[i].comEmail+'</td>\
                            <td>총 <a href="/contract/new_list?comSeq='+response.list[i].seq+'" style="text-decoration: underline">'+response.list[i].countContract+'건</a></td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/company/view?seq='+response.list[i].seq+'\'">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/company/view?seq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/company/view?seq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#companyModal" data-seq="'+response.list[i].seq+'" data-comname="'+response.list[i].comName+'" data-comphone="'+response.list[i].comPhone+'" data-comemail="'+response.list[i].comEmail+'" data-status="'+response.list[i].status+'"> \
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item contractDelete" data-seq="'+response.list[i].seq+'" data-count="'+response.list[i].countContract+'">\
                                            <i class="icon-trash1 mr-2"></i>삭제\
                                        </button>\
                                    </div>\
                                </div>\
                            </td>\
                        </tr>';

            }
            if(html == ""){
                html += '<tr><td colspan="9" align=center>등록된 회사 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#contractList").html(html);
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
                $("#paging").html("");
            }
        }
    });
}

var excelDataMake = function(chkValueArr){
    var datas = { chkValueArr : chkValueArr.join("|"),"sort":$("#sort").val(),"order":$("#order").val() };
    $.ajax({
        url: "/company/execlDownList",
        type: 'POST',
        dataType: 'JSON',
        data: datas
    }).done(function (response) {
        console.log(response);
        var companyList = response.list;
        var html = '';
        for(var i=0;i<companyList.length;i++) {
            var comName = companyList[i].comName;

            // var comPhone = String(companyList[i].comPhone);

            var comEmail = companyList[i].comEmail;

            var createDatetime = getFormatDate(companyList[i].createDatetime);
            var status = companyList[i].status;

            html =
                '<tr>' +
                '<td>'+(i+1)+'</td>'+
                '<td>'+(comName === null ? "":comName)+'</td>'+
                '<td>'+(companyList[i].comPhone === null ? "":companyList[i].comPhone)+'</td>'+
                '<td>'+(comEmail === null ? "":comEmail)+'</td>'+
                '<td>총 '+companyList[i].countContract+'건</td>'+
                '<td>'+createDatetime+'</td>'+
                '</tr>';
            $("#comContractListByExeclBody").append(html);
        }

        var filename = "contractCompanyList.xlsx";
        /* create new workbook */
        var workbook = XLSX.utils.book_new();

        /* convert table 'table1' to worksheet named "Sheet1" */
        var ws1 = XLSX.utils.table_to_sheet(document.getElementById('comContractListByExeclTable'));
        XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

        XLSX.writeFile(workbook, filename);
    });
}

// 엑셀 다운로드
function excelDownload(){

    $("#comContractListByExeclBody").html("");

    var chkValueArr = [];
    $(".listCheck").each(function () {
        if($(this).is(":checked")) chkValueArr.push($(this).val());
    });
    if(chkValueArr <= 0) {
        alert("회사를 1개 이상 선택해야합니다.");
    } else {
        excelDataMake(chkValueArr);
    }
}