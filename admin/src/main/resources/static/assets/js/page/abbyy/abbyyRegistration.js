$(function(){

    $(".newWindowView").on("click", function () {
        var seq = $(this).data("seq");
        window.open('/license/detail?seq='+seq, '_blank');
    });

    $(".urlCopy").on("click", function () {
        var seq = $(this).data("seq");
        copyToClipboard(location.host + '/license/detail?seq='+seq);
        alert("URL 복사 완료!");
    });

    $(".btn-checkdelete").on("click", function () {
        var deleteArray = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) deleteArray.push($(this).val());
        });

        fnlicenseDelete(deleteArray);
    });

    $(".licenseModify").on("click", function () {
        var seq = $(this).data("seq");
        document.location.href = '/license/licenseModify?seq='+seq;
    });

    $(".licenseDelete").on("click", function () {
        var seq = $(this).data("seq");
        var deleteArray = [];
        deleteArray.push(seq);
        fnlicenseDelete(deleteArray);
    });

    $(".btn-row").click(function(){
        $("#row").val($(this).data("row"));
        $("#searchForm").submit();
    });

    // $('#licenseModal').on('hidden.bs.modal', function (event) {
    //
    // });
    //
    // $('#licenseModal').on('show.bs.modal', function (event) {
    //     var button = $(event.relatedTarget);
    //     var seq = button.data("seq");
    //     $.ajax({
    //         url: "/license/licenseModalView?seq="+seq,
    //         type: 'GET'
    //         //ascyc: false
    //     }).done(function (response) {
    //         $("#license-modal-view").html(response);
    //     });
    // });

});

function copyToClipboard(val) {
    var t = document.createElement("textarea");
    document.body.appendChild(t);
    t.value = val;
    t.select();
    document.execCommand('copy');
    document.body.removeChild(t);
}

function fnlicenseDelete(deleteArray) {
    var datas = {
        deleteArray : deleteArray.join("|")
    };

    if(confirm("선택한 라이센스를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
        $.ajax({
            url: "/license/licenseDelete",
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

function licenseViewDetail(seq) {
    document.location.href = '/license/detail?seq='+seq;
}