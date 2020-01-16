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

    $(".btn-save").on("click", function(){

        if($("#title").val() == null || $("#title").val() == "") {
            $("#titleChkText").text("* 버그신고 제목을 입력해주세요.");
            $("#titleChkText").css("display", "block");
            return false;
        }

        var summerNoteValue = $("#contentNote").summernote('code');
        if(summerNoteValue == '<p><br></p>' || summerNoteValue == '<p><br></p><p><br></p>'
            || summerNoteValue == "" || summerNoteValue == '&nbsp;') {
            $("#contentChkText").text("* 버그신고 내용을 입력해주세요.");
            $("#contentChkText").css("display", "block");
            return false;
        } else {
            // 서머노트 에디터 값 적용
            $("#content").val(summerNoteValue);
        }

        var answerContentValue = $("#answerContentNote").summernote('code');
        if(answerContentValue != null && answerContentValue != '' && answerContentValue != '<p><br></p>') {
            if(answerContentValue == '<p><br></p>' || answerContentValue == '<p><br></p><p><br></p>'
                || answerContentValue == "" || answerContentValue == '&nbsp;') {
                $("#answerContentChkText").text("* 답변 내용 정확히 입력해주세요.");
                $("#answerContentChkText").css("display", "block");
                return false;
            } else {
                // 서머노트 에디터 값 적용
                $("#answerContent").val(answerContentValue);
            }
        }

        // 체크 메시지 초기화
        $(".text-danger").text("");
        if(confirm("버그신고를 수정 하시겠습니까?")) {
            var formData = new FormData($("#writeForm")[0]);
            $.ajax({
                url: "/cs/bugModify",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    console.log(response);
                    if(response.result){
                        alert("수정 되었습니다!");
                        $('#bugModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert("수정 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
    });
});