<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<#import "../pagination.ftl" as pagination />

<#--<div class="page-title-section">-->
<#--    <div class="container">-->
<#--        <div class="row">-->
<#--            <div class="col text-center">-->
<#--                <h1 class="main-title-h1">1:1 문의 내역</h1>-->
<#--                <h2 class="main-title-h2">나의 1:1문의 내역을 확인할 수 있습니다.</h2>-->
<#--            </div>-->
<#--        </div>-->
<#--    </div>-->
<#--</div>-->

<div class="sub-title-bg background-base-code background-h4">
    1:1 문의 내역
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>1:1 문의 내역</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>1:1 문의 내역</h5>
            </div>
        </div>
        <hr class="mt-1 mb-5">
    </div>
</section>  -->

<section class="place-wrap-top-none mt-5">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card contact-area minheight-calc"  id="qnaList">

                </div>
                <nav id="paging" class="d-flex justify-content-center">

                </nav>
            </div>
        </div>
    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<script src="/assets/js/jquery.filedownload.min.js"></script>
<!-- custom script 위치 -->
<script>
    $(function(){
        getList(0,true);
        $("body").on("click",".fileDown",function(e){
            e.stopPropagation();
            var filePath = $(this).data("filepath");
            var seq = $(this).data("seq");
            // $.fileDownload('/mypage/fileDownload?fileUrl='+filePath+'&seq='+seq);
            document.location.href='/mypage/fileDownload?fileUrl='+filePath+"&seq="+seq;
        })
    })

    function getList(num,refresh){
        var datas = $("#searchForm").serialize()+"&page="+num;
        $.ajax({
            url: "/mypage/ajax_qna",
            type: 'GET',
            dataType: 'JSON',
            data: "page="+num,
            success: function (response) {
                console.log(response);

                var html = "";
                for(var i =0 ; i< response.list.length;i++){
                    var qna = response.list[i];
                    // if(qna.qnaType == 1) {
                        html += '<a class="contact-area-in collapsed" data-toggle="collapse" data-target="#collapse' + i + '" aria-expanded="false" aria-controls="collapse' + i + '">\
                            <div class="row">\
                            <div class="col-1 d-flex justify-content-center align-items-center">';
                        if (qna.answerYn == 0) {
                            html += '<div class="contact-label">미처리</div>';
                        } else {
                            html += '<div class="contact-label-active">완료</div>';
                        }
                        html += '</div>\
                            <div class="col-10">\
                            <h5 class="font-w700">' + qna.title + '</h5>\
                            <div class="mb-3">' + nl2br(qna.content) + '</div>\
                            <div class="name-area">\
                            <span></span>\
                            <span>' + moment(qna.createDatetime).format("YYYY-MM-DD") + '</span>\
                            </div>';
                        if (qna.bbsFilesQ.length > 0) {

                            html += '<div class="attachment">첨부파일 : ';
                            for (var j = 0; j < qna.bbsFilesQ.length; j++) {
                                html += ' <i class="icon-save-disk fileDown" data-filepath="' + qna.bbsFilesQ[j].fileName + '" data-seq="' + qna.bbsFilesQ[j].seq + '" alt="'+qna.bbsFilesQ[j].fileName+'" title="'+qna.bbsFilesQ[j].fileName+'"></i>';
                            }
                            html += '</div>';
                        }
                        html += '</div>\
                            <div class="col-1 d-flex justify-content-center align-items-center">';
                        if (qna.answerYn > 0) {
                            html += '<i class="icon-down-arrow font32 span-gray-color"></i>';
                        }
                        html += '</div>\
                            </div>\
                        </a>';
                        if (qna.answerYn > 0) {
                            html += '<div id="collapse' + i + '" class="collapse" aria-labelledby="heading' + i + '" data-parent="">\
                            <div class="collapse-re-wrap">\
                            <div class="mb-3">' + qna.answerContent + '</div>\
                            <div class="name-area">\
                            <span>관리자</span>\
                            <span>l</span>\
                            <span>' + moment(qna.updateDatetime).format("YYYY-MM-DD") + '</span>\
                            </div>';
                            if (qna.bbsFilesA.length > 0) {

                                html += '<div class="attachment">첨부파일 : ';
                                for (var j = 0; j < qna.bbsFilesA.length; j++) {
                                    html += ' <i class="icon-save-disk fileDown" data-filepath="' + qna.bbsFilesA[j].fileName + '" data-seq="' + qna.bbsFilesA[j].seq + '" alt="'+qna.bbsFilesA[j].fileName+'" title="'+qna.bbsFilesA[j].fileName+'"></i>';
                                }
                                html += '</div>';
                            }
                            html += '</div>\
                            </div>';
                        }
                    // }

                }

                if(html == ""){
                    html += '<div class="text-center pt-5">\n' +
                        '                            등록된 1:1문의가 없습니다.\n' +
                        '                        </div>';
                }
                $("#qnaList").html(html);
                // $(".tooltipMsg").tooltip();
                if(refresh) {
                    if(response.total > 0) {
                        $('#paging').bootpag({
                            total: Math.ceil(response.total / 5),
                            page: 1,
                            maxVisible: 5,
                            firstLastUse: true,
                            first: '<<',
                            last: '>>',
                            next: '>',
                            prev: '<'
                        }).on("page", function (event, num) {
                            getList(num - 1, false);

                        });
                    }
                }
            }
        });
    }
    function nl2br(str){
        return str.replace(/\n/g, "<br />");
    }

</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">