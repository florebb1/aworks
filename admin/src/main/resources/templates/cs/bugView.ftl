<#include "/layout/base.ftl">

    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="breadcrumb-wrap mb-3">
                        <div class="form-row">
                            <div class="col d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">메인</a></li>
                                        <li class="breadcrumb-item"><a href="#">cs 관리</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">버그신고 상세보기</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col d-flex align-items-center justify-content-end">
                            </div>
                            <div class="col-auto">
                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="card">
                        <form id="writeForm" action="/user/save" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="seq" id="seq" value="<#if bug??>${bug.seq?c}</#if>">

                            <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">

                                <div class="form-row mb-3">
                                    <div class="col">
                                        <span class="mr-3">작성자 - <#if bug?? && bug.comName??>${bug.comName}</#if> <#if bug?? && bug.userName??>${bug.userName}<#else>Unknown</#if></span>
                                    </div>
                                    <div class="col text-right">
                                        버그신고 시간 - <#if bug??>${bug.createDatetime?string["yyyy년 MM월dd일 HH:mm"]}</#if>
                                    </div>
                                </div>

                                <div class="form-row mb-4">
                                    <div class="col-2">
                                        <div class="miw100 text-right">버그신고 제목</div>
                                    </div>
                                    <div class="col-10">
                                        ${bug.title}
                                        <#--  <div class="miw300">${user.loginId}</div>  -->
                                    </div>
                                </div>

                                <div class="form-row mb-4">
                                    <div class="col-2">
                                        <div class="miw100 text-right">버그신고 내용</div>
                                    </div>
                                    <div class="col-10">
                                        <#--<input type="text" class="form-control input-form mxw300" value="${repository.description}" readonly>-->
                                        <div id="contentNote">
                                            ${bug.content}
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row mb-4">
                                    <div class="col-2">
                                        <div class="miw100 text-right">버그신고 첨부파일</div>
                                    </div>
                                    <div class="col-8" id="userFileArea"></div>
                                </div>

                                <div class="form-row mb-4">
                                    <div class="col-2">
                                        <div class="miw100 text-right">답변 내용</div>
                                    </div>
                                    <div class="col-10">
                                        <#--<input type="text" class="form-control input-form mxw300" value="${repository.description}" readonly>-->
                                        <div id="answerContentNote">
                                            ${bug.answerContent!}
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row mb-4">
                                    <div class="col-2">
                                        <div class="miw100 text-right">답변 첨부파일</div>
                                    </div>
                                    <div class="col-8" id="fileArea"></div>
                                </div>

                            </div>
                        </form>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-info" type="button" onclick="document.location.href='/cs/bug'">목록</button>
                    </div>

                </div>
            </div>
        </div>
    </div>


<#include "/layout/base_script.ftl">
<script type="text/javascript">
    $(document).ready(function () {
        <#if bug?? && bug.content??>
            <#--$("#contentNote").summernote('code', '${bug.content}');-->
            <#--$("#contentNote").summernote('disable');-->
        </#if>

        // $('#contentNote').summernote({
        //     placeholder: '질문 내용을 입력해주세요.',
        //     height: 150,
        //     focus: false,
        //     lang: 'ko-KR'
        // });

        <#--<#if bug?? && bug.answerContent??>-->
            <#--$("#answerContentNote").summernote('code', '${bug.answerContent}');-->
            <#--$("#answerContentNote").summernote('disable');-->
        <#--</#if>-->

        <#--$('#answerContentNote').summernote({-->
            <#--placeholder: '답변 내용을 입력해주세요.',-->
            <#--height: 150,-->
            <#--focus: false,-->
            <#--lang: 'ko-KR'-->
        <#--});-->

        <#if bbsFiles??>
            var html = '';
            <#list bbsFiles as row>
                var index = "${row_index+1}";
                //console.log("첨부파일 인덱스 : "+index);
                var filePath = "${row.fileName}";
                var fileName = "${row.originalFileName!}";
        // html =
        //     '<div id="col-class-'+index+'" class="col-10">\n' +
        //     '<div id="custom-col-'+index+'" class="custom-file">\n '+
        //     '<input type="text" class="form-control" name="file" id="file_'+index+'" value="'+fileName+'" readonly>\n' +
        //     '<button type="button" class="btn btn-primary btn-block" onclick="fileDown(\''+filePath+'\')">다운로드</button>' +
        //     '</div>'+
        //     '</div>';
                var html = '<div id="custom-col-'+index+'" class="custom-file"  style="cursor:pointer">\n '+
                            '<a href="javascript:fileDown(\''+filePath+'\')">다운로드</a>'+
                        '</div>';

                var fileType = ${row.fileType};
                if(fileType == 0) {
                    $("#userFileArea").append(html);
                } else {
                    $("#fileArea").append(html);
                }
            </#list>
            if($("#userFileArea").is(':empty')) {
                html =
                    '<div id="custom-col-0" class="custom-file">\n '+
                        '첨부파일이 없습니다.' +
                '</div>';
                $("#userFileArea").append(html);
            }
            if($("#fileArea").is(':empty')) {
                html =
                        '<div id="custom-col-0" class="custom-file">\n '+
                            '첨부파일이 없습니다.' +
                    '</div>';
                $("#fileArea").append(html);
            }
            <#else>
            html =
                '<div id="custom-col-0" class="custom-file">\n '+
                    '첨부파일이 없습니다.\n' +
            '</div>';
            $("#userFileArea").append(html);
            $("#fileArea").append(html);
        </#if>
    });

    function fileDown(filePath) {
        console.log(filePath);
        // window.open('/cs/userFileDownload?fileUrl='+filePath, '_blank');
        $.fileDownload(filePath);
    }

</script>
<#include "/layout/footer.ftl">