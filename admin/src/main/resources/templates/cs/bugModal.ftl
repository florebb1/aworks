<style>
    .text-danger {
        display: none;
    }
</style>

<div class="modal-body pa-0">
    <form id="writeForm" action="/cs/onetooneSave" method="post" enctype="multipart/form-data">
        <input type="hidden" name="seq" id="seq" value="<#if bug??>${bug.seq?c}</#if>">
        <input type="hidden" name="content" id="content" value="">
        <div id="contentMain" class="input-display p-5">

                <div class="form-row mb-3">
                    <div class="col">
                        <span class="mr-3">작성자 - <#if bug?? && bug.comName??>${bug.comName}</#if> <#if bug?? && bug.userName??>${bug.userName}<#else>Unknown</#if></span>
                    </div>
                    <div class="col text-right">
                        버그신고 시간 - <#if bug??>${bug.createDatetime?string["yyyy년 MM월dd일 HH:mm"]}</#if>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">버그신고 제목</div>
                    </div>
                    <div class="col-12">
                        <input type="text" class="form-control input-form" name="title" id="title" placeholder=""
                                value="<#if bug??>${bug.title}</#if>">
                        <div class="text-info-mih" >
                            <small id="titleChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">버그신고 내용</div>
                    </div>
                    <div class="col-12">
                        <textarea name="content" id="content" style="display: none;"></textarea>
                        <div id="contentNote"></div>
                        <div class="text-info-mih" >
                            <small id="contentChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">버그신고 첨부파일</div>
                    </div>
                    <div class="col-12">
                        <div class="custom-file">
                            <div id="bugFileArea"></div>
                        </div>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">답변 내용 작성하기</div>
                    </div>
                    <div class="col-12">
                        <textarea name="answerContent" id="answerContent" style="display: none;"></textarea>
                        <div id="answerContentNote"></div>
                        <div class="text-info-mih" >
                            <small id="answerContentChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">답변 첨부파일</div>
                        <div>
                            <div class="custom-file" id="fileAdd">
                                <div id="fileArea0" class="form-row fileclass">
                                    <div class="col-6">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" name="file" id="file_1" value="" >
                                            <label id="file_1Label" class="custom-file-label" for="file_1">파일을 첨부해 주세요.</label>
                                        </div>
                                    </div>
                                    <div class="form-group col-1">
                                        <button type="button" class="input-form btn btn-light" id="file-plus">+</button>
                                    </div>
                                </div>

                            </div>
                            <div class="custom-file" style="margin-top:10px">
                                <div class="text-info-mih form-row">
                                    <div class="col-auto">
                                        <i class="icon-info"></i>
                                    </div>
                                    <div class="col-10">
                                        <span>파일 업로드 최대 사이즈는 15MB 입니다.</span>
                                    </div>
                                    <div class="col-12">
                                        <small id="fileChkText" class="form-text text-danger"></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</div>

<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save"><#if bug??>수 정<#else>등록</#if></button>
</div>

<script src="/assets/js/page/cs/bugModal.js"></script>
<script>
    // 첨부파일 개수
    var userFile = 0;
    var answerFile = 0;
    <#if userFileList??>
        userFile = ${userFileList?size} + 1;
        <#else>
        userFile = 2;
    </#if>
    <#if answerFileList??>
        console.log("첨부파일 사이즈 = "+${answerFileList?size});
        <#if answerFileList?size = 0>
            answerFile = 2;
            console.log("첨부파일 사이즈가 0일 때 : "+answerFile);
            <#else>
            answerFile = ${answerFileList?size} + 1;
            console.log("첨부파일 사이즈가 0보다 클 때 : "+answerFile);
        </#if>
        <#else>
        answerFile = 2;
        console.log("첨부파일을 찾을 수 없을 때 : "+answerFile);
    </#if>

    $(document).ready(function () {

        <#if onetoone??>
            $("#bugModalCenterTitle").text("버그신고 수정");
            <#else>
            $("#bugModalCenterTitle").text("버그신고 등록");
        </#if>

        $('#contentNote').summernote({
            placeholder: '버그신고 내용을 입력해주세요.',
            height: 150,
            focus: false,
            lang: 'ko-KR',
            dialogsInBody: true,
            tooltip: false
        });

        $('#answerContentNote').summernote({
            placeholder: '답변 내용을 입력해주세요.',
            height: 150,
            focus: false,
            lang: 'ko-KR',
            dialogsInBody: true,
            tooltip: false
        });

        <#if bug?? && bug.content??>
            var content = '${bug.content?js_string}';
            $("#contentNote").summernote('code', content);
        </#if>

        <#if bug?? && bug.answerContent??>
            var answerContent = '${bug.answerContent?js_string}';
            $("#answerContentNote").summernote('code', answerContent);
        </#if>

        <#if userFileList??>
            var listSize = ${userFileList?size};
            var html = '';
            if(listSize > 0) {
                <#list userFileList as row>
                var index = "${row_index+1}";
                var fileSeq = "${row.seq?c}";
                var filePath = "${row.fileName}";
                var fileName = "${row.originalFileName!}";
                html =
                    '<div id="col-class-'+index+'" class="col-10">\n' +
                        '<div id="custom-col-'+index+'" class="custom-file">\n '+
                            '<input type="text" class="form-control" name="userfile" id="userFile_'+index+'" value="'+fileName+'" readonly>\n' +
                            '<button type="button" class="btn btn-primary btn-block" onclick="noticeFileDown(\''+filePath+'\', \''+fileSeq+'\')">다운로드</button>' +
                        '</div>'+
                    '</div>';
                $("#bugFileArea").append(html);
                </#list>
            } else {
                html =
                    '<div id="col-class-0" class="col-10">\n' +
                        '<div id="custom-col-0" class="custom-file">\n '+
                            '<input type="text" class="form-control" name="userfile" id="userFile_0" value="첨부파일이 없습니다." readonly>\n' +
                        '</div>'+
                    '</div>';
                $("#bugFileArea").append(html);
            }
        </#if>

        <#if answerFileList??>
            var fileListSize = ${answerFileList?size};
            if(fileListSize > 0) {
                $("#fileAdd").empty();
                var html = "";
                <#list answerFileList as row>
                var index = ${row_index};
                //console.log("첨부파일 인덱스 : "+index);
                var fileName = '${row.originalFileName}';
                html += '<div id="fileArea'+index+'" class="form-row fileclass">\
                            <div class="col-6">\
                                <div class="custom-file">\
                                    <input type="file" class="custom-file-input" name="file" id="file_'+index+'" value="" >\
                                    <label id="file_'+index+'Label" class="custom-file-label" for="file_'+index+'">파일을 첨부해 주세요.</label>\
                                </div>\
                            </div>\
                            <div class="form-group col-1">';
                if(index == 0){
                    html += '<button type="button" class="input-form btn btn-light" id="file-plus">+</button>';
                }else{
                    html += '<button type="button" class="input-form btn btn-light" id="minusBtn_'+index+'" onclick="fnFileMinus('+index+')">-</button>'
                }

                html += '</div>\
                            <div class="form-group col-4">\
                                <div id="file_del_${row.seq?c}">'+fileName+' <i class="icon-delete file-delete" data-seq="${row.seq?c}"></i></div>\
                            </div>\
                       </div>';
                <#--var html =  '<div id="col-class-'+index+'" class="col-10">\-->
                                <#--<div id="custom-col-'+index+'" class="custom-file">\-->
                                    <#--<input type="file" class="custom-file-input" name="file" id="file_'+index+'" value="" >\-->
                                    <#--<label id="file_'+index+'Label" class="custom-file-label" for="file_'+index+'">파일을 첨부해 주세요.</label>\-->
                                <#--</div>\-->
                            <#--</div>\-->
                            <#--<#if row_index+1 = 1>-->
                <#--<div id="custom-btn" class="form-group col-2">\-->
                    <#--<button type="button" class="input-form" id="file-plus">+</button>\-->
                <#--</div>\-->
                <#--<#else>-->
                <#--<div id="custom-btn-'+index+'" class="form-group col-2">\-->
                    <#--<button type="button" id="minusBtn_'+index+'" class="input-form" onclick="fnFileMinus('+index+')">-</button>\-->
                <#--</div>\-->
                <#--</#if>-->
                <#--<div id="file_del_'+${row.seq}+'">'+fileName+' <i class="icon-delete file-delete" data-seq="${row.seq!}"></i></div>';-->

                </#list>
                $("#fileAdd").html(html);
            }
        </#if>

        $("#file-plus").on("click", function () {
            var fileLength = $(".fileclass").length;
            if(fileLength > 4) {
                $("#fileChkText").text("* 첨부파일은 최대 5개만 등록 할 수 있습니다.");
                $("#fileChkText").css("display", "block");
            } else {
                // var html =  "<div id='col-class-"+fileSeq+"' class='col-10'>"+
                //                 "<div id='custom-col-"+fileSeq+"' class='custom-file'> "+
                //                     "<input type='file' class='custom-file-input' name='file' id='file_"+fileSeq+"' value='' >\n" +
                //                     "<label id='file_"+fileSeq+"Label' class='custom-file-label' for='file_"+fileSeq+"'>파일을 첨부해 주세요.</label>\n" +
                //                 "</div>"+
                //             "</div>"+
                //             "<div id='custom-btn-"+fileSeq+"' class='form-group col-2'>"+
                //                 "<button type='button' id='minusBtn_"+fileSeq+"' class='input-form btn btn-light' onclick='fnFileMinus("+fileSeq+")'>-</button>"+
                //             "</div>";
                html = '<div id="fileArea'+fileLength+'" class="form-row fileclass">\
                            <div class="col-6">\
                                <div class="custom-file">\
                                    <input type="file" class="custom-file-input" name="file" id="file_'+fileLength+'" value="" >\
                                    <label id="file_'+fileLength+'Label" class="custom-file-label" for="file_'+fileLength+'">파일을 첨부해 주세요.</label>\
                                </div>\
                            </div>\
                            <div class="form-group col-2">\
                                <button type="button" class="input-form btn btn-light" id="minusBtn_'+fileLength+'" onclick="fnFileMinus('+fileLength+')">-</button>\
                            </div>\
                       </div>';
                // fileSeq++;
                $("#fileAdd").append(html);
            }
        });

        $('body').on('change', '.custom-file-input', function () {
            var thisId = $(this).attr("id");
            var inputFiles = this.files;
            var fileName = inputFiles[0].name;
            $("#"+thisId+"Label").text(fileName);
        });

        $('body').on('click', '.file-delete', function(){
            var seq = $(this).data("seq");
            console.log(seq);
            if(confirm("선택한 첨부파일을 삭제하시겠습니까?")) {
                $.ajax({
                    url: "/cs/noticeFileDelete",
                    type: 'POST',
                    dataType: 'JSON',
                    data: { seq : seq },
                    success: function (response) {
                        if(response.result){
                            alert("삭제 되었습니다.");
                            $("#file_del_"+seq).remove();
                            // location.reload();
                        }else{
                            alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                        }
                    }
                });
            }
        });
    });

    function fnFileMinus(seq) {
        $(".text-danger").text("");
        $("#fileArea"+seq).remove();
    }

    // PDF , jpg, jpeg, gif, png, zip
    // 문서 및 기타 확장자 파일은 zip 형태로 압축하여 업로드 해주세요.

    function userFileDown(filePath, fileSeq) {
        console.log(filePath + " , " + fileSeq);
        window.open('/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq, '_blank');
    }
</script>