$(function(){

    $("body").on("change",".licenseType",function(){
        var html = '';
        $(this).parent().parent().parent().find(".atper").val("")
        $(this).parent().parent().parent().find(".stper").val("")
        $(this).parent().parent().parent().find(".wcper").val("")
        $(this).parent().parent().parent().find(".unper").val("")
        if($(this).val() == "2") {
            html += '<option value="1">Hour</option>' +
                '<option value="3">Annual</option>';
            $(this).parent().parent().parent().find(".atprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".atlistprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".atcount").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".stprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".stlistprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".stcount").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".wcprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".wclistprice").attr("readonly", true).val(0)
            $(this).parent().parent().parent().find(".wccount").attr("readonly", true).val(0)
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
    $(".licenseAdd").click(function(){
        var html = '<div class="licenseDetail card p-4">\
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
    $("body").on("click",".licenseDel",function(){

        $(this).parent().parent().parent().remove();
    })

    $(".btn-make").click(function(){
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

        if($("#datestart").val() == ""){
            alert("시작일을 입력해 주세요");
            return false;
        }

        if($("#dateend").val() == ""){
            alert("종료일을 입력해 주세요");
            return false;
        }

        if($("#datestart").val() > $("#dateend").val()){
            alert("종료일은 시작일 이후로 선택해주세요");
            return false;
        }

        if($("#searchUser").val() == ""){
            alert("계약 담당자를 입력해 주세요");
            return false;
        }

        if($("#contractChargerEmail").val() == "" && $("#contractChargerPhone").val() == ""){
            alert("정확한 이름을 입력해주세요\n이름이 안나올 경우 '사용자 등록'메뉴에서 사용자 정보를 먼저 등록해주세요");
            return false;
        }

        if($("#userName").val() != $("#searchUser").val()){
            alert("정확한 이름을 입력해주세요\n이름이 안나올 경우 '사용자 등록'메뉴에서 사용자 정보를 먼저 등록해주세요");
            return false;
        }

        if($("#contractIctName").val() == ""){
            alert("ICT 담당자를 입력해 주세요");
            return false;
        }
        var validation = true
        var errorType;
        $(".licenseDetail").each(function(){
            if($(this).find(".unprice").val() == "" || $(this).find(".unlistprice").val() == "" || $(this).find(".uncount").val() == "" || $(this).find(".atprice").val() == "" || $(this).find(".atlistprice").val() == "" || $(this).find(".atcount").val() == "" || $(this).find(".stprice").val() == "" || $(this).find(".stlistprice").val() == "" || $(this).find(".stcount").val() == "" || $(this).find(".wcprice").val() == "" || $(this).find(".wclistprice").val() == "" || $(this).find(".wccount").val() == ""){
                validation = false;
                // console.log($(this).find(".unprice").prop("readonly"));
                if($(this).find(".unprice").val() == "" && !$(this).find(".unprice").prop("readonly")){
                    errorType = 1;
                    return false;
                }
                if($(this).find(".unlistprice").val() == "" && !$(this).find(".unlistprice").prop("readonly")){
                    errorType = 2;
                    return false;
                }
                if($(this).find(".uncount").val() == "" && !$(this).find(".uncount").prop("readonly")){
                    errorType = 3;
                    return false;
                }
                if($(this).find(".atprice").val() == "" && !$(this).find(".atprice").prop("readonly")){
                    errorType = 4;
                    return false;
                }
                if($(this).find(".atlistprice").val() == "" && !$(this).find(".atlistprice").prop("readonly")){
                    errorType = 5;
                    return false;
                }
                if($(this).find(".atcount").val() == "" && !$(this).find(".atcount").prop("readonly")){
                    errorType = 6;
                    return false;
                }
                if($(this).find(".stprice").val() == "" && !$(this).find(".stprice").prop("readonly")){
                    errorType = 7;
                    return false;
                }
                if($(this).find(".stlistprice").val() == "" && !$(this).find(".stlistprice").prop("readonly")){
                    errorType = 8;
                    return false;
                }
                if($(this).find(".stcount").val() == "" && !$(this).find(".stcount").prop("readonly")){
                    errorType = 9;
                    return false;
                }
                if($(this).find(".wcprice").val() == "" && !$(this).find(".wcprice").prop("readonly")){
                    errorType = 10;
                    return false;
                }
                if($(this).find(".wclistprice").val() == "" && !$(this).find(".wclistprice").prop("readonly")){
                    errorType = 11;
                    return false;
                }
                if($(this).find(".wccount").val() == "" && !$(this).find(".wccount").prop("readonly")){
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
            // alert("금액 및 수량을 입력해주시기 바랍니다.");
            // return false;
        }
        if(confirm("계약을 생성 하시겠습니까?")){
            var datas = $("#contractForm").serialize();

            $.ajax({
                url : "/contract/make",
                type : 'POST',
                data : datas,
                dataType : 'JSON',
                success:function(response){
                    console.log(response);
                    if(response.result){
                        alert("계약이 생성되었습니다.");
                        document.location.href='/contract/new_list';

                    }else{
                        if(response.errorCode == "-1"){
                            alert("기존에 같은 계약번호가 있습니다. 다른 계약번호를 생성해주세요");
                            return false;
                        }
                    }
                },
                error: function(error){
                    console.log(error);
                }
            });
        }

    });
    var options = {

        url: function(phrase) {
            return "/user/get_user";
        },

        getValue: function(element) {
            return element.name+"("+element.loginId+")";
        },
        list: {
            onChooseEvent: function() {
                $("#userSeq").val($("#searchUser").getSelectedItemData().seq);
                $("#contractChargerEmail").val($("#searchUser").getSelectedItemData().loginId);
                $("#contractChargerPhone").val($("#searchUser").getSelectedItemData().phone);
                $("#searchUser").val($("#searchUser").getSelectedItemData().name)
                $("#userName").val($("#searchUser").getSelectedItemData().name);
            },
            onKeyEnterEvent: function(){
                $("#userSeq").val($("#searchUser").getSelectedItemData().seq);
                $("#contractChargerEmail").val($("#searchUser").getSelectedItemData().loginId);
                $("#contractChargerPhone").val($("#searchUser").getSelectedItemData().phone);
                $("#searchUser").val($("#searchUser").getSelectedItemData().name)
                $("#userName").val($("#searchUser").getSelectedItemData().name);
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

        preparePostData: function(data) {
            data.phrase = $("#searchUser").val();
            return data;
        },

        requestDelay: 100
    };

    $("#searchUser").easyAutocomplete(options);

    $('#datestart').on('changeDate', function() {
        var startdate = $(this).val();
        var enddate = $("#dateend").val();
        var today = moment(new Date()).format("YYYY-MM-DD");
        if(enddate != "" && enddate < today){
            $("#contractStatus").val("종료")
        }else if(startdate != "" && startdate > today){
            $("#contractStatus").val("대기");
        }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
            $("#contractStatus").val("사용");
        }else{
            $("#contractStatus").val("대기");
        }
    });

    $('#dateend').on('changeDate', function() {
        var enddate = $(this).val();
        var startdate = $("#datestart").val();
        var today = moment(new Date()).format("YYYY-MM-DD");
        if(enddate != "" && enddate < today){
            $("#contractStatus").val("종료")
        }else if(startdate != "" && startdate > today){
            $("#contractStatus").val("대기");
        }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
            $("#contractStatus").val("사용");
        }else{
            $("#contractStatus").val("대기");
        }
    });

    $("body").on("focusout",".unprice",function(e){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".unlistprice");
        var price3 = $(this).parent().parent().find(".unper");

        if(price1.val() != "" && price2.val() != ""){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".unlistprice",function(e){
        var price2 = $(this);
        var price1 = $(this).parent().parent().find(".unprice");
        var price3 = $(this).parent().parent().find(".unper");
        if(price1.val() != "" && price2.val() != ""){
            price3.val(Math.round((1-(price1.val()/price2.val()))*100));
        }
    })

    $("body").on("focusout",".atprice",function(e){
        var price1 = $(this);
        var price2 = $(this).parent().parent().find(".atlistprice");
        var price3 = $(this).parent().parent().find(".atper");

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
});