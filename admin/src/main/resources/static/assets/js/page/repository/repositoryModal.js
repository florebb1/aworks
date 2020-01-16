$(function(){

    $("body").on({
        keyup: function () {
            $(".text-danger").text("");
        },
        change: function () {
            $(".text-danger").text("");
        }
    });

    $(".btn-save").on("click", function(){

        if($("#appName").val() == null || $("#appName").val() == "") {
            $("#appNameChkText").text("* 콘텐츠 이름을 입력해주세요.");
            $("#appNameChkText").css("display", "block");
            $("#appName").focus();
            return false;
        }

        if($("#summary").val() == null || $("#summary").val() == "") {
            $("#summaryChkText").text("* 콘텐츠 요약을 입력해주세요.");
            $("#summaryChkText").css("display", "block");
            $("#summary").focus();
            return false;
        }

        var descriptionValue = $("#descriptionEditor").summernote('code');
        if(descriptionValue == '<p><br></p>' || descriptionValue == '<p><br></p><p><br></p>' || descriptionValue == "" || descriptionValue == '&nbsp;') {
            $("#descriptionChkText").text("* 콘텐츠 설명을 입력해주세요.");
            $("#descriptionChkText").css("display", "block");
            return false;
        } else {
            $("#description").val(descriptionValue);
        }

        if($("#appType").val() == null || $("#appType").val() == "") {
            $("#appTypeChkText").text("* 타입을 선택해주세요.");
            $("#appTypeChkText").css("display", "block");
            return false;
        }
        //
        // // 업무분류 선택 체크박스 처리
        var processTypes = [];
        $("input[name=processTypes]").each(function(){
            if($(this).is(":checked")) processTypes.push($(this).val());
        });
        $("#processType").val(processTypes.join("|"));
        if($("#processType").val() == null || $("#processType").val() == "") {
            $("#processTypeChkText").text("* 업무분류를 최소 1개 이상 선택해주세요.");
            $("#processTypeChkText").css("display", "block");
            return false;
        }
        //
        // // 기대효과 체크
        var benefitValue = $("#benefitEditor").summernote('code');
        if(benefitValue == '<p><br></p>' || benefitValue == '<p><br></p><p><br></p>'
            || benefitValue == "" || benefitValue == '&nbsp;') {
            $("#benefitChkText").text("* 기대효과를 입력해주세요.");
            $("#benefitChkText").css("display", "block");
            return false;
        } else {
            $("#benefit").val(benefitValue);
        }

        // 의존 체크
        var appDependenciesValue = $("#appDependenciesEditor").summernote('code');
        if(appDependenciesValue == '<p><br></p>' || appDependenciesValue == '<p><br></p><p><br></p>'
            || appDependenciesValue == "" || appDependenciesValue == '&nbsp;') {
            $("#appDependenciesChkText").text("* 의존을 입력해주세요.");
            $("#appDependenciesChkText").css("display", "block");
            return false;
        } else {
            $("#appDependencies").val(appDependenciesValue);
        }

        // 호환 체크
        var componentValue = $("#componentEditor").summernote('code');
        if(componentValue == '<p><br></p>' || componentValue == '<p><br></p><p><br></p>'
            || componentValue == "" || componentValue == '&nbsp;') {
            $("#componentChkText").text("* 호환을 입력해주세요.");
            $("#componentChkText").css("display", "block");
            return false;
        } else {
            $("#component").val(componentValue);
        }

        if($("#version").val() == null || $("#version").val() == "") {
            $("#versionChkText").text("* 버전 정보를 입력해주세요.");
            $("#versionChkText").css("display", "block");
            return false;
        }

        if($("#versionNote").val() == null || $("#versionNote").val() == "") {
            $("#versionNoteChkText").text("* 버전 설명을 입력해주세요.");
            $("#versionNoteChkText").css("display", "block");
            return false;
        }
        // console.log($("#tagValues").val());
        //
        // if($("#tagValues").val() != ""){
        //     var jsonarray = JSON.parse($("#tagValues").val());
        //     var tagarray = [];
        //     for(var i =0; i < jsonarray.length;i++){
        //         tagarray.push(jsonarray[i].value);
        //     }
        //     $("#tags").val(tagarray.join(","));
        // }else{
        //     $("#tags").val("");
        // }
        $("#tags").val($("#tagValues").val());
        // 체크 메시지 초기화
        $(".text-danger").text("");
        
        // 등록, 수정 메시지 적용 및 처리
        var message = "";
        if($("#seq").val() == null || $("#seq").val() == "") message = "등록";
        else message = "수정";


        if(confirm("레포지토리 정보를 "+message+"하시겠습니까?")) {
            // imgArr.forEach(function (value, index) {
            //     var a = value;
            //     a.replace(',', '@');
            //     console.log(value);
            // });
            // console.log(imgArr);
            //
            // $("#imgArrValue").val(imgArr.join("|"));
            var formData = new FormData($("#writeForm")[0]);
            $.ajax({
                url: "/repository/save",
                type: 'POST',
                dataType: 'JSON',
                data: formData,
                processData : false,
                contentType : false,
                success: function (response) {
                    console.log(response);
                    if(response.result){
                        alert(message+" 되었습니다!");
                        $('#userModal').modal("hide"); //닫기
                        location.reload();
                    }else{
                        alert(message+" 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                    }
                }
            });
        }
    });

    $(".btn-email-duple").on("click", function(){
        var button = $(this);
        var loginId = $("#loginId").val();
        if(loginId == null || loginId == "") {
            if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            $("#loginIdChkText").text("* 아이디를 정확히 입력해주세요.");
            $("#loginIdChkText").css("display", "block");
            $("#loginId").focus();
            return false;
        } else if(!emailPattern.test($("#loginId").val())) {
            if(!$("#loginIdChkText").hasClass("text-danger")) $("#loginIdChkText").addClass("text-danger");
            $("#loginIdChkText").text("* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.");
            $("#loginIdChkText").css("display", "block");
            $("#loginId").focus();
            return false;
        } else {
            var datas = {
                loginId : loginId
            };
            $.ajax({
                url: "/user/duple_email",
                type: 'POST',
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    if(response.result){
                        button.data("dupleyn", "Y");
                        $("#loginIdChkText").text("* 사용 할 수 있는 아이디 입니다.");
                        $("#loginIdChkText").removeClass("text-danger");
                        $("#loginIdChkText").css("color", "#0080FF");
                        $("#loginIdChkText").css("display", "block");
                    }else{
                        var userSeq = response.userSeq;
                        var seq = $("#seq").val();
                        if(seq != null && seq != "") {
                            if(userSeq == seq) {
                                button.data("dupleyn", "Y");
                                $("#loginIdChkText").text("* 사용 할 수 있는 아이디 입니다.");
                                $("#loginIdChkText").removeClass("text-danger");
                                $("#loginIdChkText").css("color", "#0080FF");
                                $("#loginIdChkText").css("display", "block");
                                return;
                            }
                        }
                        button.data("dupleyn", "N");
                        $("#loginIdChkText").text("* 중복된 아이디입니다.");
                        $("#loginIdChkText").css("display", "block");
                    }
                }, error: function (e) {
                    $("#loginIdChkText").text("* 중복확인 실패! 지속될 경우 사이트 관리자에게 문의해주세요.");
                    $("#loginIdChkText").css("display", "block");
                }
            });
        }
    });
});
