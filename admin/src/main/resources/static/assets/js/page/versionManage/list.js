$(function(){

    getList(0,true);

    $(".btn-save").on("click", function(){
        if(confirm("프로그램 버전 정보를 등록하시겠습니까?")) {
            var formData = new FormData($("#writeForm")[0]);
            $.ajax({
                url: "/version_manage/save",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    if(response.result){
                        alert("등록 되었습니다!");
                        $('#versionModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert(" 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
    });

    $(".btn-save-wc").on("click", function(){
        if(confirm("WorkCenter 버전 정보를 등록하시겠습니까?")) {
            var formData = new FormData($("#writeForm2")[0]);
            $.ajax({
                url: "/version_manage/save",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    if(response.result){
                        alert("등록 되었습니다!");
                        $('#versionModalWc').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert(" 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
    });

    $('#updateDatetimeStr').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true
    });

    $('#updateDatetimeStr2').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true
    });

    $("body").on("click",".btn-delete", function(){
        if(confirm("선택한 버전을 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")){
            $.ajax({
                url: "/version_manage/delete?seq="+$(this).data("seq"),
                type: 'DELETE',
                dataType: 'JSON',
                success: function (response) {
                    if(response.result){
                        alert("삭제 되었습니다.");
                        location.reload();
                    }else{
                        alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                    }
                }
            });
        }
    });

    $(".btn-checkdelete").click(function(){
        if(confirm("선택한 버전을 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")){
            var seq = [];
            $(".listCheck").each(function(){
                seq.push("seq="+$(this).val());
            })
            $.ajax({
                url: "/version_manage/delete_check?"+seq.join("&"),
                type: 'DELETE',
                dataType: 'JSON',
                success: function (response) {
                    if(response.result){
                        alert("삭제 되었습니다.");
                        location.reload();
                    }else{
                        alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                    }
                }
            });
        }
    });

    $(".sorting").on("click", function(){
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
    $("#searchForm").submit(function(){
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
        getList(0,true);
        return false;
    })
});

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/version_manage/ajax_list",
        type: 'GET',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            console.log(response);
            var html = "";
            if(response.list.length > 0) {
                for(var i =0 ; i< response.list.length;i++){
                    var no = response.total-(num*$("#row").val()+i);
                    var versionType = response.list[i].versionType;
                    if(versionType == 0) versionType = "Launcher";
                    else if(versionType == 1) versionType = "Studio";
                    else versionType = "Trial";

                    var bitType = response.list[i].bitType;
                    if(bitType == 0) bitType = "32x";
                    else bitType = "64x";

                    var filePath = response.list[i].filePath;
                    if(filePath == null || filePath == "") filePath = "";

                    html +=
                    '<tr>\
                       <td scope="row">\
                            <div class="form-check">\
                                <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                            </div>\
                        </td>\
                        <td>'+no+'</td>\
                        <td>'+versionType+'</td>\
                        <td>'+bitType+'</td>\
                        <td>'+response.list[i].versionNumber+'</td>\
                        <td>'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                        <td>'+moment(response.list[i].updateDatetime).format("YYYY-MM-DD")+'</td>\
                        <td></td>\
                        <td>\
                            <div class="more-action-dropdown">\
                                <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                <div class="more-action-dropdown-content">\
                                    <button type="button" class="more-action-item newWindowView" data-seq="'+response.list[i].seq+'" data-filpath="'+filePath+'">\
                                        <i class="icon-download mr-2"></i>다운로드\
                                    </button>\
                                    <div class="dropdown-divider"></div>\
                                    <button type="button" class="more-action-item btn-delete" data-seq="'+response.list[i].seq+'">\
                                        <i class="icon-trash1 mr-2"></i>삭제\
                                    </button>\
                                </div>\
                            </div>\
                        </td>\
                    </tr>';
                }
            } else {
                html +=
                '<tr>' +
                    '<td colspan="10" align="center">검색된 프로그램 버전이 없습니다.</td>' +
                '</tr>';
            }
            $("#versionManageList").html(html);
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