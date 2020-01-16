<style>
    .text-danger {
        display: none;
    }
</style>

<div class="modal-body pa-0">
    <form id="writeForm" action="/partner/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="seq" id="seq" value="<#if partner??>${partner.seq?c}</#if>">

        <div id="contentMain" class="input-display">

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>로고</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    파일은 jpg, png, gif형식의 파일을 업로드해 주세요. 파일 업로드 최대 사이즈는 2M입니다.
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" name="logoImgFile" id="validatedCustomFile" required
                                   value="" data-width="200" data-height="200">
                            <label id="fileLabel" class="custom-file-label" for="validatedCustomFile">이미지 파일을 첨부해 주세요.</label>
                        </div>
                        <div class="text-info-mih">
                            <small id="logoChkText" class="form-text text-danger"></small>
                        </div>
                        <#if partner?? && partner.logo??>
                            <div id="imageView" style=" width: 120px; min-height: 120px;">
                                <img id="imagePreview" src="${partner.logo}" alt="">
                            </div>
                        </#if>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>회사명</span>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" name="name" id="name"
                               value="<#if partner?? && partner.name??>${partner.name}</#if>" placeholder="">
                        <div class="text-info-mih">
                            <small id="nameChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>대표전화</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    연락처를 '-'를 제외한 나머지 번호만 입력해주세요. 예) 01012345678
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" name="tel" id="tel"
                               value="<#if partner?? && partner.tel??>${partner.tel}</#if>" placeholder="">
                        <div class="text-info-mih">
                            <small id="telChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>주 소</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    주소를 입력해주세요.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" name="address" id="address"
                               value="<#if partner?? && partner.address??>${partner.address}</#if>" placeholder="">
                        <div class="text-info-mih">
                            <small id="addressChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>사업자번호</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    사업자 등록 번호를 '-'를 제외한 나머지 번호만 입력해주세요.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" name="businessNumber" id="businessNumber"
                               value="<#if partner?? && partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber}</#if>" placeholder="">
                        <div class="text-info-mih">
                            <small id="" class="form-text text-danger"></small>
                        </div>
                    </div>
                    <#--  <div class="col-3">
                        <input type="hidden" id="businessNumber" name="businessNumber" value="">
                        <input type="text" class="form-control input-form" name="bn1" id="bn1" maxlength="3"
                               value="<#if partner?? && partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber?substring(0,3)}</#if>" placeholder="">
                        <input type="text" class="form-control input-form" name="bn2" id="bn2" maxlength="2"
                               value="<#if partner?? && partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber?substring(4,6)}</#if>" placeholder="">
                        <input type="text" class="form-control input-form" name="bn3" id="bn3" maxlength="5"
                               value="<#if partner?? && partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber?substring(7)}</#if>" placeholder="">
                        <div class="text-info-mih">
                            <small id="businessNumberChkText" class="form-text text-danger"></small>
                        </div>
                    </div>  -->
                </div>

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>메 모</span>
                    </div>
                    <div class="col-9">
                        <textarea id="memo" name="memo" class="form-control input-form"><#if partner?? && partner.memo?? && partner.memo != "">${partner.memo}</#if></textarea>
                        <div class="text-info-mih">
                            <small id="addressChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>


        </div>
    </form>
</div>
<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save"><#if partner??>수 정<#else>등록</#if></button>
</div>

<script src="/assets/js/page/partner/partnerModal.js"></script>
<script>
    $(document).ready(function () {
        <#if partner??>
            $("#partnerModalCenterTitle").text("파트너 정보 수정");
            $("#partnerModalCenterTitle").append('<span class="sub-title pl-3">파트너의 정보를 수정 할 수 있습니다.</span>')
            <#else>
            $("#partnerModalCenterTitle").text("파트너 정보 등록");
            $("#partnerModalCenterTitle").append('<span class="sub-title pl-3">파트너의 정보를 등록 할 수 있습니다.</span>')
        </#if>

        <#if partner?? && partner.logo??>
            $("#imageView").css("display", "block");
            var url = jQuery(location).attr('protocol') + "//" + jQuery(location).attr('host');
            var imagePath = '${partner.logo}';
            //$("#imagePreview").attr('src', url + imagePath);
            $("#imagePreview").attr('src', imagePath);
            $("#fileLabel").text(imagePath.substring(9));
            $('#imagePreview').css("width", "200");
            $('#imagePreview').css("height", "200");
        </#if>

        $("#validatedCustomFile").on("change", function(){
            var inputFiles = this.files;
            if(inputFiles == undefined || inputFiles.length == 0) return;
            for(var i =0; i < inputFiles.length; i++){
                if(inputFiles[i].size > 2097152){
                    alert("첨부된 이미지 파일의 용량이 2MB를 초과하였습니다.");
                    return;
                } else {
                    var file = inputFiles[i];

                    // Upload the File
                    var fileName = file.name;
                    var ext = file.name.split(".");
                    ext = ext[ext.length-1].toLowerCase();

                    // console.log(ext);
                    if(ext != "jpg" && ext != "png" &&  ext != "jpeg"){
                        alert("이미지 파일은 (jpg, png) 형식만 등록 가능합니다.");
                        return false;
                    }
                    readURL(this);
                }
            }
        });
    });

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