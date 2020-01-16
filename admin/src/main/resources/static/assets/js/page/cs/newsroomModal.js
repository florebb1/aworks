$(function(){

    $(".input-form").on({
        keyup: function () {
            $(".text-danger").text("");
        },
        change: function () {
            $(".text-danger").text("");
        },
        click: function () {
            $(".text-danger").text("");
        }
    });

    $('#viewDate').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        showOtherMonths: true,
        autoclose : true,
        clearBtn: true

    });

    $(".btn-save").on("click", function(){

        if($("#title").val() == null || $("#title").val() == "") {
            $("#titleChkText").text("* 뉴스룸 제목을 입력해주세요.");
            $("#titleChkText").css("display", "block");
            return false;
        }
        // alert($("#viewDate").val());
        if($("#viewDate").val() == ""){
            $("#viewDateChkText").text("* 기사등록일을 입력해주세요.");
            $("#viewDateChkText").css("display", "block");
            return false;
        }

        var summerNoteValue = $(".contentNote").summernote('code');
        // console.log($(".contentNote").summernote('code'));
        // return false;
        if(summerNoteValue == '<p><br></p>' || summerNoteValue == '<p><br></p><p><br></p>' || summerNoteValue == "" || summerNoteValue == '&nbsp;') {
            $("#contentChkText").text("* 뉴스룸 내용을 입력해주세요.");
            $("#contentChkText").css("display", "block");
            return false;
        } else {
            // 서머노트 에디터 값 적용
            $("#content").val(summerNoteValue);
        }

        // 체크 메시지 초기화
        $(".text-danger").text("");

        // 등록, 수정 메시지 적용 및 처리
        var message = "";
        if($("#seq").val() == null || $("#seq").val() == "") message = "등록";
        else message = "수정";

        if(confirm("뉴스룸을 "+message+"하시겠습니까?")) {
            var formData = new FormData($("#writeForm")[0]);
            $.ajax({
                url: "/cs/newsroomSave",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    console.log(response);
                    if(response.result){
                        alert(message+" 되었습니다!");
                        $('#noticeModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert(message+" 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
        return false;
    });
});