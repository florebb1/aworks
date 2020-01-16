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
        console.log(111111111);

        if($("#title").val() == null || $("#title").val() == "") {
            $("#titleChkText").text("* 1:1문의 제목을 입력해주세요.");
            $("#titleChkText").css("display", "block");
            return false;
        }

        console.log(222222222);

        // var summerNoteValue = $("#contentNote").summernote('code');
        // if(summerNoteValue == '<p><br></p>' || summerNoteValue == '<p><br></p><p><br></p>'
        //     || summerNoteValue == "" || summerNoteValue == '&nbsp;') {
        //     $("#contentChkText").text("* 1:1 문의 내용을 입력해주세요.");
        //     $("#contentChkText").css("display", "block");
        //     return false;
        // } else {
        //     // 서머노트 에디터 값 적용
        //     $("#content").val(summerNoteValue);
        // }

        if ($('#answerContentNote').summernote('isEmpty'))
        {
            $("#answerContentChkText").text("* 답변 내용을 입력해주세요.");
            $("#answerContentChkText").css("display", "block");
            return false;
        }

        var summerNoteValue = $("#answerContentNote").summernote('code');

        // 서머노트 에디터 값 적용
        $("#answerContent").val(summerNoteValue);


        var totalSize = 0;
        var maxSize  = 15000000;
        var fileType = true;
        $(".directFile").each(function(i){
            // console.log(1);
            // console.log(document.getElementById("directFile"+i).files[0]);
            if(document.getElementById("directFile_"+i) !== undefined && document.getElementById("directFile_"+i) !== null) {
                if (document.getElementById("directFile_" + i).files[0] !== undefined && document.getElementById("directFile_" + i).files[0] !== null) {
                    if (document.getElementById("directFile_" + i).files[0].type == "image/jpeg" || document.getElementById("directFile_" + i).files[0].type == "image/png" || document.getElementById("directFile_" + i).files[0].type == "image/gif") {

                        totalSize += document.getElementById("directFile_" + i).files[0].size
                    } else {
                        fileType = false;
                    }
                } else {
                    // $('[type="file"]').attr("disabled", "disabled");
                    // $("#file_" + i).attr("disabled", "disabled");
                }
            }

        });
        if(!fileType){
            alert("첨부파일은 jpg, png, gif만 가능합니다.");
            return false;
        }
        if(totalSize > maxSize){
            alert('<@spring.message "onetoone.text12"/>');
            return false;
        }

        // 체크 메시지 초기화
        $(".text-danger").text("");
        if(confirm("1:1 문의를 수정 하시겠습니까?")) {
            var formData = new FormData($("#editForm")[0]);
            console.log(formData);
            $.ajax({
                url: "/cs/onetooneModify",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    console.log(response);
                    if(response.result){
                        alert("수정 되었습니다!");
                        $('#onetooneModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert("수정 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                        $('[type="file"]').removeAttr("disabled");
                    }
                },
                error: function(error){
                    console.log(error);
                }
            });
        }else{
            $('[type="file"]').removeAttr("disabled");
        }
    });
});