<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<#--<div class="page-title-section">-->
<#--    <div class="container">-->
<#--        <div class="row">-->
<#--            <div class="col text-center">-->
<#--                <h1 class="main-title-h1">정보수정</h1>-->
<#--                <h2 class="main-title-h2">나의 정보를 수정할 수 있습니다.</h2>-->
<#--            </div>-->
<#--        </div>-->
<#--    </div>-->
<#--</div>-->

<div class="sub-title-bg background-base-code background-h4">
    정보수정
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>정보수정</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>정보수정</h5>
            </div>
        </div>
        <hr class="mt-1 mb-5">
    </div>
</section>
<section class="place-wrap-top-none">  -->
<section class="place-wrap">
    <div class="container">
        <div class="row">
            <div class="col">

                <div class="row justify-content-center">
                    <div class="col-12 mb-3">

                        <form id="profileForm">
                            <input type="hidden" name="profileImg" id="profileImgUpdate">
                            <div class="card">
                                <div class="card-body p-5">


                                    <div class="row">
                                        <div class="col-3 offset-1 justify-content-center" style="position:relative">
                                            <#if user.profileImg?exists && user.profileImg != ''>
                                                <div id="userImg" class="profile-modify-img">
                                                    <img src="${user.profileImg}" style="width:140px;height:140px">
                                                </div>
                                                <button class="close mr-2 profileDel" data-seq="${user.seq?c}" style="position:absolute;top:0;right:65px" type="button">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            <#else>
                                                <div id="userImg" class="profile-modify-img">
                                                    <img src="/assets/images/profile-sample.png" style="width:140px;height:140px">
                                                </div>
                                                <button class="close mr-2 profileDel" style="display:none;position:absolute;top:0;right:65px" data-seq="${user.seq?c}" type="button">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </#if>
                                            <input type="file" id="profileImgFile" style="display:none">
                                            <div class="text-center mt-2">프로필 이미지 <br>(gif, jpg, png 파일만 가능)</div>

                                        </div>
                                        <div class="col-7">

                                            <div class="form-row mb-3">
                                                <div class="col-3 d-flex justify-content-end align-items-center" style="position:relative;">
                                                    <span class="mr-3">이메일</span><span style="position:absolute;right:10px;top:10px;color:#ff0000;">*</span>
                                                </div>
                                                <div class="col-7">
                                                    <input type="text" class="form-control" id="profileId" name="profileId" aria-describedby="profileEmail" value="${user.loginId!}" readonly>
                                                </div>
                                            </div>
                                            <div class="form-row mb-3">
                                                <div class="col-3 d-flex justify-content-end align-items-center" style="position:relative;">
                                                    <span class="mr-3">비밀번호</span><span style="position:absolute;right:10px;top:10px;color:#ff0000;">*</span>
                                                </div>
                                                <div class="col">
                                                    <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#change-pw-md">비밀번호 변경</button>
                                                </div>
                                            </div>
                                            <div class="form-row mb-3">
                                                <div class="col-3 d-flex justify-content-end align-items-center">
                                                    <span class="mr-3">이름</span>
                                                </div>
                                                <div class="col-7">
                                                    <input type="text" class="form-control" id="profileName" name="profileName" value="${user.name!}" maxlength="10">
                                                </div>
                                            </div>
                                            <div class="form-row mb-3">
                                                <div class="col-3 d-flex justify-content-end align-items-center">
                                                    <span class="mr-3">연락처</span>
                                                </div>
                                                <div class="col-7">
                                                    <input type="text" class="form-control" id="profileContact" name="profileContact" value="${user.phone!}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="11">
                                                </div>
                                            </div>
                                            <div class="form-row mb-3">
                                                <div class="col-3 d-flex justify-content-end align-items-center">
                                                    <span class="mr-3">회사명</span>
                                                </div>
                                                <div class="col-7">
                                                    <input type="text" class="form-control" id="profileCompany" name="profileCompany" value="${user.comName!}" maxlength="20">
                                                </div>
                                            </div>
                                            <div class="form-row mb-3">
                                                <div class="col-3 d-flex justify-content-end align-items-center">
                                                    <span class="mr-3">직급</span>
                                                </div>
                                                <div class="col-7">
                                                    <input type="text" class="form-control" id="profilePosition" name="profilePosition" value="${user.position!}" maxlength="10">
                                                </div>
                                            </div>

                                        </div>
                                    </div>


                                </div>
                            </div>
                            <div class="p-3 text-center">
                                <button type="button" id="profileBtn" class="btn btn-info">확 인</button>
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>


    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script type="text/javascript" src="/assets/js/mypage/userModify.js"></script>
<script>
    $(function(){
        $(".profile-modify-img").click(function(){
            $("#profileImgFile").trigger("click");
        })

        $("#profileImgFile").change(function(){
            var inputFiles = this.files;

            if(inputFiles == undefined || inputFiles.length == 0) return;

            if(inputFiles.size > 2097152){
                alert("첨부된 이미지 파일의 용량이 2MB를 초과하였습니다.");
                return;
            } else {
                var file = inputFiles[0];
                console.log(file);

                // Upload the File
                var fileName = file.name;
                var ext = file.name.split(".");
                ext = ext[ext.length-1].toLowerCase();

                // console.log(ext);
                if(ext != "jpg" && ext != "png" &&  ext != "jpeg" && ext != "gif"){
                    alert("이미지 파일은 (jpg, png, gif) 형식만 등록 가능합니다.");
                    return false;
                }

                // 섬네일 생성
                var reader = new FileReader();
                reader.onload = function (event) {
                    // $(".profile-modify-img").css("background-image",event.target.result);
                    // $(".profile-modify-img").css({"background":"url("+event.target.result+")"});
                    $(".profile-modify-img img").attr("src",event.target.result);
                    $(".profileDel").show();
                    $("#profileImgUpdate").val(event.target.result);
                    // $("#imageView").append(html);
                    // imgArr.push(event.target.result);
                    // index++;
                };
                reader.readAsDataURL(inputFiles[0]);
            }

        })

        $(".profileDel").click(function(){
            if(confirm("프로필 이미지를 삭제 하시겠습니까?")){
                if($("#profileImgUpdate").val() == "") {
                    // 삭제로직
                    $.ajax({
                        url: "/mypage/profileDelete",
                        type: 'POST',
                        dataType: 'JSON',
                        data: "seq=${user.seq?c}",
                        success: function (response) {
                            console.log(response);
                            if (response.result) {
                                // $(".profile-modify-img").css({"background": "url(/assets/images/profile-sample.png)"});
                                $(".profile-modify-img img").attr("src","/assets/images/profile-sample.png");
                                $(".profileDel").hide();
                                $("#profileImgUpdate").val("");
                            } else {
                                alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                            }
                        }
                    });
                }else{
                    $(".profile-modify-img img").attr("src","/assets/images/profile-sample.png");
                    $(".profileDel").hide();
                    $("#profileImgUpdate").val("");
                }
            }
        })
    })
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">