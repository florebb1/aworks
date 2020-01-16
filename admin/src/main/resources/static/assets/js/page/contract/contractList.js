$(function(){
    getList(0,true);

    $("body").on("click",".btn-checkdelete", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        var delType = 0;
        listDelete(deleteArray, delType);
    });

    $("body").on("click",".contractDelete", function () {
        var comSeq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(comSeq);
        var delType = 1;
        listDelete(deleteArray, delType);
    });

    // 계약회사 라이센스 목록 모달 닫기 후 이벤트
    $('#comLicenseModal').on('hidden.bs.modal', function (e) {
        $('#clSearchList').empty();
        $('#cl-page-selection').empty();
    });
    // 계약회사 라이센스 목록 모달 열기 후 이벤트
    $('#comLicenseModal').on('shown.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var seq = button.data("seq");
        comLicenseList(1, seq, true);
    });
    // 계약회사 라이센스 목록 모달 > 검색버튼 이벤트
    $("#cl-button-search").on("click", function () {
        var clSeq = $("#clSeq").val();
        console.log(clSeq);
        $('#cl-page-selection').empty();
        comLicenseList(1, clSeq,true);
    });


    $("body").on("click", '#clAllChk', function(){
        console.log(111);
        if($(this).is(":checked")){
            $(".clChk").prop("checked",true);
        }else{
            $(".clChk").prop("checked",false);
        }
    });

    $("body").on("click",".clChk", function(){
        // alert(1)
        var class_length = $(".clChk").length;
        var checked_length = 0;
        $(".clChk").each(function(){
            if($(this).is(":checked")) checked_length++;
        });

        if($(this).is(":checked")) {
            if(class_length <= checked_length) $("#clAllChk").prop("checked", true);
        } else {
            $("#clAllChk").prop("checked", false);
        }
    });


    $('#clDatestart').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true
    });
    $('#clDateend').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true
    });



    $("body").on("click",".cl-btn-checkdelete", function () {
        var deleteArray = [];
        $(".clChk").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });
        var delType = 0;
        licenseListDelete(deleteArray, delType);
    });
});


// 계약회사 라이센스 목록 호출
function comLicenseList(num, seq, check) {
    $("#clAllChk").prop("checked",false)
    var html = '';
    var datas = {
        seq : seq,
        clRow : 10 ,
        clSort : $("#clSort").val() ,
        clPage : num ,
        clOrder : 0 ,
        clContractType: $("#clContractType").val(),
        clLicenseType : $("#clLicenseType").val(),
        clSubscribeType : $("#clSubscribeType").val(),
        clLicenseStatus : $("#clLicenseStatus").val(),
        contractSeq: seq
    };

    $.ajax({
        url: "/contract/comLicenseList",
        type: 'POST',
        dataType: 'JSON',
        data: datas,
        ascyc: false
    }).done(function (response) {

        $("#clTotal").val(response.no);
        $("#clSeq").val(response.clSeq);
        var rsList = response.resultsList;
        if(rsList.length > 0) {
            for(var i=0;i<rsList.length;i++) {
                var startdate = moment(rsList[i].contractStart).format("YYYY-MM-DD");
                var enddate = moment(rsList[i].contractEnd).format("YYYY-MM-DD");
                var today = moment(new Date()).format("YYYY-MM-DD");
                // 계약방식
                var subscribeType = rsList[i].subscribeType;
                if(subscribeType == 0) subscribeType = 'yearly';
                else subscribeType = 'runtime';

                // 상태
                var status = rsList[i].status;
                if(status == 0) status = '신청';
                else status = '발급완료';

                // 생성일
                var createDatetime = getFormatDate(rsList[i].createDatetime);
                // 시작일
                var startDate = getFormatDate(rsList[i].startDate);
                // 종료일
                var endDate = getFormatDate(rsList[i].endDate);
                if(rsList[i].contractType == "1"){
                    var contractType = "Pilot";
                }else if(rsList[i].contractType == "2"){
                    var contractType = "PoC";
                }else{
                    var contractType = "본사업";
                }

                if(rsList[i].licenseType == "1"){
                    var licenseType = "PC형";
                }else if(rsList[i].licenseType == "2"){
                    var licenseType = "Cloud형";
                }else{
                    var licenseType = "On-Premise형";
                }

                if(rsList[i].subscribeType == "1"){
                    var subscribeType = "Hour";
                }else if(rsList[i].subscribeType == "2"){
                    var subscribeType = "Month";
                }else{
                    var subscribeType = "Annual";
                }
                var left1 = rsList[i].countUnattended - rsList[i].countUnAttendedUse;
                var left2 = rsList[i].countAttended - rsList[i].countAttendedUse;
                var left3 = rsList[i].countStudio - rsList[i].countStudioUse;
                var left4 = rsList[i].countWorkcenter - rsList[i].countWorkcenterUse;
                var errorMsg = "사용가능";


                var licenseUse = true;
                if(left1 == 0 && left2 == 0 && left3 == 0 && left4 == 0){
                    licenseUse = false
                    errorMsg = "발급개수 부족"
                }

                if(enddate != "" && enddate < today){
                    licenseUse = false
                    errorMsg = "계약기간 만료"
                }

                if(rsList[i].licenseStatus == 1 ) {

                    licenseUse = false
                    errorMsg = "관리자 사용불가 처리";
                }else{

                }
                html += '<tr>\
                        <td scope="row">\
                            <div class="form-check">\
                                <input class="form-check-input position-static clChk" name="seqs" type="checkbox" value="'+rsList[i].seq+'" aria-label="...">\
                            </div>\
                       </td>\
                    <td>\
                    '+contractType+'\
                    </td>\
                    <td>\
                    '+licenseType+'\
                    </td>\
                    <td>\
                    '+subscribeType+'\
                    </td>\
                    <td>'+rsList[i].countUnattended+'</td>\
                    <td>'+rsList[i].countAttended+'</td>\
                    <td>'+rsList[i].countStudio+'</td>\
                    <td>'+rsList[i].countWorkcenter+'</td>\
                    <td>'+errorMsg+'</td>\
                    <td>\
                        <button type="button" class="btn btn-secondary btn-sm newWindowView" data-url="/license/detail?seq='+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">\
                            <i class="icon-newpage"></i>\
                        </button>\
                        <button type="button" class="btn btn-secondary btn-sm urlCopy" data-url="/license/detail?seq='+rsList[i].seq+'" data-toggle="tooltip" data-placement="top" title="URL 복사">\
                            <i class="icon-urlcopy"></i>\
                        </button>\
                    </td>\
                </tr>';
            }
        } else {
            html +=
                '<tr>\n' +
                '<td colspan="10" align="center">등록된 라이센스가 없습니다.</td>\n' +
                '</tr>';
        }

        $("#clSearchList").empty();
        $("#clSearchList").html(html);

        if(check) {
            var totalPage = $("#clTotal").val();
            $('#cl-page-selection').bootpag({
                total: totalPage
            }).on("page", function(event, num){
                comLicenseList(num, seq, false);
            });
        }
    });
}

// 계약회사 삭제 처리 이벤트
function listDelete(deleteArray, delType) {
    var datas = { deleteArray : deleteArray.join("|") };
    if(delType == 0) {
        if(deleteArray.length <= 0) {
            alert("삭제 대상을 1개 이상 선택해야 합니다.");
            return false;
        }
    }
    if(confirm("선택된 계약을 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/contract/contractDelete",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                console.log(response);
                if(response.result){
                    if(delType == 0) {
                        if (response.data.deleteN == 0) {
                            alert("총 " + deleteArray.length + "선택 중 " + response.data.deleteY + "개 삭제 되었습니다.");
                        } else {
                            alert("총 " + deleteArray.length + "선택 중 " + response.data.deleteY + "개 삭제 되었습니다." + "\n" + response.data.deleteN + "개는 라이선스가 발급되어 삭제불가능합니다.");
                        }
                    }else{
                        if (response.deleteN == 0) {
                            alert("삭제 되었습니다.");
                        }else{
                            alert("라이선스가 사용된 계약은 삭제가 불가능합니다.");
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


function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/contract/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            var html = "";
            for(var i =0 ; i< response.list.length;i++){
                var no = response.total-(num*$("#row").val()+i);
                if(response.list[i].subscribeType == "1"){
                    var subscribeType = "Hour";
                }else if(response.list[i].subscribeType == "2"){
                    var subscribeType = "Month";
                }else{
                    var subscribeType = "Annual";
                }
                var startdate = moment(response.list[i].contractStart).format("YYYY-MM-DD");
                var enddate = moment(response.list[i].contractEnd).format("YYYY-MM-DD");
                var today = moment(new Date()).format("YYYY-MM-DD");
                // console.log(today);
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


                html += '<tr>\
                            <td scope="row">\
                                <div class="form-check">\
                                    <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                            </td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+no+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+response.list[i].contractNumber+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+response.list[i].comName+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+response.list[i].contractName+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+moment(response.list[i].contractStart).format("YYYY-MM-DD")+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+moment(response.list[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+currentStatus+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+response.list[i].userName+'</td>\
                            <td style="cursor: pointer" onclick="document.location.href=\'/contract/contractView?contractSeq='+response.list[i].seq+'\'">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                            <td>\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item newWindowView" data-url="/contract/contractView?contractSeq='+response.list[i].seq+'">\
                                            <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                                        </button>\
                                        <button type="button" class="more-action-item urlCopy" data-url="/contract/contractView?contractSeq='+response.list[i].seq+'">\
                                            <i class="icon-layers mr-2"></i>URL 복사\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#comLicenseModal" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-key1 mr-2"></i>계약회사 라이선스 목록\
                                        </button>\
                                        <div class="dropdown-divider"></div>\
                                        <button type="button" class="more-action-item" onclick="document.location.href=\'/contract/new_update?comContractSeq='+response.list[i].seq+'\'" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-compose mr-2"></i>수정\
                                        </button>\
                                        <button type="button" class="more-action-item contractDelete" data-seq="'+response.list[i].seq+'">\
                                            <i class="icon-trash1 mr-2"></i>삭제\
                                        </button>\
                                    </div>\
                                </div>\
                            </td>\
                        </tr>';

            }
            if(html == ""){
                html += '<tr><td colspan="9" align=center>등록된 계약 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#contractList").html(html);
            // $("#totalCnt").html(response.total);
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

function licenseListDelete(deleteArray, delType) {
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
                    if (response.data.deleteN == 0) {
                        alert("총 " + deleteArray.length + "선택 중 " + response.data.deleteY + "개 삭제 되었습니다.");
                    } else {
                        alert("총 " + deleteArray.length + "선택 중 " + response.data.deleteY + "개 삭제 되었습니다." + "\n" + response.data.deleteN + "개는 라이선스가 발급되어 삭제불가능합니다.");
                    }
                    // location.reload();
                    // getList(0,true);
                    // console.log($("#clSeq").val());
                    comLicenseList(1, $("#clSeq").val(), true);
                }else{
                    alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                }
            }
        });
    }
}

function excelDownload(){

    $("#comContractListByExeclBody").html("");

    var chkValueArr = [];
    $(".listCheck").each(function () {
        if($(this).is(":checked")) chkValueArr.push($(this).val());
    });
    if(chkValueArr <= 0) {
        alert("계약을 1개 이상 선택해야합니다.");
    } else {
        var datas = { checkSeq : chkValueArr.join("|"),"sort":$("#sort").val(),"order":$("#order").val() };
        // console.log(datas);
        // return false;
        $.ajax({
            url: "/contract/execlDownList",
            type: 'POST',
            dataType: 'JSON',
            data: datas
        }).done(function (response) {
            console.log(response);
            var companyList = response.list;
            var html = '';
            for(var i=0;i<companyList.length;i++) {
                var startdate = moment(companyList[i].contractStart).format("YYYY-MM-DD");
                var enddate = moment(companyList[i].contractEnd).format("YYYY-MM-DD");
                var today = moment(new Date()).format("YYYY-MM-DD");
                // console.log(today);
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
                if(companyList[i].contractType == 1){
                    var contractType = "Pilot";
                }else if(companyList[i].contractType == 2){
                    var contractType = "PoC";
                }else{
                    var contractType = "본사업";
                }
                if(companyList[i].licenseType == 1){
                    var licenseType = "PC형";
                }else if(companyList[i].licenseType == 2){
                    var licenseType = "Cloud형";
                }else{
                    var licenseType = "On-premise형";
                }

                if(companyList[i].subscribeType == 1){
                    var subscribeType = "Hour";
                }else if(companyList[i].subscribeType == 2){
                    var subscribeType = "Month";
                }else{
                    var subscribeType = "Annual";
                }
                html = '<tr><td >'+(i+1)+'</td>\
                        <td >'+companyList[i].contractNumber+'</td>\
                        <td >'+companyList[i].comName+'</td>\
                        <td >'+companyList[i].contractName+'</td>\
                        <td >'+moment(companyList[i].contractStart).format("YYYY-MM-DD")+'</td>\
                        <td >'+moment(companyList[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                        <td >'+companyList[i].userName+'</td>\
                        <td >'+companyList[i].loginId+'</td>\
                        <td >'+companyList[i].userPhone+'</td>\
                        <td >'+currentStatus+'</td>\
                        <td >'+companyList[i].contractIctName+'</td>\
                        <td >'+contractType+'</td>\
                        <td >'+licenseType+'</td>\
                        <td >'+subscribeType+'</td>\
                        <td >'+(companyList[i].unattendedLicensePrice === null ? 0:companyList[i].unattendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].unattendedLicenseListPrice === null ? 0:companyList[i].unattendedLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countUnattended === null ? 0:companyList[i].countUnattended)+'</td>\
                        <td >'+(companyList[i].attendedLicensePrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].attendedLicenseListPrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].countAttended === null ? 0:companyList[i].countAttended)+'</td>\
                        <td >'+(companyList[i].studioLicensePrice === null ? 0:companyList[i].studioLicensePrice)+'</td>\
                        <td >'+(companyList[i].studioLicenseListPrice === null ? 0:companyList[i].studioLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countStudio === null ? 0:companyList[i].countStudio)+'</td>\
                        <td >'+(companyList[i].workcenterLicensePrice === null ? 0:companyList[i].workcenterLicensePrice)+'</td>\
                        <td >'+(companyList[i].workcenterLicenseListPrice === null ? 0:companyList[i].workcenterLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countWorkcenter === null ? 0:companyList[i].countWorkcenter)+'</td>\
                        <td >'+moment(companyList[i].createDatetime).format("YYYY-MM-DD")+'</td></tr>';

                $("#comContractListByExeclBody").append(html);
            }

            var filename = "contractList.xlsx";
            /* create new workbook */
            var workbook = XLSX.utils.book_new();

            /* convert table 'table1' to worksheet named "Sheet1" */
            var ws1 = XLSX.utils.table_to_sheet(document.getElementById('comContractListByExeclTable'));
            XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

            XLSX.writeFile(workbook, filename);
        });
    }
}

function excelSubDownload(){

    $("#licenseListByExeclBody").html("");

    var chkValueArr = [];
    $(".clChk").each(function () {
        if($(this).is(":checked")) chkValueArr.push($(this).val());
    });
    if(chkValueArr <= 0) {
        alert("라이선스를 1개 이상 선택해야합니다.");
    } else {
        var datas = { checkSeq : chkValueArr.join("|") };
        $.ajax({
            url: "/license/execlDownList",
            type: 'POST',
            dataType: 'JSON',
            data: datas
        }).done(function (response) {
            var companyList = response.list;
            var html = '';
            for(var i=0;i<companyList.length;i++) {
                var startdate = moment(companyList[i].contractStart).format("YYYY-MM-DD");
                var enddate = moment(companyList[i].contractEnd).format("YYYY-MM-DD");
                var today = moment(new Date()).format("YYYY-MM-DD");
                // console.log(today);
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
                if(companyList[i].contractType == 1){
                    var contractType = "Pilot";
                }else if(companyList[i].contractType == 2){
                    var contractType = "PoC";
                }else{
                    var contractType = "본사업";
                }
                if(companyList[i].licenseType == 1){
                    var licenseType = "PC형";
                }else if(companyList[i].licenseType == 2){
                    var licenseType = "Cloud형";
                }else{
                    var licenseType = "On-premise형";
                }

                if(companyList[i].subscribeType == 1){
                    var subscribeType = "Hour";
                }else if(companyList[i].subscribeType == 2){
                    var subscribeType = "Month";
                }else{
                    var subscribeType = "Annual";
                }
                html = '<tr><td >'+(i+1)+'</td>\
                        <td >'+companyList[i].contractNumber+'</td>\
                        <td >'+companyList[i].comName+'</td>\
                        <td >'+companyList[i].contractName+'</td>\
                        <td >'+moment(companyList[i].contractStart).format("YYYY-MM-DD")+'</td>\
                        <td >'+moment(companyList[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                        <td >'+companyList[i].userName+'</td>\
                        <td >'+companyList[i].loginId+'</td>\
                        <td >'+companyList[i].userPhone+'</td>\
                        <td >'+currentStatus+'</td>\
                        <td >'+companyList[i].contractIctName+'</td>\
                        <td >'+contractType+'</td>\
                        <td >'+licenseType+'</td>\
                        <td >'+subscribeType+'</td>\
                        <td >'+(companyList[i].unattendedLicensePrice === null ? 0:companyList[i].unattendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].unattendedLicenseListPrice === null ? 0:companyList[i].unattendedLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countUnattended === null ? 0:companyList[i].countUnattended)+'</td>\
                        <td >'+(companyList[i].attendedLicensePrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].attendedLicenseListPrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].countAttended === null ? 0:companyList[i].countAttended)+'</td>\
                        <td >'+(companyList[i].studioLicensePrice === null ? 0:companyList[i].studioLicensePrice)+'</td>\
                        <td >'+(companyList[i].studioLicenseListPrice === null ? 0:companyList[i].studioLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countStudio === null ? 0:companyList[i].countStudio)+'</td>\
                        <td >'+(companyList[i].workcenterLicensePrice === null ? 0:companyList[i].workcenterLicensePrice)+'</td>\
                        <td >'+(companyList[i].workcenterLicenseListPrice === null ? 0:companyList[i].workcenterLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countWorkcenter === null ? 0:companyList[i].countWorkcenter)+'</td>\
                        <td >'+moment(companyList[i].createDatetime).format("YYYY-MM-DD")+'</td></tr>';

                $("#licenseListByExeclBody").append(html);
            }

            var filename = "licenseList.xlsx";
            /* create new workbook */
            var workbook = XLSX.utils.book_new();

            /* convert table 'table1' to worksheet named "Sheet1" */
            var ws1 = XLSX.utils.table_to_sheet(document.getElementById('licenseListByExeclTable'));
            XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

            XLSX.writeFile(workbook, filename);
        });
    }
}