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
                                    <li class="breadcrumb-item active" aria-current="page">제휴문의 상세보기</li>
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

                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">이 름</div>
                                </div>
                                <div class="col-10">
                                    ${contactus.name}
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">이메일</div>
                                </div>
                                <div class="col-10">
                                    ${contactus.email}
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">회사명</div>
                                </div>
                                <div class="col-10">
                                    ${contactus.comName}
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">연락처</div>
                                </div>
                                <div class="col-10">
                                    ${contactus.comPhone}
                                    <#--  <div class="miw300">${user.loginId}</div>  -->
                                </div>
                            </div>
                            <div class="form-row mb-4">
                                <div class="col-2">
                                    <div class="miw100 text-right">내 용</div>
                                </div>
                                <div class="col-10">
                                    <#--<input type="text" class="form-control input-form mxw300" value="${repository.description}" readonly>-->
                                    <div id="contentNote"> ${contactus.content?html?replace("\n", "<br>")} </div>
                                </div>
                            </div>



                        </div>
                    </form>
                </div>
                <div class="text-center">
                    <button class="btn btn-info" type="button" onclick="document.location.href='/cs/contactus'">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>


<#include "/layout/base_script.ftl">
<script type="text/javascript">
    $(document).ready(function () {
        <#if notice?? && notice.content??>
        <#--$("#contentNote").summernote('code', '${notice.content}');-->
        <#--$("#contentNote").summernote('disable');-->
        </#if>

        // $('#contentNote').summernote({
        //     placeholder: '공지 내용을 입력해주세요.',
        //     height: 150,
        //     focus: false,
        //     lang: 'ko-KR'
        // });

        <#if bbsFiles??>
        <#list bbsFiles as row>
        var index = "${row_index+1}";
        var fileSeq = "${row.seq?c}";
        var filePath = "${row.fileName}";
        var fileName = "${row.originalFileName}";
        var html =
            '<div id="col-class-'+index+'" class="col-10">\n' +
            '<div id="custom-col-'+index+'" class="custom-file"  style="cursor:pointer">\n '+
            '<a href="javascript:noticeFileDown(\''+filePath+'\', \''+fileSeq+'\')">'+fileName +'</a>'+
            '</div>'+
            '</div>';

        // "<div id='col-class-"+index+"' class='col-10'>"+
        //     "<div id='custom-col-"+index+"' class='custom-file'> "+
        //         "<input type='text' class='form-control' name='file' id='file_"+index+"' value='"+fileName+"' readonly>\n" +
        //         "<button type='button' class='btn btn-primary btn-block' onclick='noticeFileDown()'>다운로드</button>" +
        //     "</div>"+
        // "</div>";
        $("#noticeFileArea").append(html);
        </#list>
        <#else>
        $("#noticeFileArea").text("첨부파일이 없습니다.");
        </#if>
    });

    function noticeFileDown(filePath, fileSeq) {
        // console.log(filePath + " , " + fileSeq);
        $.fileDownload(filePath);
    }

</script>
<#include "/layout/footer.ftl">