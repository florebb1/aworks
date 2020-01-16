<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">
<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "market.text26"/></h1>
    <div><@spring.message "market.text27"/></div>
</section>
<input type="hidden" id="reviewPage" value="0">
<input type="hidden" id="QAPage" value="0">
<#if result.downloadCnt??>
    <input type="hidden" id="downCtn" value="${result.downloadCnt?number}">
<#else>
    <input type="hidden" id="downCtn" value="0">
</#if>
<section class="place-wrap">
    <div class="container">

        <div class="row">
            <div class="col-9">
                <div class="detail-card">
                    <#if result.appType?? && result.appType?number = 0>
                        <h5 class="main-color mb-3"><@spring.message "market.text11"/></h5>
                    <#elseif result.appType?? && result.appType?number = 1>
                        <h5 class="main-color mb-3"><@spring.message "market.text12"/></h5>
                    <#elseif result.appType?? && result.appType?number = 2>
                        <h5 class="main-color mb-3"><@spring.message "market.text13"/></h5>
                    <#elseif result.appType?? && result.appType?number = 3>
                        <h5 class="main-color mb-3"><@spring.message "market.text14"/></h5>
                    </#if>
                    <#if result.appName??>
                        <h2 class="font-w700">${result.appName}</h2>
                    </#if>
                    <hr class="mt-4 mb-4">
                    <h4 class="font-w700 mb-3"><@spring.message "market.text28"/></h4>
                    <#if result.description??>
                        <p>${result.description}</p>
                    <#else>
                        <p><@spring.message "market.text29"/></p>
                    </#if>
                    <hr class="mt-4 mb-4">
                    <h4 class="font-w700 mb-3"><@spring.message "market.text30"/></h4>
                    <div>
                    <#if result.movieFileUrl?? || media?size gt 0>
                        <#if result.movieFileUrl??>
                            <#--<iframe width="100%" height="532" style="border:0;" src="${result.movieFileUrl} frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </#if>
                        <#list media as row>
                            <img width="100%" src="${row.mediaValue}">
                        </#list>
                    <#else>
                        <p><@spring.message "market.text31"/></p>
                    </#if>
                    </div>
                </div>


                <ul class="nav nav-tabs mt-5" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link font-w700 active" id="home-a" data-toggle="tab" href="#hha" role="tab" aria-controls="hha" aria-selected="true"><@spring.message "market.text32"/></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link font-w700" id="profile-b" data-toggle="tab" href="#hhb" role="tab" aria-controls="hhb" aria-selected="false"><@spring.message "market.text33"/></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link font-w700" id="contact-c" data-toggle="tab" href="#hhc" role="tab" aria-controls="hhc" aria-selected="false"><@spring.message "market.text34"/></a>
                    </li>
                </ul>
                <div class="tab-content tab-content-wrap" id="myTabContent">
                    <#if result.benefit??>
                        <div class="tab-pane fade tab1 show active" id="benefit" role="tabpanel" aria-labelledby="home-a">${result.benefit}</div>
                    <#else>
                        <div class="tab-pane fade tab1 show active" id="benefit" role="tabpanel" aria-labelledby="home-a">
                            <div class="minh-150 d-flex flex-column justify-content-center align-items-center">
                                <span class="no-content-box mb-3">
                                    <i class="icon-dots-horizontal-double font36"></i>
                                </span>
                                <span class="no-content-text"><@spring.message "market.text35"/></span>
                            </div>
                        </div>
                    </#if>
                    <#if result.appDependencies??>
                        <div class="tab-pane fade tab1" id="appDependencies" role="tabpanel" aria-labelledby="profile-a">${result.appDependencies}</div>
                    <#else>
                        <div class="tab-pane fade tab1" id="appDependencies" role="tabpanel" aria-labelledby="profile-a">
                            <div class="minh-150 d-flex flex-column justify-content-center align-items-center">
                                <span class="no-content-box mb-3">
                                    <i class="icon-dots-horizontal-double font36"></i>
                                </span>
                                <span class="no-content-text"><@spring.message "market.text35"/></span>
                            </div>
                        </div>
                    </#if>
                    <#if result.component??>
                        <div class="tab-pane fade tab1" id="component" role="tabpanel" aria-labelledby="contact-a">${result.component}</div>
                    <#else>
                        <div class="tab-pane fade tab1" id="component" role="tabpanel" aria-labelledby="contact-a">
                            <div class="minh-150 d-flex flex-column justify-content-center align-items-center">
                                <span class="no-content-box mb-3">
                                    <i class="icon-dots-horizontal-double font36"></i>
                                </span>
                                <span class="no-content-text"><@spring.message "market.text35"/></span>
                            </div>
                        </div>
                    </#if>
                </div>

            </div>
            <div class="col-3">
                <div class="detail-card-affix" id="sidebar">
                    <div class="detail-card">
                        <div class="form-row">
                            <div class="col-auto right-menu-title mr-2">
                                <p><@spring.message "market.text36"/></p>
                                <#if result.lastUpdate??>
                                    <p><@spring.message "market.text37"/></p>
                                </#if>
                                <p><@spring.message "market.text38"/></p>
                                <p><@spring.message "market.text39"/></p>
                                <p><@spring.message "market.text40"/></p>
                                <p><@spring.message "market.text41"/></p>
                                <#if result.tags??>
                                    <p><@spring.message "market.text42"/></p>
                                </#if>
                            </div>
                            <div class="col right-menu-content">
                                <p>${result.createDatetime?string["YYYY-MM-dd"]}</p>
                                <#if result.lastUpdate??>
                                    <p>${result.lastUpdate?string["YYYY-MM-dd"]}</p>
                                </#if>
                                <#if result.viewCnt??>
                                    <p>${result.viewCnt?number}</p>
                                <#else>
                                    <p>0</p>
                                </#if>
                                <#if result.version??>
                                    <p>${result.version}</p>
                                </#if>
                                <#if result.downloadCnt??>
                                    <p>${result.downloadCnt?number}</p>
                                <#else>
                                    <p id="downCnt">0</p>
                                </#if>
                                <#if result.viewCnt??>
                                    <p>${result.viewCnt?number}</p>
                                <#else>
                                    <p>0</p>
                                </#if>
                                <#if result.tags??>
                                    <p id="tags"></p>
                                </#if>
                            </div>
                        </div>
                        <hr>
                        <div class="row mt-3">
                            <div class="col">
                                <#if result.manualFileUrl??>
                                    <button type="button" class="btn btn-info btn-block btn-manauldown" >
                                        <i class="icon-manual font11 mr-1"></i><@spring.message "market.text43"/>
                                    </button>
                                <#else>
                                    <a href="void(0);" class="btn btn-info btn-block" onclick="alert('메뉴얼 자료가 존재하지 않습니다.');return false;">
                                        <i class="icon-manual font11 mr-1"></i><@spring.message "market.text43"/>
                                    </a>
                                </#if>
<#--                                <#if result.appFileUrl??>-->
<#--                                    <button id="appDown" href="/api/appDownload?fileUrl=${result.appFileUrl}" class="btn btn-info btn-block" target="_blank">-->
                                    <button type="button" id="appDown" class="btn btn-info btn-block">
                                        <i class="icon-download font12 mr-1"></i><@spring.message "market.text44"/>
                                    </button>
<#--                                <#else>-->
<#--                                    <button type="button" id="appDown" class="btn btn-info btn-block">-->
<#--                                        <i class="icon-download font12 mr-1"></i>다운로드-->
<#--                                    </button>-->
<#--                                </#if>-->
                                <#if s_user.s_seq?c?number = 0>
                                    <a href="void(0);" class="btn btn-outline-info btn-block" onclick="$('#login-md').modal('show');return false;">
                                        <i class="icon-bug font12 mr-1"></i><@spring.message "market.text45"/>
                                    </a>
                                <#else>
                                    <a href="#" data-toggle="modal" data-target="#bug-declaration" class="btn btn-outline-info btn-block">
                                        <i class="icon-bug font12 mr-1"></i><@spring.message "market.text45"/>
                                    </a>
                                </#if>
                            </div>
                        </div>
                        <hr>
                        <div class="row mt-3">
                            <div class="col pt-3 pb-3">
                                <button type="button" id="likeBtn" class="btn btn-outline-secondary btn-block btn-like">
                                    <#if like?number gt 0>
                                        <i id="likeIcon" class="icon-Thumbsup span-thumup-color font12 mr-1"></i><@spring.message "market.text46"/>
                                    <#else>
                                        <i id="likeIcon" class="icon-Thumbsup font12 mr-1"></i><@spring.message "market.text46"/>
                                    </#if>
                                    <#if result.likeCnt??>
                                        (<span id="likeNum">${result.likeCnt?number}</span>)
                                    <#else>
                                        (<span id="likeNum">0</span>)
                                    </#if>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<script src="/assets/js/jquery.filedownload.min.js"></script>
<!-- custom script 위치 -->
<script>
$(document).ready(function(){
    // 첨부파일 라벨링 적용
    // $(document).on('change', '.custom-file-input', function (event) {
    //     $(this).next('.custom-file-label').html(event.target.files[0].name);
    // });
    $(".btn-manauldown").click(function(){
        console.log(1);
        $.fileDownload("${result.manualFileUrl}");
    })
    <#if result.tags??>
        var res = "";
        var tags = "${result.tags}";
        var arr = tags.split(",");
        for(var i=0; i < arr.length; i++) {
            res = "#"+arr[i]+"&nbsp;";
            $('#tags').append(res);
        }
    </#if>
    var marketId = getParameter("marketId");
    //추천버튼클릭
    $('#likeBtn').click(function(){
        //비로그인시 로그인 모달 오픈
        <#if s_user.s_seq?c?number = 0>
            $('#login-md').modal('show');
            return false;
        <#else>
            $.ajax({
                url: "/market/like",
                type: 'GET',
                data: {
                    marketId: marketId,
                    loginId: ${s_user.s_seq?c}
                },
                dataType: 'JSON',
                success: function (response) {
                    if(response.result == "add" || response.result == "delete") {
                        location.reload();
                    }else {
                        alert("알 수 없는 오류가 발생하였습니다. 상태가 계속될 경우 관리자에게 문의해주세요.")
                    }
                }
            });
        </#if>
    });
    // 기대효과
    $('#home-a').click(function(){
        $('.tab1').removeClass("show");
        $('.tab1').removeClass("active");
        $('#benefit').addClass("active");
        $('#benefit').addClass("show");
    });
    // 의존성
    $('#profile-b').click(function(){
        $('.tab1').removeClass("show");
        $('.tab1').removeClass("active");
        $('#appDependencies').addClass("show");
        $('#appDependencies').addClass("active");
    });
    // 호환성
    $('#contact-c').click(function(){
        $('.tab1').removeClass("show");
        $('.tab1').removeClass("active");
        $('#component').addClass("show");
        $('#component').addClass("active");
    });
    // app 다운로드
    $('#appDown').click(function(){
        <#if s_user.s_seq?c?number = 0>
            $('#login-md').modal('show');
            return false;
        </#if>
        <#if result.appFileUrl??>
            // 앱 다운로드 경로가 존재할 경우
            $.ajax({
                url: "/api/download",
                type: 'POST',
                dataType: 'JSON',
                data: {
                    userSeq: ${s_user.s_seq?c?number?replace(",","")},
                    marketId: marketId
                },
                success: function (response) {
                    console.log(response);
                    if(response.result == true) {
                        $.fileDownload("${result.appFileUrl}");
                        <#--window.open("/api/fileDownload?fileUrl=${result.appFileUrl}");-->
                        <#--location.reload();-->
                    }else {
                        alert("앱 다운로드중 에러가 발생하였습니다. 관리자에게 문의해주세요.");
                    }
                }
            });
        <#else>
            // 앱 다운로드 경로가 없을 경우
            alert('다운로드앱이 존재하지 않습니다.');
        </#if>


    });
    // 버그신고
    $('#bugSendBtn').click(function(){
        $('#recipient-user').val(${s_user.s_seq?c?number});
        $('#recipient-market').val(getParameter("marketId"));
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
        // var datas = $("#bugForm").serialize();
        var formData = new FormData($("#bugForm")[0]);
        $.ajax({
            url: "/api/bug",
            type: 'POST',
            dataType: 'JSON',
            data: formData,
            processData : false,
            contentType : false,
            success: function (response) {
                if(response.result == true) {
                    alert("등록 처리 되었습니다.");
                    $('#bug-declaration').modal("hide");
                    location.reload();
                }else {
                    alert("등록중 오류가 발생했습니다. 다시 진행해 주시기 바랍니다.");
                }
            }
        });
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
    })

    $('#bug-declaration').on('hidden.bs.modal', function (e) {
        $('small').text("");
        $(this).find('form')[0].reset();
        $(".file-zone").empty();
        var html = '<div class="form-row pt-1">\
                        <div class="col-11">\
                        <div class="custom-file">\
                        <input type="file" class="custom-file-input bugFile" id="bugFile0" name="bugFile" required>\
                    <label class="custom-file-label" for="bugFile0">파일을 첨부해 주세요.</label>\
                    <div class="invalid-feedback">Example invalid custom file feedback</div>\
                    </div>\
                    </div>\
                    <div class="col-1">\
                        <button type="button" class="btn btn-secondary file-del pl-1 pr-1" style="width:31px"> - </button>\
                        </div>\
                    </div>';
        $(".file-zone").append(html);
    });
});
</script>
<!-- custom script 끝 -->
<script src="/assets/js/sticky/rAF.js"></script>
<script src="/assets/js/sticky/ResizeSensor.js"></script>
<script src="/assets/js/sticky/sticky-sidebar.min.js"></script>
<script type="text/javascript">
    var stickySidebar = new StickySidebar('#sidebar', {
        topSpacing: 80,
        bottomSpacing: 20,
        containerSelector: '.container',
        innerWrapperSelector: '.sidebar__inner'
    });
</script>
<#include "/layout/footer.ftl">