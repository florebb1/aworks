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
                                        <li class="breadcrumb-item active" aria-current="page">1:1문의 상세보기</li>
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
                            <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">
                                <div class="view-wireframe ml-3 mr-3">
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">작성자</div>
                                        </div>
                                        <div class="col-10">

                                            <#if onetoone?? && onetoone.comName??>${onetoone.comName}</#if> <#if onetoone?? && onetoone.userName??>${onetoone.userName}<#else>Unknown</#if>
                                        </div>

                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">분류</div>
                                        </div>
                                        <div class="col-10">

                                            <#if onetoone.qnaType = 0>REPOSITORY<#else>INFO,CONTRACT</#if>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">문의시간</div>
                                        </div>
                                        <div class="col-10">

                                            <#if onetoone??>${onetoone.createDatetime?string["yyyy년 MM월dd일 HH:mm"]}</#if>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">1:1문의 제목</div>
                                        </div>
                                        <div class="col-10">
                                            ${onetoone.title}

                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">1:1문의 내용</div>
                                        </div>
                                        <div class="col-10">

                                            ${onetoone.content?html?replace("\n", "<br>")}
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">질문 첨부파일</div>
                                        </div>
                                        <div class="col-10">

                                            <div id="userFileArea"></div>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">답변 내용</div>
                                        </div>
                                        <div class="col-10">

                                            ${onetoone.answerContent!}
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">답변 첨부파일</div>
                                        </div>
                                        <div class="col-10">

                                            <div id="fileArea"></div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-info min-width120" type="button" onclick="document.location.href='/cs/onetoone'">목록</button>
                    </div>

                </div>
            </div>
        </div>
    </div>


<#include "/layout/base_script.ftl">
<script type="text/javascript">
    $(document).ready(function () {
        <#--<#if onetoone?? && onetoone.content??>-->
            <#--$("#contentNote").summernote('code', '${onetoone.content}');-->
            <#--$("#contentNote").summernote('disable');-->
        <#--</#if>-->

        <#--$('#contentNote').summernote({-->
            <#--placeholder: '질문 내용을 입력해주세요.',-->
            <#--height: 150,-->
            <#--focus: false,-->
            <#--lang: 'ko-KR'-->
        <#--});-->

        <#--<#if onetoone?? && onetoone.answerContent??>-->
            <#--$("#answerContentNote").summernote('code', '${onetoone.answerContent}');-->
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
                var fileSeq = "${row.seq?c}";
                var filePath = "${row.fileName}";
                var fileName = "${row.originalFileName!}";
        var html =

            '<div id="custom-col-'+index+'" class="custom-file"  style="cursor:pointer">\n '+
            '<a href="javascript:fileDown(\''+filePath+'\', \''+fileSeq+'\')">다운로드</a>'+
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
            '첨부파일이 없습니다.' +
            '</div>';
            $("#userFileArea").append(html);
            $("#fileArea").append(html);
        </#if>
    });

    function fileDown(filePath,fileSeq) {
        // console.log(filePath + " , " + fileSeq);
        // $.fileDownload('/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq);
        // window.open('/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq);
        document.location.href='/cs/userFileDownload?fileUrl='+filePath+"&seq="+fileSeq;
    }

</script>
<#include "/layout/footer.ftl">