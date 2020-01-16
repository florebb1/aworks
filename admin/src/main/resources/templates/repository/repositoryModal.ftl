<style>
    .text-danger {
        display: none;
    }
    .pointer {
        cursor: pointer;
    }

    .img-item {
        display:inline-block;
        position:relative;
        padding-right:10px
    }

    .img-close {
        cursor:pointer;
        position:absolute;
        top:3px;
        right:13px;
        color:#fff
    }
</style>

<div class="modal-body pa-0">
    <form id="writeForm" action="/repository/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="seq" id="seq" value="<#if repository??>${repository.seq?c}</#if>">
        <div id="contentMain" class="input-display">

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">콘텐츠 정보</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>콘텐츠 이름</span>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control input-form" name="appName" id="appName" placeholder=""
                            value="<#if repository??>${repository.appName}</#if>">
                    <div class="text-info-mih" >
                        <small id="appNameChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>콘텐츠 요약</span>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control input-form" name="summary" id="summary" placeholder=""
                            value="<#if repository??>${repository.summary}</#if>">
                    <div class="text-info-mih" >
                        <small id="summaryChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>콘텐츠 설명</span>
                </div>
                <div class="col-9 editor-wrap">
                    <input type="hidden" id="description" name="description" value="">
                    <div id="descriptionEditor"></div>
                    <div class="text-info-mih" >
                        <small id="descriptionChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>인증유무</span>
                </div>
                <div class="col-9 editor-wrap">
                    <input type="hidden" name="security" id="security" value="<#if repository??>${repository.security!0}<#else>0</#if>">
                    <input type="checkbox" class="form-check-label pointer input-form" name="securitycheck" id="securitycheck" value="1" <#if repository??><#if repository.security?number = 1>checked</#if></#if>>
                    <label for="securitycheck" class="pointer">인증앱 체크</label>
                    <div class="text-info-mih" >
                        <small id="descriptionChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">타입 / 분류</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>타입 선택</span>
                </div>
                <div class="col-9">
                    <select class="form-control custom-select" id="appType" name="appType">
                        <option value="" selected>선택해 주세요.</option>
                        <option value="0" <#if repository?? && repository.appType = 0>selected</#if>>Process</option>
                        <option value="1" <#if repository?? && repository.appType = 1>selected</#if>>Task</option>
                        <#--<option value="2" <#if repository?? && repository.appType = 2>selected</#if>>Event Item</option>-->
                        <#--<option value="3" <#if repository?? && repository.appType = 3>selected</#if>>Connector</option>-->
                    </select>
                    <div class="text-info-mih">
                        <small id="appTypeChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>업무분류 선택</span>
                </div>
                <div class="col-9">
                    <div class="">
                        <input type="hidden" name="processType" id="processType" value="">
                        <input type="checkbox" class="form-check-label pointer input-form" name="processTypes" id="processType_0" value="0">
                        <label for="processType_0" class="pointer">Finance & Accounting</label>
                        <input type="checkbox" class="form-check-label pointer ml-3 input-form" name="processTypes" id="processType_1" value="1">
                        <label for="processType_1" class="pointer">HR</label>
                        <input type="checkbox" class="form-check-label pointer ml-3 input-form" name="processTypes" id="processType_2" value="2">
                        <label for="processType_2" class="pointer">Sales</label>
                        <input type="checkbox" class="form-check-label pointer ml-3 input-form" name="processTypes" id="processType_3" value="3">
                        <label for="processType_3" class="pointer">Others</label>
                        <div class="text-info-mih" >
                            <small id="processTypeChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>태그 (#)</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                #Tag 는 최대 20개 까지 추가 할 수 있습니다.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <div class="">
                        <input type="text" class="input-form tag-input-form hasMaxTags" name="tagValues" id="tagValues" value="">
                        <input type="hidden" name="tags" id="tags">
                        <div class="text-info-mih" >
                            <small id="tagChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                </div>
            </div>

            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">콘텐츠 추가 정보</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>기대 효과</span>
                </div>
                <div class="col-9 editor-wrap">
                    <input type="hidden" id="benefit" name="benefit" value="">
                    <div id="benefitEditor"></div>
                    <div class="text-info-mih" >
                        <small id="benefitChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>의 존</span>
                </div>
                <div class="col-9 editor-wrap">
                    <input type="hidden" id="appDependencies" name="appDependencies" value="">
                    <div id="appDependenciesEditor"></div>
                    <div class="text-info-mih" >
                        <small id="appDependenciesChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>호 환</span>
                </div>
                <div class="col-9 editor-wrap">
                    <input type="hidden" id="component" name="component" value="">
                    <div id="componentEditor"></div>
                    <div class="text-info-mih" >
                        <small id="componentChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">콘텐츠 메뉴얼</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>메뉴얼</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                파일 업로드 최대 사이즈는 15MB 입니다.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" name="manual" id="manual" value="" required >
                        <label id="manualLabel" class="custom-file-label" for="manual">메뉴얼 파일을 첨부해 주세요.</label>
                        <#if repository??><a href="javascript:fileDownload('${repository.manualFileUrl!''}')">${repository.manualFileUrl!''}</a> <#if repository.manualFileUrl != ''><i class="icon-delete img-delete redcolor" data-seq="${repository.seq?c}" data-dtype="0"></i></#if></#if>
                    </div>
                    <div class="text-info-mih">
                        <small id="manualChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">콘텐츠 미디어</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>영상 추가(App 실행 영상)</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                YouTube 또는 Vimeo에 업로드된 영상 URL을 넣어주세요. 예) https://youtu.be/****** or https://vimeo.com/********
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control miw300 input-form" name="movieFileUrl" id="movieFileUrl"
                            value="<#if repository??>${repository.movieFileUrl!}</#if>">
                    <div class="text-info-mih" >
                        <small id="appPlayUrlChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>이미지 추가(App Screen)</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                이미지는 jpg, png 형태의 파일이 허용되며 1개당 2MB를 넘을 수 없습니다.
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-9">
                    <div class="custom-file">
                        <#--<input type="hidden" id="imgArrValue" name="imgArrValue" value="">-->
                        <input type="file" class="custom-file-input" name="appScreenImg" id="appScreenImg" value="" multiple>
                        <label id="appScreenLabel" class="custom-file-label" for="appScreenImg">이미지 파일을 첨부해 주세요.</label>
                        <div class="text-info-mih">
                            <small id="appScreenChkText" class="form-text text-danger"></small>
                        </div>
                    </div>
                    <ul id="imageView" class="repository-img-body">
                        <#if medias??>
                            <#list medias as media>
                                <#if media.mediaValue != ''>
                                <li class="img-item repository-img-body-li">
                                    <img src="${media.mediaValue}" class="thumb-img" style="width:120px;height:120px;">
                                    <span class="img-close img-real" data-seq="${media.seq?c}">
                                        <i class="icon-close"></i>
                                    </span>
                                </li>
                                </#if>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>

            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">콘텐츠 버전 / 라이선스</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>버전 정보 입력</span>
                </div>
                <div class="col-9">
                    <input type="text" class="form-control miw300 input-form" name="version" id="version"
                            value="<#if repository??>${repository.version}</#if>">
                    <div class="text-info-mih" >
                        <small id="versionChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>버전 설명</span>
                </div>
                <div class="col">
                    <textarea class="form-control input-form" name="versionNote" id="versionNote"><#if repository??>${repository.versionNote}</#if></textarea>
                    <div class="text-info-mih" >
                        <small id="versionNoteChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>라이선스 정보 등록</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                콘텐츠 라이선스 정보를 추가합니다. 파일 업로드 최대 사이즈는 15MB 입니다.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" name="licenseFile" id="licenseFile" value="" >
                        <label id="licenseFileLabel" class="custom-file-label" for="licenseFile">파일을 첨부해 주세요.</label>
                        <#if repository??><a href="javascript:fileDownload('${repository.licenseFileUrl!''}')">${repository.licenseFileUrl!''}</a> <#if repository.licenseFileUrl != ''><i class="icon-delete img-delete redcolor" data-seq="${repository.seq?c}" data-dtype="1"></i></#if></#if>
                    </div>
                    <div class="text-info-mih">
                        <small id="licenseFileChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>

            <hr>

            <div class="form-row">
                <div class="col-12">
                    <h6 class="modalin-title">콘텐츠 파일</h6>
                </div>
            </div>

            <div class="form-row">
                <div class="col-3 main-form-title">
                    <span>콘텐츠 첨부파일 (App)</span>
                    <div class="tooltip-dropdown">
                        <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                        <div class="tooltip-dropdown-content">
                            <div>
                                파일 업로드 최대 사이즈는 15MB 입니다.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" name="appFile" id="appFile" value="" >
                        <label id="licenseFileLabel" class="custom-file-label" for="licenseFile">파일을 첨부해 주세요.</label>
                        <#if repository??><a href="javascript:fileDownload('${repository.appFileUrl!''}')">${repository.appFileUrl!''}</a> <#if repository.appFileUrl != ''><i class="icon-delete img-delete redcolor" data-seq="${repository.seq?c}" data-dtype="2"></i></#if></#if>
                    </div>
                    <div class="text-info-mih">
                        <small id="licenseFileChkText" class="form-text text-danger"></small>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save"><#if repository??>수 정<#else>등록</#if></button>
</div>
<#--<script src="/assets/js/plugins/plupload-2.3.6/js/plupload.full.min.js"></script>-->
<script src="/assets/js/page/repository/repositoryModal.js"></script>
<script>

    var imgArr = [];    // appScreen 파일 저장 변수
    var index = 0;      // appScreen 파일 시퀀스

    $(document).ready(function () {
        $("#securitycheck").click(function(){
            if($(this).is(":checked")){
                $("#security").val(1);
            }else{
                $("#security").val(0);
            }
        })
        $("#appScreenImg").on("change", function(){
            if($(".img-item").length > 4){
                alert("이미지는 최대 5개까지 첨부 가능합니다.")
                return false;
            }
            var inputFiles = this.files;
            if(inputFiles.length > 5){
                alert("이미지는 최대 5개까지 첨부 가능합니다.")
                return false;
            }
            if(inputFiles == undefined || inputFiles.length == 0) return;
            for(var i =0; i < inputFiles.length; i++){
                if(inputFiles[i].size > 2097152){
                    alert("첨부된 이미지 파일의 용량이 2MB를 초과하였습니다.");
                    return;
                } else {
                    var file = inputFiles[i];
                    //console.log(file);

                    // Upload the File
                    var fileName = file.name;
                    var ext = file.name.split(".");
                    ext = ext[ext.length-1].toLowerCase();

                    // console.log(ext);
                    if(ext != "jpg" && ext != "png" &&  ext != "jpeg"){
                        alert("이미지 파일은 (jpg, png) 형식만 등록 가능합니다.");
                        return false;
                    }

                    // 섬네일 생성
                    var reader = new FileReader();
                    reader.onload = function (event) {
                        var html =
                            '<li class="img-item repository-img-body-li"><img src="'+event.target.result+'" id="thumb_'+index+'" class="thumb-img" style="width:120px;height:120px;">\n' +
                            '<span class="img-close img-virtual" id="i_thumb_'+index+'" ><i class="icon-close"></i></span>\n'
                            + '<input type="hidden" name="imgArrValue" value="'+event.target.result+'"> </li>';
                        $("#imageView").append(html);
                        // imgArr.push(event.target.result);
                        index++;
                    };
                    reader.readAsDataURL(inputFiles[i]);
                }
            }
        });

        // 등록, 수정 문구 처리
        <#if repository??>
            $("#repositoryModalCenterTitle").text("레포지토리 수정");
            <#else>
            $("#repositoryModalCenterTitle").text("레포지토리 등록");
        </#if>

        // 타입 세팅
        <#if repository?? && repository.processType??>
            var processTypes = [${repository.processType}];
            $.each(processTypes, function(index, item) {
                var processType = item;
                $("input[name=processTypes]").each(function(){
                    if($(this).val() == processType) $(this).prop("checked", true);
                });
            });
        </#if>


        // $("#tagValues").tagify({
        //     maxTagLimit: 1,
        //     maxTagLimitMsg:"야"
        // });
        $('#tagValues').tagit({
            allowSpaces: true,
            tagLimit:20,
            onTagLimitExceeded: function(){
                alert("Tag는 최대 20개까지 입력 가능합니다.")
            }
        });
        <#if repository?? && repository.tags??>

            <#--$("#tagValues").data("tagify").addTags('${repository.tags}');-->
            $("#tagValues").val('${repository.tags}');
            $("#tags").val('${repository.tags}');
        </#if>


        <#if repository?? && repository.description??>
            $("#descriptionEditor").summernote("code", "${repository.description}");
        </#if>
        $('#descriptionEditor').summernote({
            placeholder: '콘텐츠 설명을 입력해주세요.',
            tabsize: 2,
            width: '100%',
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ],
            dialogsInBody: true,
            tooltip: false
        });

        <#if repository?? && repository.benefit??>
            $("#benefitEditor").summernote("code", "${repository.benefit}");
        </#if>
        $('#benefitEditor').summernote({
            placeholder: '기대효과를 입력해주세요.',
            tabsize: 2,
            width: '100%',
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ],
            dialogsInBody: true,
            tooltip: false
        });

        <#if repository?? && repository.appDependencies??>
            $("#appDependenciesEditor").summernote("code", "${repository.appDependencies}");
        </#if>
        $('#appDependenciesEditor').summernote({
            placeholder: '의존을 입력해주세요.',
            tabsize: 2,
            width: '100%',
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ],
            dialogsInBody: true,
            tooltip: false
        });

        <#if repository?? && repository.component??>
            $("#componentEditor").summernote("code", "${repository.component}");
        </#if>
        $('#componentEditor').summernote({
            placeholder: '호환을 입력해주세요.',
            tabsize: 2,
            width: '100%',
            height: 150,
            toolbar: [
                // [groupName, [list of button]]
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
            ],
            dialogsInBody: true,
            tooltip: false
        });

        $("body").on("click",".img-virtual",function(){
            $(this).parent().remove();
        })

        $("body").on("click",".img-real",function(){
            if(confirm("이미지를 삭제 하시겠습니까?")){
                var seq = $(this).data("seq");
                var $that = $(this);
                $.ajax({
                    url: "/repository/imageDelete",
                    type: 'POST',
                    dataType: 'JSON',
                    data: "seq="+seq,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("삭제 되었습니다!");
                            $that.parent().remove();
                        }else{
                            alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                        }
                    }
                });
            }
        })

        $("body").on("click",".img-delete",function(){
            if(confirm("삭제 하시겠습니까?")){
                var seq = $(this).data("seq");
                var dType = $(this).data("dtype");
                var $that = $(this);
                $.ajax({
                    url: "/repository/fileDelete",
                    type: 'POST',
                    dataType: 'JSON',
                    data: "seq="+seq+"&dType="+dType,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("삭제 되었습니다!");
                            $that.prev().remove();
                            $that.remove();
                        }else{
                            alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                        }
                    }
                });
            }
        })
    });
    function fileDownload(filePath){
        document.location.href='/repository/fileDownload?fileUrl='+encodeURIComponent(filePath)
    }

    function imgDelete(fileSeq, base64) {
        $("#thumb_"+fileSeq).remove();
        $("#i_thumb_"+fileSeq).remove();

        // imgArr.forEach(function (value, index) {
        //    if(base64 == value) imgArr.splice(index, 1);
        // });

        var agent = navigator.userAgent.toLowerCase();
        if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
            // ie 일때 input[type=file] init.
            $("#appScreenImg").replaceWith( $("#appScreenImg").clone(true) );
        } else {
            //other bform-rowser 일때 input[type=file] init.
            $("#appScreenImg").val("");
        }
    }
</script>