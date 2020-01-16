<#include "/layout/base.ftl">
<#import "../pagination.ftl" as pagination />
<div class="content">

    <div class="container">
        <div class="row">
            <div class="col">
                <div class="breadcrumb-wrap mb-3">
                    <div class="row">
                        <div class="col d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">메인</a></li>
                                    <li class="breadcrumb-item"><a href="#">라이선스 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">라이선스 생성</li>
                                </ol>
                            </nav>
                        </div>
                    <#--<div class="col d-flex align-items-center justify-content-end">-->
                    <#--<p>전체 레포지토리 <span></span>개</p>-->
                    <#--</div>-->

                    </div>
                </div>

                <hr>

                <div class="card pt-5 pb-5 mb-5">

                <form id="addForm">
                    <input type="hidden" name="comUUid" value="a5cc8695-f217-4ce9-a011-14d93b301044">
                    <div class="detail-display">
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">라이센스 타입</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <select name="licenseType" id="licenseType" class="form-control custom-select">
                                        <option value="0">Work Center</option>
                                        <option value="1">Mini (Standard only)</option>
                                        <option value="2">Studio (Standard only)</option>
                                    </select>
                                </div>
                            </div>

                        </div>

                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">계약회사 정보 검색</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" name="searchCom" id="searchCom" value="" placeholder="회사명을 입력하시면 자동완성 됩니다." required="">
                                    <input type="hidden" name="comSeq" id="comSeq" value="" >
                                    <input type="hidden"  name="comName" id="comName" value="" >
                                    <#--<button id="searchComBtn" class="form-control" type="button" onclick="fnSearchCom()">검색</button>-->
                                    <#--<div id="searchResult" style="display: none">-->
                                        <#--<select class="custom-select mxw300" id="comList" name="comList"></select>-->
                                        <#--<input type="hidden" name="comSeq" id="comSeq" value="" >-->
                                        <#--<input type="text" class="form-control" name="comName" id="comName" value="" readonly>-->
                                    <#--</div>-->
                                    <#--<div class="text-info-mih">-->
                                        <#--<small id="searchResultChkText" class="form-text text-danger" style="display: none"></small>-->
                                    <#--</div>-->
                                </div>
                            </div>

                        </div>
                        <#--<div class="row mb-4">-->
                            <#--<div class="col-3">-->
                                <#--<div class="miw100 text-right">설치 환경</div>-->
                            <#--</div>-->
                            <#--<div class="col-9">-->
                                <#--<div>-->
                                    <#--<div class="form-check form-check-inline">-->
                                        <#--<input type="radio" id="settingConfig1" name="settingConfig"  class="form-check-input" value="0" checked>-->
                                        <#--<label class="form-check-label">Online</label>-->
                                    <#--</div>-->
                                    <#--<div class="form-check form-check-inline">-->
                                        <#--<input type="radio" id="settingConfig2" name="settingConfig"  class="form-check-input" value="1">-->
                                        <#--<label class="form-check-label">Offline</label>-->
                                    <#--</div>-->
                                <#--</div>-->
                            <#--</div>-->

                        <#--</div>-->
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">Subscribe Type</div>
                            </div>
                            <div class="col-9">

                                <div class="form-check form-check-inline">
                                    <input type="radio" id="subscribeType1" name="subscribeType"  class="form-check-input" value="1" checked>
                                    <label class="form-check-label">종량제(사용량)</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="radio" id="subscribeType2" name="subscribeType"  class="form-check-input" value="0">
                                    <label class="form-check-label">정액제(연단위)</label>
                                </div>

                            </div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">라이선스 이용일</div>
                            </div>
                            <div class="col-9">
                                <div class="row">
                                    <div class="col">
                                        <input type="text" id="datestart" name="startDateStr" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly>
                                    </div>
                                    <div class="col-auto">~</div>
                                    <div class="col">
                                        <input type="text" id="dateend" name="endDateStr" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <#--<div class="row mb-4">-->
                            <#--<div class="col-3">-->
                                <#--<div class="miw100 text-right">Mac Address</div>-->
                            <#--</div>-->
                            <#--<div class="col-9">-->
                                <#--<div>-->
                                    <#--<input type="text" class="form-control" id="macAddress" name="macAddress" placeholder="" required="" value="" readonly="readonly">-->

                                <#--</div>-->
                            <#--</div>-->

                        <#--</div>-->
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">Unattended Bot Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" id="countUnattended" name="countUnattended" placeholder="" required="" value="0">

                                </div>
                            </div>

                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">Attended Bot Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" id="countAttended" name="countAttended" placeholder="" required="" value="0">

                                </div>
                            </div>

                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">Studio Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" id="countDeveloper" name="countDeveloper" placeholder="" required="" value="0">

                                </div>
                            </div>

                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">Unattended Bot Price</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" id="priceUnattended" name="priceUnattended" placeholder="" required="" value="0">
                                </div>
                            </div>

                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="miw100 text-right">Attended Bot Price</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" id="priceAttended" name="priceAttended" placeholder="" required="" value="0">
                                </div>
                            </div>

                        </div>
                        <div class="row mb-5">
                            <div class="col-3">
                                <div class="miw100 text-right">Studio Bot Price</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <input type="text" class="form-control" id="priceDeveloper" name="priceDeveloper" placeholder="" required="" value="0">
                                </div>
                            </div>

                        </div>


                        <#--<div class="row mb-4">-->
                            <#--<div class="col-9">-->
                                <#--<div class="miw100 text-right">상태</div>-->
                            <#--</div>-->
                            <#--<div class="col-9">-->
                                <#--<div>-->
                                    <#--<select name="status" id="status">-->
                                        <#--<option value="0">신청</option>-->
                                        <#--<option value="1">발급완료</option>-->
                                    <#--</select>-->
                                <#--</div>-->
                            <#--</div>-->

                        <#--</div>-->

                        <hr>

                        <div class="text-center">
                            <button type="button" class="btn btn-primary min-width120" id="licenseMake">라이선스 발급</button>
                        </div>
                    </div>
                </form>

                </div>

            </div>
        </div>
    </div>

</div>

<#include "/layout/base_script.ftl">
<link rel="stylesheet" href="/assets/css/easy-autocomplete.min.css"/>
<script src="/assets/js/jquery.easy-autocomplete.min.js"></script>

<!-- custom script 위치 -->
<script>
    $(function(){
        // $("#licenseType").change(function(){
        //     if($(this).val() != 0){
        //         $("#macAddress").prop("readonly",false);
        //     }else{
        //         $("#macAddress").prop("readonly","readonly");
        //     }
        // })
        // 계약회원사 검색 이벤트 캐치
        $("#searchCom").on({
            keyup: function() {
                $("#searchResultChkText").text("");
                $("#searchResultChkText").css("display", "none");
            },
            keydown: function(event) {
                if(event.keyCode == 13) fnSearchCom();
            }
        });

        $("#comList").on("change", function () {
            $("#comSeq").val($(this).val());
            $("#comName").val($("#comList option:selected").text());
        });

        $("#licenseMake").click(function(){

            if($("#comSeq").val() == ""){
                alert("계약회원사를 선택해주시기 바랍니다.");
                return false;
            }
            if($("#datestart").val() == ""){
                alert("라이선스 시작일을 입력해주시기 바랍니다.");
                return false;
            }
            if($("#dateend").val() == ""){
                alert("라이선스 종료일을 입력해주시기 바랍니다.");
                return false;
            }
            if($("#datestart").val() >= $("#dateend").val()){
                alert("시작일과 종료일 날짜에 오류가 있습니다. 확인해보시기 바랍니다.");
                return false;
            }

            if($("#countUnattended").val() == ""){
                alert("Unattended bot 갯수를 입력하세요");
                return false;
            }
            if($("#countAttended").val() == ""){
                alert("Attended bot 갯수를 입력하세요");
                return false;
            }
            if($("#countDeveloper").val() == ""){
                alert("Developer bot 갯수를 입력하세요");
                return false;
            }

            if($("#priceUnattended").val() == ""){
                alert("Unattended bot 금액을 입력하세요");
                return false;
            }
            if($("#priceAttended").val() == ""){
                alert("Attended bot 금액을 입력하세요");
                return false;
            }
            if($("#priceDeveloper").val() == ""){
                alert("Developer bot 금액을 입력하세요");
                return false;
            }
            if(confirm("라이선스를 발급하시겠습니까?")){
                var datas = $("#addForm").serialize();
                $.ajax({
                    url : "/license/make",
                    type : 'POST',
                    data : datas,
                    dataType : 'JSON',
                    success:function(response){
                        if(response.result){
                            // if(confirm("라이선스가 발급되었습니다. 담당자에게 메일로 보내시겠습니까?")){
                            //     // 메일로직
                            //     document.location.href="/license/detail?seq="+response.seq;
                            // }else{
                            //     document.location.href="/license/detail?seq="+response.seq;
                            // }
                            alert("라이선스가 발급되었습니다.");
                            document.location.href="/license/detail?seq="+response.seq;
                        }
                    }
                });
            }
        })
        var options = {

            url: function(phrase) {
                return "/contract/get_contract";
            },

            getValue: function(element) {
                console.log(element);
                return element.comName;
            },
            list: {
                onChooseEvent: function() {
                    // var selectedItemValue = $("#searchCom").getSelectedItemData().realName;
                    $("#comSeq").val($("#searchCom").getSelectedItemData().seq);
                    $("#comName").val($("#searchCom").getSelectedItemData().comName);
                    // $("#inputTwo").val(selectedItemValue).trigger("change");
                },
                onKeyEnterEvent: function(){
                    $("#comSeq").val($("#searchCom").getSelectedItemData().seq);
                    $("#comName").val($("#searchCom").getSelectedItemData().comName);
                },
                maxNumberOfElements: 10
            },
            ajaxSettings: {
                dataType: "json",
                method: "GET",
                data: {
                    dataType: "json"
                }
            },

            preparePostData: function(data) {
                data.phrase = $("#searchCom").val();
                return data;
            },

            requestDelay: 400
        };

        $("#searchCom").easyAutocomplete(options);
        // $("#searchCom").autocomplete({
        //     source : function (request, response) {
        //         $.ajax( {
        //             method : "GET",
        //             url: '/contract/get_contract',
        //             dataType: "json",
        //             data: {
        //                 companyName: request.term
        //             },
        //             success: function( data ) {
        //                 console.log(data);
        //                 response( data );
        //             }
        //         });
        //     },
        //     minLength: 1,
        //     select : function(event,ui){
        //         $("#searchCom").val(ui.item.comName);
        //         $("#comSeq").val(ui.item.seq);
        //         $("#comName").val(ui.item.comName);
        //         // $("#searchCom").blur();
        //
        //
        //         return false;
        //     }
        // }).autocomplete( "instance" )._renderItem = function( ul, item ) {
        //     // console.log(ul);
        //     ul.css("z-index","9999");
        //     return $( "<li>" )
        //         .append( item.comName )
        //         .appendTo( ul );
        // };
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
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">