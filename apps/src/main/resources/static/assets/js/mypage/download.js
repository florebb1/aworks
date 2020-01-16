$(document).ready(function () {
    $('#userId').val(sessionStorage.getItem("loginId"));

    // //등록버튼 이벤트
    // $("#send").click(function() {
    //     var title = $('#title').val();
    //     var contant = $('#content').val();
    //
    //     if(title == null || title == "") {
    //         alert("제목을 입력해주세요.");
    //         return false
    //     }else if(contant == null || contant == "") {
    //         alert("내용을 입력해주세요");
    //         return false
    //     }
    //     var datas = $("#directFrom").serialize();
    //     $.ajax({
    //         url: "/board/onetoone",
    //         type: 'POST',
    //         data: datas,
    //         dataType: 'JSON',
    //         success: function (response) {
    //             if(response.result == true) {
    //                 alert("등록 처리 되었습니다.");
    //                 location.href = "/"
    //             }else {
    //                 alert("등록중 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
    //             }
    //         }
    //     })
    // });
});