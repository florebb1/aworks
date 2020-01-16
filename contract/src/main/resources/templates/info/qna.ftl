<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<div class="sub-title-bg background-base-code background-h4">
    <@spring.message "onetoone.text1"/>
</div>

<section class="place-wrap">
    <div class="container">
        <div class="row">
            <div class="col">

                <form id="directFrom" method="post" enctype="multipart/form-data">

                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">

                                <label for="">분류</label>
                                <select name="qnaType" id="qnaType" class="form-control">
                                    <option value="1">교육문의</option>
                                    <option value="2">기술문의</option>
                                    <option value="3">제안 및 사업문의</option>
                                    <option value="4">기타문의</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="hidden" id="userId" name="userId" value="${s_user.s_seq?c}">
                                <label for=""><@spring.message "onetoone.text3"/></label>
                                <input type="text" class="form-control border-radius-none" id="title" name="title" aria-describedby="" placeholder="<@spring.message "onetoone.text4"/>" maxlength="200">
                            </div>
                            <div class="form-group">
                                <label for=""><@spring.message "onetoone.text5"/></label>
                                <textarea class="form-control border-radius-none" id="content" name="content" rows="10" placeholder="<@spring.message "onetoone.text6"/>" maxlength="4000"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label"><@spring.message "onetoone.text7"/></label>
                                <div class="file-zone">
                                    <div class="form-row ">
                                        <div class="col">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input directFile" id="directFile0" name="directFile" required>
                                                <label class="custom-file-label" for="directFile0"><@spring.message "onetoone.text8"/></label>
                                                <div class="invalid-feedback">Example invalid custom file feedback</div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <button type="button" class="btn btn-secondary file-add" >+</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-2">
                                    <@spring.message "onetoone.text9"/>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="p-3 text-center">
                        <button type="button" id="cencel" class="btn btn-secondary border-radius-none"><@spring.message "onetoone.text10"/></button>
                        <button type="button" id="send" class="btn btn-info border-radius-none"><@spring.message "onetoone.text11"/></button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
$(document).ready(function () {
    //등록버튼 이벤트
    $("#send").click(function() {
        var title = $('#title').val();
        var contant = $('#content').val();

        if(title === null || title == "") {
            alert('<@spring.message "onetoone.text4"/>');
            return false
        }else if(contant === null || contant == "") {
            alert('<@spring.message "onetoone.text6"/>');
            return false
        }
        var totalSize = 0;
        var maxSize  = 20971520;
        var fileType = true;
        $(".directFile").each(function(i){
            // console.log(1);
            // console.log(document.getElementById("directFile"+i).files[0]);
            if(document.getElementById("directFile"+i) !== undefined && document.getElementById("directFile"+i) !== null) {
                if (document.getElementById("directFile" + i).files[0] !== undefined && document.getElementById("directFile" + i).files[0] !== null) {
                    if (document.getElementById("directFile" + i).files[0].type == "image/jpeg" || document.getElementById("directFile" + i).files[0].type == "image/png" || document.getElementById("directFile" + i).files[0].type == "image/gif") {
                        console.log(document.getElementById("directFile" + i).files[0].size);
                        totalSize += document.getElementById("directFile" + i).files[0].size
                    } else {
                        fileType = false;
                    }
                } else {
                    $("#directFile" + i).attr("disabled", "disabled");
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
        if(confirm("1:1 문의를 등록 하시겠습니까?")) {
            var formData = new FormData($("#directFrom")[0]);
            $.ajax({
                url: "/api/qna",
                type: 'POST',
                data: formData,
                dataType: 'JSON',
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.result == true) {
                        alert('<@spring.message "onetoone.text13"/>');
                        $("#directFrom")[0].reset();
                        location.href = "/mypage/qna_list"
                    } else {
                        alert('<@spring.message "onetoone.text14"/>');
                    }
                }
            })
        }else{
            $(".directFile").each(function(i){
                $("#directFile" + i).removeAttr("disabled");
            })
        }
        // var datas = $("#directFrom").serialize();
        // $.ajax({
        //     url: "/api/qna",
        //     type: 'POST',
        //     data: datas,
        //     dataType: 'JSON',
        //         success: function (response) {
        //             if(response.result == true) {
        //                 alert("등록 처리 되었습니다.");
        //                 location.href = "/qna"
        //             }else {
        //                 alert("등록중 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
        //             }
        //         }
        // });
    });

    $("#cencel").click(function() {
        var answer = confirm("취소 하시면 입력된 내용이 초기화 됩니다. 취소하시겠습니까?");
        if (answer) {
            history.back();
        }
    });

    $(".file-add").click(function(){
        if($(".custom-file").length > 4){
            alert('<@spring.message "onetoone.text15"/>');
            return false;
        }
        var filetext = '<@spring.message "onetoone.text8"/>'
        var html = '<div class="form-row pt-1">\
                        <div class="col">\
                        <div class="custom-file">\
                        <input type="file" class="custom-file-input directFile" id="directFile'+$(".custom-file").length+'" name="directFile" required>\
                    <label class="custom-file-label" for="directFile'+$(".custom-file").length+'">'+filetext+'</label>\
                    <div class="invalid-feedback">Example invalid custom file feedback</div>\
                    </div>\
                    </div>\
                    <div class="col-auto">\
                        <button type="button" class="btn btn-secondary file-del pl-1 pr-1" style="width:31px"> - </button>\
                    </div>\
                    </div>';
        $(".file-zone").append(html);
    });

    $("body").on("click",".file-del",function(){
        $(this).parent().prev().parent().remove();
        $(this).parent().remove();
    });
});
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">