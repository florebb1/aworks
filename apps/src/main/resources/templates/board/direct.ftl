<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">

<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "direct.text1"/></h1>
    <div><@spring.message "direct.text2"/></div>
</section>

<section class="place-wrap">
    <div class="container">
        <div class="row">
            <div class="col-12 mb-3">

                <form id="directFrom">
                    <input type="hidden" id="recipient-user" name="recipient-user">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">
                                <input type="hidden" id="recipient-user" name="recipient-user">
                                <label for="recipient-name" class="col-form-label"><@spring.message "direct.text3"/></label>
                                <input type="text" class="form-control" id="recipient-name" name="recipient-name">
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label"><@spring.message "direct.text4"/></label>
                                <textarea class="form-control" rows="6" id="message-text" name="message-text"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="message-text" class="col-form-label"><@spring.message "direct.text5"/></label>
                                <div class="file-zone">
                                    <div class="form-row ">
                                        <div class="col-11">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input bugFile" id="bugFile0" name="bugFile" required>
                                                <label class="custom-file-label" for="bugFile0"><@spring.message "direct.text6"/></label>
                                                <div class="invalid-feedback">Example invalid custom file feedback</div>
                                            </div>
                                        </div>
                                        <div class="col-1">
                                            <button type="button" class="btn btn-secondary file-add" >+</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-2">
                                    <@spring.message "direct.text7"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="p-3 text-center">
                        <button type="button" id="cencel" class="btn btn-secondary"><@spring.message "direct.text8"/></button>
                        <button type="button" id="send" class="btn btn-info"><@spring.message "direct.text9"/></button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</section>

<#--<#include "/layout/modal.ftl">-->
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<#--<script type="text/javascript" src="/assets/js/market/view.js">-->
<script>
    $(document).ready(function () {
        // 파일 업로드 라벨 hide
        // $(document).on('change', '.custom-file-input', function (event) {
        //     $(this).next('.custom-file-label').html(event.target.files[0].name);
        // });


        //등록버튼 이벤트
        $("#send").click(function() {
            $('#recipient-user').val(${s_user.s_seq?number});
            var title = $('#recipient-name').val();
            var contant = $('#message-text').val();
            if(title == null || title == "") {
                alert("제목을 입력해주세요.");
                return false
            }else if(contant == null || contant == "") {
                alert("내용을 입력해주세요");
                return false
            }
            var totalSize = 0;
            var maxSize  = 20971520;
            $(".bugFile").each(function(i){
                totalSize += document.getElementById("bugFile"+i).files[0].size
            });
            if(totalSize > maxSize){
                alert("첨부파일은 총 20MB를 초과할수 없습니다.");
                return false;
            }
            // var datas = $("#directFrom").serialize();
            var formData = new FormData($("#directFrom")[0]);
            $.ajax({
                url: "/board/onetoone",
                type: 'POST',
                data: formData,
                dataType: 'JSON',
                processData : false,
                contentType : false,
                success: function (response) {
                    if(response.result == true) {
                        alert("등록 처리 되었습니다.");
                        location.href = "/board/direct"
                    }else {
                        alert("등록중 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
                    }
                }
            })
        });

        $(".file-add").click(function(){
            if($(".custom-file").length > 4){
                alert("첨부파일은 최대 5개까지 가능합니다.");
                return false;
            }
            var html = '<div class="form-row pt-1">\
                        <div class="col-11">\
                        <div class="custom-file">\
                        <input type="file" class="custom-file-input bugFile" id="bugFile'+$(".custom-file").length+'" name="bugFile" required>\
                    <label class="custom-file-label" for="bugFile'+$(".custom-file").length+'">파일을 첨부해 주세요.</label>\
                    <div class="invalid-feedback">Example invalid custom file feedback</div>\
                    </div>\
                    </div>\
                    <div class="col-1">\
                        <button type="button" class="btn btn-secondary file-del pl-1 pr-1" style="width:31px"> - </button>\
                    </div>\
                    </div>';
            $(".file-zone").append(html);
        });

        $("body").on("click",".file-del",function(){
            $(this).parent().prev().parent().remove();
            $(this).parent().remove();
        });

        $("#cencel").click(function() {
            var answer = confirm("취소 하시면 입력된 내용이 초기화 됩니다. 취소하시겠습니까?");
            if (answer) {
                history.back();
            }
        });
    });
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">