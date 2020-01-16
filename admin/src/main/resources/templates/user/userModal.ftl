<style>
    .text-danger {
        display: none;
    }
</style>

<div class="modal-body pa-0">
    <form id="writeForm" action="/user/save" method="post" enctype="multipart/form-data" autocomplete="new-password">
        <input type="hidden" name="seq" id="seq" value="<#if user??>${user.seq?c}</#if>">
        <div id="contentMain" class="input-display">
            <div style="position: absolute;left:-99999999px;">

                <input type="text" id="tricId" name="tricId" placeholder="입력하세요.">

                <input type="password" id="tricPwd" name="tricPwd" placeholder="입력하세요.">

            </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>아이디 (이메일)</span>
                    </div>

                    <#if user??>
                    <div class="col-7">
                        <input type="text" class="form-control input-form" name="loginId" id="loginId" placeholder="" required=""
                                value="<#if user??>${user.loginId}</#if>" <#if user??>readonly</#if> autocomplete="off" maxlength="30">
                        <div class="text-info-mih" >
                            <small id="loginIdChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                    <#else>
                    <div class="col-7">
                        <input type="text" class="form-control input-form" name="loginId" id="loginId" placeholder="" required=""
                                value="<#if user??>${user.loginId}</#if>" <#if user??>readonly</#if> autocomplete="off" maxlength="30">
                        <div class="text-info-mih" >
                            <small id="loginIdChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                    </#if>

                    <#if user??>
                    <div class="col-2">
                    </div>
                    <#else>
                    <div class="col-2">
                        <button type="button" class="btn btn-light btn-block btn-email-duple"<#if user?? && user.loginId?exists>data-dupleyn="Y"<#else>data-dupleyn="N"</#if>>중복확인</button>
                    </div>
                    </#if>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span><#if user??><#else></#if> 비밀번호</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    8~32자의 영문+숫자+특수문자를 조합하여 입력하세요. 안전한 이용을 위하여 아이디와 다르게 설정하시기 바랍니다.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7">
                        <input type="password" class="form-control input-form" name="loginPw" id="loginPw" placeholder="" required="" autocomplete="new-password" maxlength="32">
                        <div class="text-info-mih">
                            <small id="loginPwChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span><#if user??><#else></#if> 비밀번호 확인</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    비밀번호 확인을 위하여 동일한 비밀번호를 다시 입력해 주세요.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7">
                        <input type="password" class="form-control input-form" id="loginPwAgain" placeholder="" required="" autocomplete="new-password" maxlength="32">
                        <div class="text-info-mih">
                            <small id="loginPwAgainChkText" class="form-text text-danger">* 비밀번호가 동일하지 않습니다. 동일한 비밀번호를 입력해 주세요.</small>
                        </div>
                    </div>
                </div>

                <hr>
                
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>프로필 이미지</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    프로필 이미지 파일은 jpg, png, gif형식의 파일을 업로드해 주세요. 파일 업로드 최대 사이즈는 2M입니다.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" name="profileImgFile" id="validatedCustomFile" required
                                    value="<#if user??>${user.profileImg!}</#if>" data-width="200" data-height="200" style="display:none">
                            <label id="fileLabel" class="custom-file-label" for="validatedCustomFile">이미지 파일을 첨부해 주세요</label>
                        </div>
                        <div class="text-info-mih">
                            <small id="imageChkText" class="form-text text-danger"></small>
                        </div>
                        <#if user??>
                            <#if user.profileImg?exists && user.profileImg != ''>
                                <div id="imageView" class="profile-img-boxview">
                                    <img id="imagePreview" class="view-user-img" src="${user.profileImg!}" alt="">
                                    <span class="icon-delete-span profileDelete" data-seq="<#if user??>${user.seq?c}</#if>">
                                        <i class="icon-cancel"></i>
                                    </span>
                                </div>
                            <#else>
                                <#--<div id="imageView" style="position:relative;width:120px">-->
                                    <#--<img id="imagePreview" class="view-user-img" src="/assets/images/user.png" alt="">-->
                                    <#--<i class="icon-delete" style="position:absolute;right:0px;top:0px"></i>-->
                                <#--</div>-->
                            </#if>
                        </#if>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>이 름</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    a.Works에서 사용할 이름을 입력해 주세요.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7">
                        <input type="text" class="form-control input-form" name="name" id="name" placeholder="" required=""
                                value="<#if user??>${user.name!}</#if>" maxlength="10">
                        <div class="text-info-mih">
                            <small id="nameChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>연락처</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    연락처를 ‘-’를 제외한 나머지 번호만 입력해 주세요. 예) '01012345678' or '+821012345678'
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7">
                        <input type="text" class="form-control input-form" placeholder="" required="" name="phone" id="phone"
                                value="<#if user??>${user.phone!}</#if>" maxlength="15">
                        <div class="text-info-mih">
                            <small id="phoneChkText" class="form-text text-danger">* 특수문자는 사용 할 수 없습니다. 숫자또는 '+'만 허용됩니다.</small>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>회사명</span>
                    </div>
                    <div class="col-7">
                        <input type="text" class="form-control" placeholder="" required="" name="comName" id="comName"
                                value="<#if user??>${user.comName!}</#if>" maxlength="20">
                        <div class="text-info-mih">
                            <small id="" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>직급</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    예) 사원, 과장 / 팀장, 파트장
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7">
                        <input type="text" class="form-control" placeholder="" required="" name="position" id="position"
                                value="<#if user??>${user.position!}</#if>" maxlength="10">
                        <div class="text-info-mih">
                            <small id="" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
                <#--<div class="form-row">-->
                    <#--<div class="col-2 text-right">-->
                        <#--<div class="miw100 text-right">레 벨</div>-->
                    <#--</div>-->
                    <#--<div class="col-3">-->
                        <#--<select class="custom-select mxw200" id="level" name="level">-->
                            <#--<option value="" selected>레벨을 선택해 주세요.</option>-->
                            <#--<option value="1" <#if user?? && user.level = 1>selected</#if>>Trial User</option>-->
                            <#--<option value="2" <#if user?? && user.level = 2>selected</#if>>User</option>-->
                            <#--<option value="3" <#if user?? && user.level = 3>selected</#if>>Contract Admin User</option>-->
                        <#--</select>-->
                        <#--<div class="text-info-mih">-->
                            <#--<small id="levelChkText" class="form-text text-danger"></small>-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<div class="col-5 d-flex align-items-center">-->
                        <#--<div class="d-flex flex-row align-items-center bd-highlight text-info-padding"></div>-->
                    <#--</div>-->
                <#--</div>-->
                <#if user??>
                    <#--<div class="form-row justify-content-center mb-3">-->
                        <#--<div class="col-2 text-right">-->
                            <#--<div class="miw100 text-right">등록일</div>-->
                        <#--</div>-->
                        <#--<div class="col-3">-->
                            <#--<input type="text" class="form-control" placeholder="" required="" name="createDatetimeStr" id="createDatetimeStr"  value="${user.createDatetime?string["yyyy년 MM월 dd일 HH시mm분"]}" readonly>-->
                        <#--</div>-->
                    <#--</div>-->
                </#if>

        </div>
    </form>
</div>
<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save"><#if user??>수 정<#else>등록</#if></button>
</div>

<script src="/assets/js/page/user/userModal.js"></script>
<script>
    $(document).ready(function () {
        <#if user??>
            $("#userModalCenterTitle").text("사용자 정보 수정");
            $("#userModalCenterTitle").append('<span class="sub-title pl-3">사용자의 정보를 수정 할 수 있습니다.</span>')
            <#else>
            $("#userModalCenterTitle").text("사용자 정보 등록");
            $("#userModalCenterTitle").append('<span class="sub-title pl-3">사용자의 정보를 등록 할 수 있습니다.</span>')
        </#if>

        $(".profileDelete").click(function(){
            var seq = $(this).data("seq");
            console.log(seq);
            if(confirm("프로필 이미지를 삭제 하시겠습니까?")){
                $.ajax({
                    url: "/user/profileDelete",
                    type: 'POST',
                    dataType: 'JSON',
                    data: "seq="+seq,
                    success: function (response) {
                        if(response.result){
                            alert("삭제되었습니다.");
                            $("#imageView").remove();
                        }else{
                            alert("삭제중 오류가 발생했습니다");
                            return false;
                        }
                    }
                });
            }
        })

        <#--<#if user?? && user.profileImg??>-->
            <#--$("#imageView").css("display", "block");-->
            <#--var imagePath = '${user.profileImg}';-->
            <#--$("#imagePreview").attr('src', imagePath);-->
            <#--$("#fileLabel").text(imagePath);-->
            <#--$('#imagePreview').css("width", "200");-->
            <#--$('#imagePreview').css("height", "200");-->
        <#--</#if>-->

        $("#validatedCustomFile").on("change", function(){
            // alert(1)
            var inputFiles = this.files;
            if(inputFiles == undefined || inputFiles.length == 0) return;
            for(var i =0; i < inputFiles.length; i++){
                if(inputFiles[i].size > 2097152){
                    alert("첨부된 이미지 파일의 용량이 2MB를 초과하였습니다.");
                    $("#validatedCustomFile").val("");
                    $("#fileLabel").text("이미지 파일을 첨부해 주세요");
                    return false;
                } else {
                    var file = inputFiles[i];

                    // Upload the File
                    var fileName = file.name;
                    console.log("fileName : "+fileName);
                    var ext = file.name.split(".");
                    ext = ext[ext.length-1].toLowerCase();

                    // console.log(ext);
                    if(ext != "jpg" && ext != "png" &&  ext != "jpeg" && ext != "gif"){
                        alert("이미지 파일은 (jpg, png, gif) 형식만 등록 가능합니다.");
                        $("#validatedCustomFile").val("");
                        $("#fileLabel").text("이미지 파일을 첨부해 주세요");
                        return false;
                    }

                    // $("#fileLabel").text(fileName);
                }
            }
        });
    });

    function guid() {
        function s4() {
            return ((1 + Math.random()) * 0x10000 | 0).toString(16).substring(1);
        }
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#imageView").css("display", "block");
                var fileValue = $("#validatedCustomFile").val().split("\\");
                var fileName = fileValue[fileValue.length -1];
                $("#fileLabel").text(fileName);
                $('#imagePreview').attr('src', e.target.result);
                $('#imagePreview').css("width", "200");
                $('#imagePreview').css("height", "200");
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>