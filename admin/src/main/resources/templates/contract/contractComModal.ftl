<style>
    .easy-autocomplete-container {
        z-index:9999 !important;
    }
</style>
<div class="modal-body pa-0">
    <form id="writeForm">
        <input type="hidden" name="seq" id="seq" value="<#if company??>${company.seq}</#if>">
        <input type="hidden" name="contractStart" id="contractStart" value="">
        <input type="hidden" name="contractEnd" id="contractEnd" value="">
        <div id="contentMain" class="input-display">

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>회사명</span>
                    </div>

                    <div class="col-9">
                        <input type="text" class="form-control input-form" name="comName" id="comName" placeholder="" required=""
                                value="<#if company??>${company.comName}</#if>">
                        <div class="text-info-mih">
                            <small id="comNameChkText" class="form-text text-danger" style="display: none"></small>
                        </div>
                    </div>
                </div>
                <#if company??>
                    <div class="form-row">
                        <div class="col-3 main-form-title">
                            <span>계약일 정보</span>
                        </div>
                        <div class="col-3">
                            <input type="text" class="form-control input-form" name="contractStart_m" id="contractStart_m" placeholder="" required="" value="<#if comContract??>${comContract.contractStart?string["yyyy-MM-dd"]}</#if>" autocomplete="off" readonly>
                        </div>
                        <div class="col-auto text-center">
                            ~
                        </div>
                        <div class="col-3">
                            <input type="text" class="form-control input-form" name="contractEnd_m" id="contractEnd_m" placeholder="" required="" value="<#if comContract??>${comContract.contractEnd?string["yyyy-MM-dd"]}</#if>" autocomplete="off" readonly>
                        </div>
                        <div class="col">
                            <select id="contStatus" class="form-control custom-select" name="contStatus">
                                <option value="">선택</option>
                                <option value="0">수정</option>
                                <option value="1">연장</option>
                            </select>
                        </div>
                        <div class="col">
                            <button class="btn btn-light btn-block" type="button" id="contStatusConfirm" name="contStatusConfirm">
                                확인
                            </button>
                            <div class="text-info-mih">
                                <small id="contStatusChkText" class="form-text text-danger" style="display: none"></small>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-3 main-form-title">
                            <span>계약 히스토리</span>
                        </div>
                        <div class="col-9">
                            <div class="contHistory"></div>
                            <div class="text-info-mih"></div>
                        </div>
                    </div>
                    <#else>
                    <div class="form-row">
                        <div class="col-3 main-form-title">
                            <span>계약 시작일</span>
                        </div>
                        <div class="col-9">
                            <input type="text" class="form-control input-form" name="contractStart_i" id="contractStart_i" placeholder="" required="" autocomplete="off" readonly>
                            <div class="text-info-mih">
                                <small id="contractStart_iChkText" class="form-text text-danger" style="display: none"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-3 main-form-title">
                            <span>계약 종료일</span>
                        </div>
                        <div class="col-9">
                            <input type="text" class="form-control input-form" name="contractEnd_i" id="contractEnd_i" placeholder="" required="" autocomplete="off" readonly>
                            <div class="text-info-mih">
                                <small id="contractEnd_iChkText" class="form-text text-danger" style="display: none"></small>
                            </div>
                        </div>
                    </div>
                </#if>

                <hr>

                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>정산 담당자 이름</span>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" name="serviceName" id="serviceName" placeholder="" required=""
                                value="<#if company??>${company.serviceName}</#if>">
                        <div class="text-info-mih">
                            <small id="serviceNameChkText" class="form-text text-danger" style="display: none"></small>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>정산 담당자 연락처</span>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" placeholder="" required="" name="servicePhone" id="servicePhone"
                                value="<#if company??>${company.servicePhone}</#if>">
                        <div class="text-info-mih">
                            <small id="servicePhoneChkText" class="form-text text-danger" style="display: none"></small>
                        </div>
                    </div>
                    <div class="col-5">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>정산 담당자 이메일</span>
                        <div class="tooltip-dropdown">
                            <span class="tooltip-btn"><i class="icon icon-info"></i></span>
                            <div class="tooltip-dropdown-content">
                                <div>
                                    세금계산서 발행을 위한 이메일 정보를 입력해 주세요.
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-9">
                        <input type="text" class="form-control input-form" placeholder="" required="" name="serviceEmail" id="serviceEmail"
                                value="<#if company??>${company.serviceEmail}</#if>">
                        <div class="text-info-mih">
                            <small id="serviceEmailChkText" class="form-text text-danger" style="display: none"></small>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>계약 담당자 지정</span>
                    </div>
                    <div class="col-9 custom-auto-select" style="width:300px">
                        <#--<input type="text" id="contractParson" class="ui-autocompete-input form-control mxw300" autocomplete="off">-->
                        <input type="text" class="form-control" name="contractParson" id="contractParson" value="<#if company??>${company.loginId!}</#if>" placeholder="회원아이디를 입력하면 자동완성됩니다." required="">
                        <input type="hidden" name="userSeq" id="userSeq" value="<#if company??>${company.userSeq!}</#if>" >
                        <input type="hidden"  name="userName" id="userName" value="<#if company??>${company.userName!}</#if>" >
                        <#--<input type="hidden" id="contractPersonKeyValue" name="contractPersonKeyValue" value=""/>-->
                        <#--<select class="custom-select miw250" name="contractPerson" id="contractPerson" data-placeholder="계약담당자를 선택하세요." autocomplete="off">-->
                            <#--<option></option>-->
                            <#--<#if company??><#if company.userSeq??><#assign comUserSeq = company.userSeq></#if></#if>-->
                            <#--<#if userList??>-->
                                <#--<#list userList as user>-->
                                    <#--<option value="${user.seq}" <#if company??><#if company.userSeq??><#if comUserSeq = user.seq>selected</#if></#if></#if> >${user.name!} (${user.loginId})</option>-->
                                <#--</#list>-->
                            <#--</#if>-->
                        <#--</select>-->
                        <div class="text-info-mih">
                            <small id="contractUserChk" class="form-text text-danger" style="display: none"></small>
                        </div>
                    </div>
                </div>
                <#if company??>
                <div class="form-row">
                    <div class="col-3 main-form-title">
                        <span>계약 상태</span>
                    </div>
                    <div class="col-9">
                        <#--<input type="text" id="contractParson" class="ui-autocomplete-input form-control mxw300" autocomplete="off">-->
                        <#--<input type="hidden" id="contractPersonKeyValue" name="contractPersonKeyValue" value=""/>-->
                        <select name="status" class="form-control custom-select" id="status">
                            <option value="0" <#if company.status = 0>selected</#if>>계약진행</option>
                            <option value="1" <#if company.status = 1>selected</#if>>계약해지</option>
                        </select>
                        <div id="contractReasonFrom" style="display: none">
                            <input type="text" class="form-control input-form mt-2" placeholder="계약 해지 사유를 입력해주세요." required="" name="contractReason" id="contractReason"
                                   value="<#if company.status = 1><#if company.contractReason??>${company.contractReason}</#if></#if>">
                        </div>
                        <div class="text-info-mih">
                            <small id="contractReasonChkText" class="form-text text-danger" style="display: none"></small>
                        </div>
                    </div>
                </div>
                </#if>

        </div>
    </form>
</div>
<div class="modal-footer d-flex justify-content-center align-items-center">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
    <button type="button" class="btn btn-primary btn-save">
        <#if company??>수 정<#else>등 록</#if>
    </button>
</div>
<link rel="stylesheet" href="/assets/css/easy-autocomplete.min.css"/>
<script src="/assets/js/jquery.easy-autocomplete.min.js"></script>
<script type="text/javascript">
    $(function(){

        // $("#contractParson").autocomplete({
        //     source : function (request, response) {
        //         $.ajax( {
        //             method : "GET",
        //             url: '/user/get_user',
        //             dataType: "json",
        //             data: {
        //                 userName: request.term
        //             },
        //             success: function( data ) {
        //                 console.log(data);
        //                 response( data );
        //             }
        //         });
        //     },
        //     minLength: 1,
        //     select : function(event,ui){
        //         $("#contractParson").val(ui.item.name);
        //         $("#userSeq").val(ui.item.seq);
        //         $("#userName").val(ui.item.name);
        //         $("#contractParson").blur();
        //
        //         return false;
        //     }
        // })
        //     .autocomplete( "instance" )._renderItem = function( ul, item ) {
        //     // console.log(ul);
        //     ul.css("z-index","9999");
        //     return $( "<li>" )
        //         .append( item.name )
        //         .appendTo( ul );
        // };
        var options = {

            url: function(phrase) {
                return "/user/get_user";
            },

            getValue: function(element) {
                console.log(element);
                return element.loginId;
            },
            list: {
                onChooseEvent: function() {
                    // var selectedItemValue = $("#searchCom").getSelectedItemData().realName;
                    $("#userSeq").val($("#contractParson").getSelectedItemData().seq);
                    $("#userName").val($("#contractParson").getSelectedItemData().loginId);
                    // $("#inputTwo").val(selectedItemValue).trigger("change");
                },
                onKeyEnterEvent: function(){
                    $("#userSeq").val($("#contractParson").getSelectedItemData().seq);
                    $("#userName").val($("#contractParson").getSelectedItemData().loginId);
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
                data.phrase = $("#contractParson").val();
                return data;
            },

            requestDelay: 400
        };

        $("#contractParson").easyAutocomplete(options);
        $(".easy-autocomplete").width("100%")

        <#if company??>
            $("#companyModalCenterTitle").text("계약회사 정보 수정");
            $("#companyModalCenterTitle").append('<span class="sub-title pl-3">계약회사의 정보를 수정 할 수 있습니다.</span>')
            <#else>
            $("#companyModalCenterTitle").text("계약회사 정보 등록");
            $("#companyModalCenterTitle").append('<span class="sub-title pl-3">계약회사의 정보를 등록 할 수 있습니다.</span>')
        </#if>

        $(".input-form").on({
            keyup: function () {
                $(".text-danger").text("");
            },
            change: function () {
                $(".text-danger").text("");
            }
        });

        // 정산 담당자 연락처 정규식 체크
        $("#servicePhone").bind("keyup", function(event) {
            var regNumber = /^[0-9]*$/;
            var temp = $("#servicePhone").val();
            if(!regNumber.test(temp))
            {
                //$("#servicePhoneChkText").text("* 숫자만 입력해주세요.");
                $("#servicePhoneChkText").css("display", "block");
                $("#servicePhone").val(temp.replace(/[^0-9]/g,""));
            }
        });

        /* DatePicker Script */
        <#if company??>
            $('#contractStart_m').datepicker({
                uiLibrary: 'bootstrap4',
                format: 'yyyy-mm-dd',
                showOtherMonths: true
            });
            $('#contractEnd_m').datepicker({
                uiLibrary: 'bootstrap4',
                format: 'yyyy-mm-dd',
                showOtherMonths: true
            });

            // 계약 해지 유무 체크 이벤트 (사유 노출 처리)
            var contStatus = ${company.status};
            if(contStatus == 1) $("#contractReasonFrom").css("display", "block");
            $("#status").on("change", function(){
                if($(this).val() == 1) $("#contractReasonFrom").css("display", "block");
                else $("#contractReasonFrom").css("display", "none");
            });

            // 등록, 수정 폼 여부에 따라 계약일 히스토리 노출 이벤트 처리
            var seq = ${company.seq};
            $.ajax({
                url: "/contract/companyHistory?comSeq="+seq,
                type: 'GET'
                //ascyc: false
            }).done(function (response) {
                var result = response.contHistoryList;
                var data = "";
                for(var i=0;i<result.length;i++) {
                    var contHistStart = getFormatDate(result[i].contractStart);
                    var contHistEnd = getFormatDate(result[i].contractEnd);
                    var contHistStatus = result[i].status;
                    if(contHistStatus == 0) contHistStatus = "수정일:";
                    else contHistStatus = "연장일:";
                    var createDatetime = getFormatDate(result[i].createDatetime);
                    data += " <input type='text' " +
                                   " class='form-control miw300'" +
                                   " id='contHistory_"+i+"'" +
                                   " value='"+contHistStart+" ~ "+contHistEnd+" ("+contHistStatus+" "+createDatetime+")'" +
                                   " readonly "+ '/' +"> ";
                }
                $(".contHistory").html(data);
            });

            // 계약일 정보 변경 이벤트

            $("#contStatusConfirm").on("click", function(){
                var contStatusValue = $("#contStatus").val();
                var message = "";
                var date_pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
                if($("#contractStart_m").val() != null && $("#contractStart_m").val() != "") {
                    if(contStatusValue == "0") {
                        message = "계약일 정보를 수정하시겠습니까?";
                        if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                        $("#contStatusChkText").css("display", "none");
                    } else if(contStatusValue == "1") {
                        message = "계약을 연장 하시겠습니까?";
                        if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                        $("#contStatusChkText").css("display", "none");
                    } else {
                        if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                        $("#contStatusChkText").text("* 수정/연장 상태를 선택해주세요.");
                        $("#contStatusChkText").css("display", "block");
                        return false;
                    }

                    // 변경된 계약 시작일
                    var contractStart = $("#contractStart_m").val();
                    var startDateArr = contractStart.split('-');
                    var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);

                    // 원본 계약 시작일
                    var contractStart_old = '${comContract.contractStart?string["yyyy-MM-dd"]}';
                    var startDateArr_old = contractStart_old.split('-');
                    var startDateCompare_old = new Date(startDateArr_old[0], parseInt(startDateArr_old[1])-1, startDateArr_old[2]);

                    // 변경된 계약 종료일
                    var contractEnd = $("#contractEnd_m").val();
                    var endDateArr = contractEnd.split('-');
                    var endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);

                    // 원본 계약 종료일
                    var contractEnd_old = '${comContract.contractEnd?string["yyyy-MM-dd"]}';
                    var endDateArr_old = contractEnd_old.split('-');
                    var endDateCompare_old = new Date(endDateArr_old[0], parseInt(endDateArr_old[1])-1, endDateArr_old[2]);

                    // 계약 시작일 유효성 검사
                    if(!date_pattern.test(contractStart)){
                        if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                        $("#contStatusChkText").text("* 계약 시작일 정보를 정확히 입력해주세요.");
                        $("#contStatusChkText").css("display", "block");
                        return false;
                    }
                    // 기존 시작일 종료일 값과 변경된 값이 동일할 경우
                    else if(startDateCompare.getTime() == startDateCompare_old.getTime() &&
                            endDateCompare.getTime() == endDateCompare_old.getTime()) {
                        if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                        $("#contStatusChkText").text("* 기존 계약일 정보와 동일합니다.");
                        $("#contStatusChkText").css("display", "block");
                        return false;
                    } else {
                        // 계약 수정일 때 시작일 체크
                        if(contStatusValue == 0) {
                            if(startDateCompare.getTime() < startDateCompare_old.getTime()) {
                                if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                                $("#contStatusChkText").text("* 계약 수정 시 시작일은 "+contractStart_old+" 보다 이전날짜로 선택 할 수 없습니다.");
                                $("#contStatusChkText").css("display", "block");
                                return false;
                            }
                        }
                        // 계약 연장일 때 시작일 체크
                        else {
                            if(startDateCompare.getTime() < endDateCompare_old.getTime()) {
                                if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                                $("#contStatusChkText").text("* 계약 연장 시 시작일은 "+contractEnd_old+" 보다 이전날짜로 선택 할 수 없습니다.");
                                $("#contStatusChkText").css("display", "block");
                                return false;
                            }
                        }
                    }

                    // 계약 종료일 유효성 검사
                    if(!date_pattern.test(contractEnd)) {
                        if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                        $("#contStatusChkText").text("* 계약 종료일 정보를 정확히 입력해주세요.");
                        $("#contStatusChkText").css("display", "block");
                        return false;
                    } else {
                        // 계약 시작일과 종료일 비교
                        if(startDateCompare.getTime() > endDateCompare.getTime()) {
                            if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                            $("#contStatusChkText").text("* 계약 종료일은 시작일 보다 이전날짜로 선택 할 수 없습니다.");
                            $("#contStatusChkText").css("display", "block");
                            return false;
                        }
                    }
                } else {
                    if(!$("#contStatusChkText").hasClass("text-danger")) $("#contStatusChkText").addClass("text-danger");
                    $("#contStatusChkText").text("* 계약 시작일 정보를 입력해주세요.");
                    $("#contStatusChkText").css("display", "block");
                    return false;
                }

                // 계약일 변경 처리
                if(confirm(message)) {
                    var datas = {
                        comSeq : ${company.seq},
                        status : contStatusValue,
                        contractStart : new Date($("#contractStart_m").val()),
                        contractEnd : new Date($("#contractEnd_m").val())
                    };
                    $.ajax({
                        url: "/contract/statusChange",
                        type: 'POST',
                        dataType: 'JSON',
                        data: datas,
                        success: function (response) {
                            if(response.result){
                                var result = response.contHistoryList;
                                var data = "";
                                for(var i=0;i<result.length;i++) {
                                    var contHistStart = getFormatDate(result[i].contractStart);
                                    var contHistEnd = getFormatDate(result[i].contractEnd);
                                    var contHistStatus = result[i].status;
                                    if(contHistStatus == 0) contHistStatus = "수정일:";
                                    else contHistStatus = "연장일:";
                                    var createDatetime = getFormatDate(result[i].createDatetime);
                                    data += " <input type='text' " +
                                        " class='form-control miw300'" +
                                        " id='contHistory_"+i+"'" +
                                        " value='"+contHistStart+" ~ "+contHistEnd+" ("+contHistStatus+" "+createDatetime+")'" +
                                        " readonly "+ '/' +"> ";
                                }
                                $(".contHistory").empty();
                                $(".contHistory").html(data);
                                if(contStatusValue == "0") $("#contStatusChkText").text("* 계약일 정보가 수정되었습니다.");
                                else $("#contStatusChkText").text("* 계약일이 연장되었습니다.");
                                $("#contStatusChkText").removeClass("text-danger");
                                $("#contStatusChkText").css("display", "block");
                                $("#contStatusChkText").css("color", "#00BFFF");
                                return false;
                            } else {
                                if(contStatusValue == "0") $("#contStatusChkText").text("* 수정 실패! 지속될 경우 사이트 관리자에게 문의해주세요.");
                                else $("#contStatusChkText").text("* 연장 실패! 지속될 경우 사이트 관리자에게 문의해주세요.");
                                $("#contStatusChkText").css("display", "block");
                            }
                        }
                    });
                }
            });

            <#else>
            $('#contractStart_i').datepicker({
                uiLibrary: 'bootstrap4',
                format: 'yyyy-mm-dd',
                showOtherMonths: true
            });
            $('#contractEnd_i').datepicker({
                uiLibrary: 'bootstrap4',
                format: 'yyyy-mm-dd',
                showOtherMonths: true
            });
        </#if>

        // $("#contractPerson").chosen({
        //     width:"30%",
        //     allow_single_deselect:false,
        //     no_results_text:"입력값이 존재하지 않습니다."
        // });

        // 계약회사 정보 등록, 수정 처리 이벤트
        $(".btn-save").click(function(){

            if($("#comName").val() == null || $("#comName").val() == "") {
                $("#comNameChkText").text("* 계약 회사명을 정확히 입력해주세요.");
                $("#comNameChkText").css("display", "block");
                return false;
            }

            <#if company??>
                if($("#status").val() == "1") {
                    if($("#contractReason").val() == null || $("#contractReason").val() == "") {
                        $("#contractReasonChkText").text("* 계약 해지 사유를 정확히 입력해주세요.");
                        $("#contractReasonChkText").css("display", "block");
                        return false;
                    }
                }

                <#else>
                var datePattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
                // 계약 시작일
                var contractStart = $("#contractStart_i").val();
                var startDateArr = contractStart.split('-');
                var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);

                // 계약 종료일
                var contractEnd = $("#contractEnd_i").val();
                var endDateArr = contractEnd.split('-');
                var endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);

                if(contractStart == null || contractStart == "") {
                    $("#contractStart_iChkText").text("* 계약 시작일을 정확히 선택하거나 입력해주세요.");
                    $("#contractStart_iChkText").css("display", "block");
                    return false;
                } else if(!datePattern.test(contractStart)) {
                    $("#contractStart_iChkText").text("* 계약 시작일을 정확히 선택하거나 입력해주세요.");
                    $("#contractStart_iChkText").css("display", "block");
                    return false;
                }

                if(contractEnd == null || contractEnd == "") {
                    $("#contractEnd_iChkText").text("* 계약 종료일을 정확히 선택하거나 입력해주세요.");
                    $("#contractEnd_iChkText").css("display", "block");
                    return false;
                } else if(!datePattern.test(contractEnd)) {
                    $("#contractEnd_iChkText").text("* 계약 종료일을 정확히 선택하거나 입력해주세요.");
                    $("#contractEnd_iChkText").css("display", "block");
                    return false;
                }

                if(startDateCompare.getTime() > endDateCompare.getTime()) {
                    $("#contractStart_iChkText").text("* 계약 시작일은 종료일보다 이후가 될 수 없습니다.");
                    $("#contractStart_iChkText").css("display", "block");
                    return false;
                }
            </#if>

            // var namePattern = /([^가-힣\x20a-zA-Z])/i;
            if($("#serviceName").val() == null || $("#serviceName").val() == "") {
                $("#serviceNameChkText").text("* 정산 담당자 이름을 정확히 입력해주세요.");
                $("#serviceNameChkText").css("display", "block");
                return false;
            }
            // else if(namePattern.test($("#serviceName").val())) {
            //     $("#serviceNameChkText").text("* 특수문자는 사용 할 수 없습니다. 한글또는 영문을 입력해 주세요.");
            //     $("#serviceNameChkText").css("display", "block");
            //     return false;
            // }

            // var phonePattern = /^(0[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
            if($("#servicePhone").val() == null || $("#servicePhone").val() == "") {
                $("#servicePhoneChkText").text("* 정산 담당자 연락처를 정확히 입력해주세요.");
                $("#servicePhoneChkText").css("display", "block");
                return false;
            } else if($("#servicePhone").val().length > 11) {
                $("#servicePhoneChkText").text("* 연락처는 최대 11자리를 넘을 수 없습니다.");
                $("#servicePhoneChkText").css("display", "block");
                return false;
            }
            // } else if(phonePattern.test($("#servicePhone").val())) {
            //     $("#servicePhoneChkText").text("* 연락처는 앞 2~4자리, 중간 3~4자리, 끝 4자리만 허용합니다.");
            //     $("#servicePhoneChkText").css("display", "block");
            //     return false;
            // }

            var emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            if($("#serviceEmail").val() == null || $("#serviceEmail").val() == "") {
                $("#serviceEmailChkText").text("* 정산 담당자 이메일을 정확히 입력해주세요.");
                $("#serviceEmailChkText").css("display", "block");
                return false;
            } else if(!emailPattern.test($("#serviceEmail").val())) {
                $("#serviceEmailChkText").text("* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.");
                $("#serviceEmailChkText").css("display", "block");
                return false;
            }
            if($("#contractParson").val() != ""){
                if($("#userSeq").val() == "" || $("#userSeq").val() === undefined){
                    $("#contractUserChk").text("* 계약담당자를 다시 지정해주시기 바랍니다.");
                    $("#contractUserChk").show();
                    return false;
                }
            }
            var comSeq = "<#if company??>${company.seq}</#if>";
            var message = "";
            $(".text-danger").text("");
            if(comSeq != "") {
                message = "계약회사 정보를 수정하시겠습니까?";
                $("#contractStart").val($("#contractStart_m").val());
                $("#contractEnd").val($("#contractEnd_m").val());
            } else {
                message = "계약회사 정보를 등록하시겠습니까?";
                $("#contractStart").val($("#contractStart_i").val());
                $("#contractEnd").val($("#contractEnd_i").val());
            }
            if(confirm(message)) {
                var datas = $("#writeForm").serialize();
                $.ajax({
                    url: "/contract/companyRegistration",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("<#if company??>수정<#else>등록</#if> 처리가 완료되었습니다.");
                            $('#companyModal').modal("hide"); //닫기
                            location.reload();
                        }else{
                            alert("<#if company??>수정<#else>등록</#if> 실패!\n지속될 경우 사이트 관리자에게 문의해주세요.");
                            $('#companyModal').modal("hide"); //닫기
                            location.reload();
                        }
                    }
                });
            }
        });
    });
</script>
