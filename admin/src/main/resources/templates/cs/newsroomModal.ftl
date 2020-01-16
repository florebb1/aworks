<style>
    .text-danger {
        display: none;
    }
</style>

<div class="modal-body pa-0">
    <form id="writeForm" action="/cs/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="seq" id="seq" value="<#if newsroom??>${newsroom.seq?c}</#if>">
        <input type="hidden" name="content" id="content" value="">
        <div id="contentMain" class="input-display p-5">

            <div class="form-row mb-3">
                <div class="col-12">
                    <div class="mb-3">제 목</div>
                    <div>
                        <input type="text" class="form-control input-form" name="title" id="title" placeholder=""
                               value="<#if newsroom??>${newsroom.title}</#if>">
                        <div class="text-info-mih" >
                            <small id="titleChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row mb-3">
                <div class="col-12">
                    <div class="mb-3">간략 설명</div>
                    <div>
                        <input type="text" class="form-control input-form" name="subTitle" id="subTitle" placeholder=""
                               value="<#if newsroom??>${newsroom.subTitle}</#if>">
                        <div class="text-info-mih" >
                            <small id="subTitleChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row mb-3">
                <div class="col-12">
                    <div class="mb-3">기사 등록일</div>
                    <div>
                        <input type="text" id="viewDate" name="viewDatetimeStr" class="form-control" placeholder="날짜선택" value="<#if newsroom??><#if newsroom.viewDatetime?exists>${newsroom.viewDatetime?string["yyyy-MM-dd"]}</#if></#if>" readonly>
                        <div class="text-info-mih" >
                            <small id="viewDateChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row mb-3">
                <div class="col-12">
                    <div class="mb-3">리스트이미지</div>
                    <div>
                        <div class="custom-file" id="fileAdd">
                            <div id="fileArea0" class="form-row fileclass">
                                <div class="col-6">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" name="file" id="file_1" value="" >
                                        <label id="file_1Label" class="custom-file-label" for="file_1">파일을 첨부해 주세요.</label>
                                    </div>
                                </div>
                                <#--<div class="form-group col-1">-->
                                <#--<button type="button" class="input-form btn btn-light" id="file-plus">+</button>-->
                                <#--</div>-->
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
                        <div id="listImageView">
                            <#if newsroom??>
                                <#if newsroom.listFile?exists>
                                    <img src="${newsroom.listFile}" width="50px" height="50px">
                                </#if>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row mb-3">
                <div class="col-12">
                    <div class="mb-3">내 용</div>
                    <div>

                        <div class="contentNote"></div>
                        <div class="text-info-mih">
                            <small id="contentChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row mb-3">
                <div class="col-12">
                    <div class="mb-3">노출/미노출</div>
                    <div>
                        <input class="" type="radio" name="displayYn" id="displayYn_0" value="0" <#if newsroom??><#if newsroom.displayYn?number = 0>checked</#if><#else>checked</#if> > 노출
                        <input class="" type="radio" name="displayYn" id="displayYn_1" value="1" <#if newsroom??><#if newsroom.displayYn?number = 1>checked</#if></#if>> 미노출
                    </div>
                </div>
            </div>


        </div>
</div>
</form>
</div>

<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save"><#if notice??>수 정<#else>등록</#if></button>
</div>

<script src="/assets/js/page/cs/newsroomModal.js"></script>
<script>
    // 첨부파일 개수 세팅
    var fileSeq = 0;
    <#if bbsFiles??>
    <#if bbsFiles?size = 0>
    fileSeq = 2;
    console.log("첨부파일 사이즈가 0일 때 : "+fileSeq);
    <#else>
    fileSeq = ${bbsFiles?size} + 1;
    console.log("첨부파일 사이즈가 0보다 클 때 : "+fileSeq);
    </#if>
    <#else>
    fileSeq = 2;
    console.log("첨부파일을 찾을 수 없을 때 : "+fileSeq);
    </#if>

    $(document).ready(function () {

        <#if notice??>
        $("#noticeModalCenterTitle").text("뉴스룸 수정");
        <#else>
        $("#noticeModalCenterTitle").text("뉴스룸 등록");
        </#if>

        <#if newsroom?? && newsroom.content??>
        $(".contentNote").summernote('code', '${newsroom.content?js_string}');
        </#if>

        $('.contentNote').summernote({
            placeholder: '뉴스룸 내용을 입력해주세요.',
            height: 150,
            lang:'',
            dialogsInBody: true,
            tooltip: false
        });

        <#if bbsFiles??>
        var fileListSize = ${bbsFiles?size};
        if(fileListSize > 0) {
            $("#fileAdd").empty();
            var html = "";
            <#list bbsFiles as row>
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
                    url: "/cs/newsroomFileDelete",
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
</script>