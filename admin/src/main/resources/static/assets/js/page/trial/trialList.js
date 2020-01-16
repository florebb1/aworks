$(function(){
    getList(0,true);
    // $(".btn-checkdelete").on("click", function () {
    //     var deleteArray = [];
    //     $(".listCheck").each(function () {
    //         if($(this).is(":checked")) deleteArray.push($(this).val());
    //     });
    //
    //     fnTrialDelete(deleteArray);
    // });

    $("body").on("click",".reDownload", function(){
        if(confirm("파일을 다운로드 하시겠습니까?")) {
            var seq = $(this).data("seq");
            var email = $(this).data("email");
            $.ajax({
                url: "/trial/re_download",
                type: 'GET',
                data: "seq=" + seq,
                dataType: 'JSON',
                success: function (response) {
                    console.log(response);
                    var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                    saveAs(blob, "license_"+email+".license");
                    // setTimeout(function () {
                    //     location.reload();
                    // }, 500);
                    // location.reload();
                }
            });
        }
    })

    $("body").on("click",".reEmail", function(){
        var email = $(this).data("email");
        if(confirm("라이선스 파일을 "+email+" 주소로 발송 하시겠습니까?")) {
            var seq = $(this).data("seq");
            $.ajax({
                url: "/trial/re_emailsend",
                type: 'GET',
                data: "seq=" + seq,
                dataType: 'JSON',
                success: function (response) {
                    alert("발송되었습니다");
                }
            });
        }
    })

    $("body").on("click",".delete",function(){
        if(confirm("선택한 Trial을 삭제하시겠습니까?\n(삭제 시 비활성화 처리 됩니다.)")) {
            $.ajax({
                url: "/trial/delete",
                type: 'POST',
                dataType: 'JSON',
                data: "seq="+$(this).data("seq"),
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
    })
});

function fnTrialDelete(deleteArray) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };

    if(confirm("선택한 Trial을 삭제하시겠습니까?\n(삭제 시 비활성화 처리 됩니다.)")) {
        $.ajax({
            url: "/trial/delete",
            type: 'POST',
            dataType: 'JSON',
            data: datas,
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
}

function getList(num,refresh){
    $("input:checkbox[id='allCheck']").prop("checked", false);
    var datas = $("#searchForm").serialize()+"&page="+num;
    $.ajax({
        url: "/trial/ajax_list",
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
                            <td>'+no+'</td>\
                            <td>'+(response.list[i].name === null ? '':response.list[i].name)+'</td>\
                            <td>'+response.list[i].email+'</td>\
                            <td>'+response.list[i].phone+'</td>\
                            <td>'+response.list[i].company+'</td>\
                            <td>'+response.list[i].position+'</td>\
                            <td>'+moment(response.list[i].startDate).format("YYYY-MM-DD")+'</td>\
                            <td>'+moment(response.list[i].endDate).format("YYYY-MM-DD")+'</td>\
                            <!--td>'+(response.list[i].status == 0 ? "비활성화":"활성화")+'</td-->\
                            <!--td>'+response.list[i].licenseKey+'</td-->\
                            <td >\
                                <div class="more-action-dropdown">\
                                    <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                                    <div class="more-action-dropdown-content">\
                                        <button type="button" class="more-action-item reEmail"  data-seq="'+response.list[i].seq+'" data-email="'+response.list[i].email+'">\
                                            <i class="icon-compose mr-2"></i>재발송\
                                        </button>\
                                        <button type="button" class="more-action-item reDownload" data-seq="'+response.list[i].seq+'" data-email="'+response.list[i].email+'">\
                                            <i class="icon-trash1 mr-2"></i>다운로드\
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
                html += '<tr><td colspan="11" align=center>등록된 Trial 목록이 존재하지 않습니다.</td></tr>';
            }
            $("#trialList").html(html);
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