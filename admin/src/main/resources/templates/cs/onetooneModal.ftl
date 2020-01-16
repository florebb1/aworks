<style>
    .text-danger {
        display: none;
    }
    body.modal-open {
        overflow-y: hidden;
    }
</style>

<div class="modal-body pa-0">
    <form id="editForm" action="/cs/onetooneModify" method="post" enctype="multipart/form-data"> <!-- enctype="multipart/form-data"-->
        <input type="hidden" name="seq" id="seq" value="<#if onetoone??>${onetoone.seq?c}</#if>">

        <div id="contentMain" class="input-display p-5">

                <div class="form-row mb-3">
                    <div class="col">
                        <span class="mr-3">작성자 - <#if onetoone?? && onetoone.comName??>${onetoone.comName}</#if> <#if onetoone?? && onetoone.userName??>${onetoone.userName}<#else>Unknown</#if></span>
                        <span>분류 - <#if onetoone.qnaType = 0>REPOSITORY<#else>INFO,CONTRACT</#if></span>
                    </div>
                    <div class="col text-right">
                        문의시간 - <#if onetoone??>${onetoone.createDatetime?string["yyyy년 MM월dd일 HH:mm"]}</#if>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">1:1 문의 제목</div>
                    </div>
                    <div class="col-12">
                        <input type="text" class="form-control input-form" name="title" id="title" placeholder=""
                                value="<#if onetoone??>${onetoone.title}</#if>">
                        <div class="text-info-mih" >
                            <small id="titleChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">1:1 문의 내용</div>
                    </div>
                    <div class="col-12">
                        <textarea name="content" id="content" class="form-control" rows="10" readonly>${onetoone.content}</textarea>
                        <#--<div id="contentNote"></div>-->
                        <div class="text-info-mih" >
                            <small id="contentChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row mb-3">
                    <div class="col-12">
                        <div class="mb-3">질문 첨부파일</div>
                    </div>
                    <div class="col-12">
                        <div class="custom-file">
                            <div id="otoFileArea"></div>
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
                        <div class="mb-3">답변 첨부파일 (15M 제한 및 5개 등록 가능)</div>
                        <div>
                            <div class="custom-file" id="fileAdd">
                                <div id="fileArea0" class="form-row fileclass">
                                    <div class="col-6">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input directFile" name="directFile" id="file_0" value="" >
                                            <label id="file_0Label" class="custom-file-label" for="file_0">파일을 첨부해 주세요.</label>
                                        </div>
                                    </div>
                                    <div class="form-group col-1">
                                        <button type="button" class="input-form btn btn-light" id="file-plus">+</button>
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
    <button type="button" class="btn btn-primary btn-save"><#if onetoone??>수 정<#else>등록</#if></button>
</div>

<script src="/assets/js/page/cs/onetooneModal.js"></script>
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
            $("#onetooneModalCenterTitle").text("1:1 문의 수정");
            <#else>
            $("#onetooneModalCenterTitle").text("1:1 문의 등록");
        </#if>


        $('#answerContentNote').summernote({
            placeholder: '답변 내용을 입력해주세요.',
            height: 150,
            focus: false,
            lang: 'ko-KR',
            dialogsInBody: true,
            tooltip: false
        });



        <#if onetoone?? && onetoone.answerContent??>
            var answerContent = '${onetoone.answerContent?js_string}';
            $("#answerContentNote").summernote('code', answerContent);
        </#if>

        <#if userFileList??>
            var listSize = ${userFileList?size};
            console.log(listSize);
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
                            '<div class="row" style="margin-left:-30px;margin-right:-30px">'+
                                '<div class="col-8"><input type="text" class="form-control" name="userfile" id="userFile_'+index+'" value="'+fileName+'" readonly></div>\n' +
                                '<div class="col-2"><button type="button" class="btn btn-primary btn-block" onclick="userFileDown(\''+filePath+'\', \''+fileSeq+'\')">다운로드</button></div>' +
                            '</div>'+
                        '</div>'+
                    '</div>';
                $("#otoFileArea").append(html);
                </#list>
            } else {
                html =
                    '<div id="col-class-0" class="col-10">\n' +
                        '<div id="custom-col-0" class="custom-file">\n '+
                            '<input type="text" class="form-control" name="userfile" id="userFile_0" value="첨부파일이 없습니다." readonly>\n' +
                        '</div>'+
                    '</div>';
                $("#otoFileArea").append(html);
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
                                    <input type="file" class="custom-file-input directFile" name="directFile" id="file_'+(index)+'" value="" >\
                                    <label id="file_'+(index)+'Label" class="custom-file-label" for="file_'+(index)+'">파일을 첨부해 주세요.</label>\
                                </div>\
                            </div>\
                            <div class="form-group col-1">';
                if(index == 0){
                    html += '<button type="button" class="input-form btn btn-light" id="file-plus">+</button>';
                }else{
                    html += '<button type="button" class="input-form btn btn-light" id="minusBtn_'+(index)+'" onclick="fnFileMinus('+(index)+')">-</button>'
                }

                html += '</div>\
                            <div class="form-group col-4">\
                                <div id="file_del_'+index+'">'+fileName+' <i class="icon-delete file-delete" data-seq="${row.seq?c}" data-index="'+index+'" style="cursor:pointer"></i></div>\
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
                                    <input type="file" class="custom-file-input directFile" name="directFile" id="file_'+fileLength+'" value="" >\
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
            $("#"+thisId).text(fileName);
        });

        $('body').on('click', '.file-delete', function(){
            var seq = $(this).data("seq");
            var index = $(this).data("index");
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
                            $("#file_del_"+index).remove();
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
        console.log($("#file_del_"+seq).html());
        if($("#file_del_"+seq).html() !== undefined){
            alert("등록된 첨부파일을 삭제하시기 바랍니다.");
            return false;
        }
        $("#fileArea"+seq).remove();
    }

    // PDF , jpg, jpeg, gif, png, zip
    // 문서 및 기타 확장자 파일은 zip 형태로 압축하여 업로드 해주세요.

    function userFileDown(filePath, fileSeq) {
        console.log(filePath + " , " + fileSeq);
        // window.open('/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq, '_blank');
        // $.fileDownload('/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq);
        document.location.href='/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq;
    }
</script>