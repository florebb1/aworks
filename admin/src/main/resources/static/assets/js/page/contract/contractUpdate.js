$(function(){
    // 계약 상태 셋팅 함수 호출
    setStatus();
    // 라이선스 타입 변경시 정책 적용
    $("body").on("change",".licenseType",function(){
        var html = '';
        $(this).parent().parent().parent().find(".atper").val("")
        $(this).parent().parent().parent().find(".stper").val("")
        $(this).parent().parent().parent().find(".wcper").val("")
        $(this).parent().parent().parent().find(".unper").val("")
        if($(this).val() == "2"){
            html += '<option value="1">Hour</option>' +
                '<option value="3">Annual</option>';
            $(this).parent().parent().parent().find(".atprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".atlistprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".atcount").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".stprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".stlistprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".stcount").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".wcprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".wclistprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".wccount").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".unprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".unlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".uncount").attr("readonly",false).val("")
        }else if($(this).val() == "1"){
            html += '<option value="3">Annual</option>';
            $(this).parent().parent().parent().find(".unprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".unlistprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".uncount").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".wcprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".wclistprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".wccount").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".atprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atcount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stcount").attr("readonly",false).val("")
        }else{
            html += '<option value="3">Annual</option>';
            $(this).parent().parent().parent().find(".unprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".unlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".uncount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atcount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stcount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".wcprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".wclistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".wccount").attr("readonly",false).val("")
        }
        console.log($(this).parent().next().next());
        $(this).parent().next().next().find("select").empty().append(html);
    });
    // 요금 변경시 정책적용
    $("body").on("change",".subscribeType",function(){
        $(this).parent().parent().parent().find(".atper").val("")
        $(this).parent().parent().parent().find(".stper").val("")
        $(this).parent().parent().parent().find(".wcper").val("")
        $(this).parent().parent().parent().find(".unper").val("")
        if($(this).val() == "1"){
            $(this).parent().parent().parent().find(".unprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".unlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".uncount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".atlistprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".atcount").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".stprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".stlistprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".stcount").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".wcprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".wclistprice").attr("readonly",true).val(0)
            $(this).parent().parent().parent().find(".wccount").attr("readonly",true).val(0)
        }else{
            $(this).parent().parent().parent().find(".unprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".unlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".uncount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".atcount").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stlistprice").attr("readonly",false).val("")
            $(this).parent().parent().parent().find(".stcount").attr("readonly",false).val("")
            if($(this).parent().parent().parent().find(".licenseType").val() == "2"){
                $(this).parent().parent().parent().find(".wcprice").attr("readonly",true).val(0)
                $(this).parent().parent().parent().find(".wclistprice").attr("readonly",true).val(0)
                $(this).parent().parent().parent().find(".wccount").attr("readonly",true).val(0)
            }else{
                $(this).parent().parent().parent().find(".wcprice").attr("readonly",false).val("")
                $(this).parent().parent().parent().find(".wclistprice").attr("readonly",false).val("")
                $(this).parent().parent().parent().find(".wccount").attr("readonly",false).val("")
            }
        }
    })

    // 라이선스 추가
    $(".licenseAdd").click(function(){
        var html = '<input type="hidden" name="seq" value=""><div class="licenseDetail card p-4">\
                        <div class="d-flex justify-content-center align-items-center mb-2">\
                            <div class="min-width120 pr-2"><div class="text-right">계약 종류</div></div>\
                            <div class="flex-grow-1">\
                                <select name="contractType" class="form-control form-control-sm">\
                                    <option value="1">Pilot</option>\
                                    <option value="2">PoC</option>\
                                    <option value="3">본사업</option>\
                                </select>\
                            </div>\
                            <div class="min-width120 pr-2"><div class="text-right">라이선스 종류</div></div>\
                            <div class="flex-grow-1">\
                                <select name="licenseType" class="form-control form-control-sm licenseType">\
                                    <option value="1">PC형</option>\
                                    <option value="2">Cloud형</option>\
                                    <option value="3">On-Premise형</option>\
                                </select>\
                            </div>\
                            <div class="min-width120 pr-2"><div class="text-right">계약과금 종류</div></div>\
                            <div class="flex-grow-1">\
                                <select name="subscribeType" class="form-control form-control-sm subscribeType">\
                                <option value="3">Annual</option>\
                                </select>\
                            </div>\
                        </div>\
                        <hr class="mb-4">\
                        <div class="d-flex justify-content-center align-items-center mb-2">\
                            <div class="min-width200 pr-2"><div class="text-right">UnAttended 납품금액</div></div>\
                            <div class="flex-grow-1"><input type="text" id="unattendedLicensePrice1" name="unattendedLicensePrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm unprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>\
                            <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>\
                            <div class="flex-grow-1"><input type="text" id="unattendedLicenseListPrice1" name="unattendedLicenseListPrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm unlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>\
                            <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>\
                            <div class="flex-grow-1"><input type="text" id="unattendedLicensePercent" readonly value="" placeholder="" class="form-control form-control-sm unper"></div>\
                            <div class="pl-2">%</div>\
                            <div class="min-width80 pr-2"><div class="text-right">수량</div></div>\
                            <div class="flex-grow-1"><input type="text" id="unAttendedCount1" name="unAttendedCount" value="0" placeholder="수량을 입력하세요" class="form-control form-control-sm uncount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>\
                        </div>\
                        <div class="d-flex justify-content-center align-items-center mb-2">\
                            <div class="min-width200 pr-2"><div class="text-right">Attended 납품금액</div></div>\
                            <div class="flex-grow-1"><input type="text" id="attendedLicensePrice1" name="attendedLicensePrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm atprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>\
                            <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>\
                            <div class="flex-grow-1"><input type="text" id="attendedLicenseListPrice1" name="attendedLicenseListPrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm atlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>\
                            <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>\
                            <div class="flex-grow-1"><input type="text" id="attendedLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm atper"></div>\
                            <div class="pl-2">%</div>\
                            <div class="min-width80 pr-2"><div class="text-right">수량</div></div>\
                            <div class="flex-grow-1"><input type="text" id="attendedCount1" name="attendedCount" value="" placeholder="수량을 입력하세요" class="form-control form-control-sm atcount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>\
                        </div>\
                        <div class="d-flex justify-content-center align-items-center mb-2">\
                            <div class="min-width200 pr-2"><div class="text-right">Studio 납품금액</div></div>\
                            <div class="flex-grow-1"><input type="text" id="studioLicensePrice1" name="studioLicensePrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm stprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>\
                            <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>\
                            <div class="flex-grow-1"><input type="text" id="studioLicenseListPrice1" name="studioLicenseListPrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm stlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>\
                            <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>\
                            <div class="flex-grow-1"><input type="text" id="studioLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm stper"></div>\
                            <div class="pl-2">%</div>\
                            <div class="min-width80 pr-2"><div class="text-right">수량</div></div>\
                            <div class="flex-grow-1"><input type="text" id="studioCount1" name="studioCount" value="" placeholder="수량을 입력하세요" class="form-control form-control-sm stcount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>\
                        </div>\
                        <div class="d-flex justify-content-center align-items-center mb-2">\
                            <div class="min-width200 pr-2"><div class="text-right">WorkCenter 납품금액</div></div>\
                            <div class="flex-grow-1"><input type="text" id="workcenterLicensePrice1" name="workcenterLicensePrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm wcprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>\
                            <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>\
                            <div class="flex-grow-1"><input type="text" id="workcenterLicenseListPrice1" name="workcenterLicenseListPrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm wclistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>\
                            <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>\
                            <div class="flex-grow-1"><input type="text" id="workcenterLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm wcper"></div>\
                            <div class="pl-2">%</div>\
                            <div class="min-width80 pr-2"><div class="text-right">수량</div></div>\
                            <div class="flex-grow-1"><input type="text" id="workcenterCount1" name="workcenterCount" value="0" placeholder="수량을 입력하세요" class="form-control form-control-sm wccount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>\
                        </div>\
                        <hr>\
                        <div class="row mt-2">\
                            <div class="col-12 text-right"><button type="button" class="btn btn-danger min-width120 licenseDel">삭제</button></div>\
                        </div>\
                    </div>';

        $("#licenseList").append(html);

    });

    // 라이선스 삭제
    $("body").on("click",".licenseDel",function(){

        $(this).parent().parent().parent().remove();
    })
    // 수정 모달창 호출시 수행 내용
    $("#modifyModal").on("shown.bs.modal", function(e){
        setStatus();
        var button = $(e.relatedTarget);
        if(button.length > 0) {
            $("#contractName").val(button.data("contractname"))
            $("#contractNumber").val(button.data("contractnumber"))
            $("#comSeq").val(button.data("comseq"))
            $("#datestart2").val(button.data("contractstart"))
            $("#dateend2").val(button.data("contractend"))
            $("#userSeq").val(button.data("userseq"))
            $("#seq").val(button.data("seq"))
            $("#searchUser").val(button.data("contractchargername"))
            $("#userName").val(button.data("contractchargername"))
            $("#contractChargerEmail").val(button.data("contractchargeremail"))
            $("#contractChargerPhone").val(button.data("contractchargerphone"))
            $("#contractIctName").val(button.data("contractictname"));

            var options = {

                url: function (phrase) {
                    return "/user/get_user";
                },

                getValue: function (element) {
                    console.log(element);
                    return element.name + "(" + element.loginId + ")";
                },
                list: {
                    onChooseEvent: function () {
                        // var selectedItemValue = $("#searchCom").getSelectedItemData().realName;
                        $("#userSeq").val($("#searchUser").getSelectedItemData().seq);
                        $("#contractChargerEmail").val($("#searchUser").getSelectedItemData().loginId);
                        $("#contractChargerPhone").val($("#searchUser").getSelectedItemData().phone);
                        $("#searchUser").val($("#searchUser").getSelectedItemData().name)
                        $("#userName").val($("#searchUser").getSelectedItemData().name)
                        // $("#inputTwo").val(selectedItemValue).trigger("change");
                    },
                    onKeyEnterEvent: function () {
                        $("#userSeq").val($("#searchUser").getSelectedItemData().seq);
                        $("#contractChargerEmail").val($("#searchUser").getSelectedItemData().loginId);
                        $("#contractChargerPhone").val($("#searchUser").getSelectedItemData().phone);
                        $("#searchUser").val($("#searchUser").getSelectedItemData().name)
                        $("#userName").val($("#searchUser").getSelectedItemData().name)
                    },
                    maxNumberOfElements: 3
                },
                ajaxSettings: {
                    dataType: "json",
                    method: "GET",
                    data: {
                        dataType: "json"
                    }
                },

                preparePostData: function (data) {
                    data.phrase = $("#searchUser").val();
                    return data;
                },

                requestDelay: 100
            };

            $("#searchUser").easyAutocomplete(options);

        }
    })

    // 계약 기본 내용 업데이트 수행
    $(".btnUpdate").click(function(){
        if($("#contractNumber").val() == ""){
            alert("계약번호를 입력해주세요");
            return false;
        }

        if($("#comSeq").val() == ""){
            alert("회사를 선택해 주세요");
            return false;
        }

        if($("#contractName").val() == ""){
            alert("계약명을 입력해 주세요");
            return false;
        }

        if($("#datestart2").val() == ""){
            alert("시작일을 입력해 주세요");
            return false;
        }

        if($("#dateend2").val() == ""){
            alert("종료일을 입력해 주세요");
            return false;
        }

        if($("#searchUser").val() == ""){
            alert("계약 담당자를 입력해 주세요");
            return false;
        }

        if($("#userName").val() != $("#searchUser").val()){
            alert("정확한 이름을 입력해주세요\n이름이 안나올 경우 '사용자 등록'메뉴에서 사용자 정보를 먼저 등록해주세요");
            return false;
        }

        if($("#contractIctName").val() == ""){
            alert("ICT 계약담당자를 입력해 주세요");
            return false;
        }

        if(confirm("계약을 수정 하시겠습니까?")){
            var datas = $("#editForm").serialize();

            $.ajax({
                url : "/contract/contract_update",
                type : 'PUT',
                data : datas,
                dataType : 'JSON',
                success:function(response){
                    if(response.result){
                        alert("계약이 수정되었습니다.");
                        document.location.href='/contract/new_list'
                    }else{
                        if(response.errorCode == "-1"){
                            alert("계약번호가 중복입니다.");
                            return false;
                        }
                    }
                }
            });
        }

    });

    // 계약 중 라이선스 내용 수정 및 추가
    $(".btn-make").click(function(){
        var validation = true
        var errorType;
        $(".licenseDetail").each(function(){
            if($(this).find(".unprice").val() == "" || $(this).find(".unlistprice").val() == "" || $(this).find(".uncount").val() == "" || $(this).find(".atprice").val() == "" || $(this).find(".atlistprice").val() == "" || $(this).find(".atcount").val() == "" || $(this).find(".stprice").val() == "" || $(this).find(".stlistprice").val() == "" || $(this).find(".stcount").val() == "" || $(this).find(".wcprice").val() == "" || $(this).find(".wclistprice").val() == "" || $(this).find(".wccount").val() == ""){
                validation = false;
                if($(this).find(".unprice").val() == ""){
                    errorType = 1;
                    return false;
                }
                if($(this).find(".unlistprice").val() == ""){
                    errorType = 2;
                    return false;
                }
                if($(this).find(".uncount").val() == ""){
                    errorType = 3;
                    return false;
                }
                if($(this).find(".atprice").val() == ""){
                    errorType = 4;
                    return false;
                }
                if($(this).find(".atlistprice").val() == ""){
                    errorType = 5;
                    return false;
                }
                if($(this).find(".atcount").val() == ""){
                    errorType = 6;
                    return false;
                }
                if($(this).find(".stprice").val() == ""){
                    errorType = 7;
                    return false;
                }
                if($(this).find(".stlistprice").val() == ""){
                    errorType = 8;
                    return false;
                }
                if($(this).find(".stcount").val() == ""){
                    errorType = 9;
                    return false;
                }
                if($(this).find(".wcprice").val() == ""){
                    errorType = 10;
                    return false;
                }
                if($(this).find(".wclistprice").val() == ""){
                    errorType = 11;
                    return false;
                }
                if($(this).find(".wccount").val() == ""){
                    errorType = 12;
                    return false;
                }
            }
        })

        if(!validation){
            if(errorType == 1){
                alert("Unattended 납품금액을 입력해주세요");
                return false;
            }
            if(errorType == 2){
                alert("Unattended ListPrice를 입력해주세요");
                return false;
            }
            if(errorType == 3){
                alert("Unattended 수량을 입력해주세요");
                return false;
            }
            if(errorType == 4){
                alert("Attended 납품금액을 입력해주세요");
                return false;
            }
            if(errorType == 5){
                alert("Attended ListPrice를 입력해주세요");
                return false;
            }
            if(errorType == 6){
                alert("Attended 수량을 입력해주세요");
                return false;
            }
            if(errorType == 7){
                alert("Studio 납품금액을 입력해주세요");
                return false;
            }
            if(errorType == 8){
                alert("Studio ListPrice를 입력해주세요");
                return false;
            }
            if(errorType == 9){
                alert("Studio 수량을 입력해주세요");
                return false;
            }
            if(errorType == 10){
                alert("WorkCenter 납품금액을 입력해주세요");
                return false;
            }
            if(errorType == 11){
                alert("WorkCenter ListPrice를 입력해주세요");
                return false;
            }
            if(errorType == 12){
                alert("WorkCenter 수량을 입력해주세요");
                return false;
            }

        }
        if(confirm("계약을 수정 하시겠습니까?")){
            var datas = $("#updateForm").serialize();

            $.ajax({
                url : "/contract/update_save",
                type : 'PUT',
                data : datas,
                dataType : 'JSON',
                success:function(response){
                    console.log(response);
                    if(response.result){
                        alert("계약이 수정되었습니다.");
                        document.location.href='/contract/new_list'

                    }
                }
            });
        }

    });

    // unattended 할인율 셋팅
    $(".unprice").each(function(){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".unlistprice");
        var price3 = $(this).parent().parent().find(".unper");
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })
    // attended 할인율 셋팅
    $(".atprice").each(function(){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".atlistprice");
        var price3 = $(this).parent().parent().find(".atper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })
    // studio 할인율 셋팅
    $(".stprice").each(function(){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".stlistprice");
        var price3 = $(this).parent().parent().find(".stper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })
    // workcenter 할인율 셋팅
    $(".wcprice").each(function(){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".wclistprice");
        var price3 = $(this).parent().parent().find(".wcper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".unprice",function(e){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".unlistprice");
        var price3 = $(this).parent().parent().find(".unper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".unlistprice",function(e){
        var price2 = $(this);
        var price1 = $(this).parent().parent().find(".unprice");
        var price3 = $(this).parent().parent().find(".unper");
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".atprice",function(e){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".atlistprice");
        var price3 = $(this).parent().parent().find(".atper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".atlistprice",function(e){
        var price2 = $(this);
        var price1 = $(this).parent().parent().find(".atprice");
        var price3 = $(this).parent().parent().find(".atper");
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".stprice",function(e){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".stlistprice");
        var price3 = $(this).parent().parent().find(".stper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".stlistprice",function(e){
        var price2 = $(this);
        var price1 = $(this).parent().parent().find(".stprice");
        var price3 = $(this).parent().parent().find(".stper");
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".wcprice",function(e){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".wclistprice");
        var price3 = $(this).parent().parent().find(".wcper");
        console.log(price2);
        console.log(price1);
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".wclistprice",function(e){
        var price2 = $(this);
        var price1 = $(this).parent().parent().find(".wcprice");
        var price3 = $(this).parent().parent().find(".wcper");
        if(price1.val() != "" && price2.val() != "" && price2.val() > 0){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $('#datestart2').on('changeDate', function() {
        console.log($(this).val());
        var startdate = $(this).val();
        var enddate = $("#dateend2").val();
        var today = moment(new Date()).format("YYYY-MM-DD");
        console.log(today);
        if(enddate != "" && enddate < today){
            $("#contractStatus").val(3)
        }else if(startdate != "" && startdate > today){
            $("#contractStatus").val(1);
        }else if(enddate != "" && enddate > today && startdate != "" && startdate < today){
            $("#contractStatus").val(2);
        }else{
            $("#contractStatus").val(1);
        }

    });

    $('#dateend2').on('changeDate', function() {
        console.log($(this).val());
        var enddate = $(this).val();
        var startdate = $("#datestart2").val();
        var today = moment(new Date()).format("YYYY-MM-DD");
        console.log(today);
        if(enddate != "" && enddate < today){
            $("#contractStatus").val(3)
        }else if(startdate != "" && startdate > today){
            $("#contractStatus").val(1);
        }else if(enddate != "" && enddate > today && startdate != "" && startdate < today){
            $("#contractStatus").val(2);
        }else {
            $("#contractStatus").val(1);
        }
    });
});

function fnSearchCom() {
    var datas = {
        searchCom : $("#searchCom").val()
    };
    $.ajax({
        url: "/license/searchForCompany",
        type: 'POST',
        dataType: 'JSON',
        data: datas,
        success: function (response) {
            $("#searchResult").css("display", "none");
            $("#comList").empty();
            $("#comSeq").val("");
            $("#comName").val("");
            if(response.result){
                var rsList = response.companyList;
                if(rsList.length > 0 ) {
                    $("#comList").append("<option value=''>선택하세요</option>");
                    for(var i=0;i<rsList.length;i++) {
                        $("#comList").append("<option value='"+ rsList[i].seq +"'>"+ rsList[i].comName +"</option>");
                    }
                    $("#searchResult").css("display", "block");
                } else {
                    $("#searchResultChkText").text("검색 결과가 없습니다. 계약회사명을 다시 확인해주세요.");
                    $("#searchResultChkText").css("display", "block");
                }
            }else{
                $("#searchResultChkText").text("");
                return false;
            }
        }
    });
}

function setStatus(){
    var startdate = $("#startDate").val();
    var enddate = $("#endDate").val();
    var today = moment(new Date()).format("YYYY-MM-DD");
    // console.log(today);
    if(enddate != "" && enddate < today){
        $(".currentStatus").html("종료");
        $("#currentStatus").val("종료");
        // $("#contractStatus").val(3)
    }else if(startdate != "" && startdate > today){
        $(".currentStatus").html("대기");
        $("#currentStatus").val("대기");
        // $("#contractStatus").val(1);
    }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
        // $("#contractStatus").val(2);
        $(".currentStatus").html("사용");
        $("#currentStatus").val("사용");
    }else{
        // $("#contractStatus").val(1);
        $(".currentStatus").html("대기");
        $("#currentStatus").val("대기");
    }
}