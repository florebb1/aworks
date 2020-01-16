<#include "/layout/base.ftl">
<#import "../pagination.ftl" as pagination />
<div class="content">

    <div class="container">
        <div class="row">
            <div class="col">
                <div class="breadcrumb-wrap mb-3">
                    <div class="form-row">
                        <div class="col d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">메인</a></li>
                                    <li class="breadcrumb-item"><a href="#">ABBYY 라이선스 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">ABBYY 라이선스 <#if abbyy?? && abbyy.seq??>수정<#else>등록</#if></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <hr>

                <div class="card pt-5 pb-5 mb-5">

                    <form id="addForm">
                        <input type="hidden" name="seq" value="<#if abbyy?? && abbyy.seq??>${abbyy.seq?c}</#if>">
                        <input type="hidden" name="comUUid" value="a5cc8695-f217-4ce9-a011-14d93b301044">
                        <div class="detail-display">
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">계약회원사 정보 검색</div>
                                </div>
                                <div class="col-9">

                                        <input type="text" class="form-control" name="searchCom" id="searchCom"
                                            value="<#if abbyy?? && abbyy.comName??>${abbyy.comName}</#if>" placeholder="" required="">
                                        <input type="hidden" name="comSeq" id="comSeq"
                                            value="<#if abbyy?? && abbyy.comSeq??>${abbyy.comSeq}</#if>" >
                                        <input type="hidden"  name="comName" id="comName"
                                            value="<#if abbyy?? && abbyy.comName??>${abbyy.comName}</#if>" >

                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-3 text-right">
                                    <div class="text-right font-w600">Abbyy 라이센스 Key</div>
                                </div>
                                <div class="col-9">
                                        <input type="text" class="form-control" id="abbyyLicenseKey" name="abbyyLicenseKey" placeholder="" required=""
                                            value="<#if abbyy?? && abbyy.abbyyLicenseKey??>${abbyy.abbyyLicenseKey}</#if>" >
                                </div>
                            </div>

                            <div class="row mb-5">
                                <div class="col-3 text-right">
                                    <div class="text-right font-w600">라이선스 이용일</div>
                                </div>
                                <div class="col-9">
                                    <div class="form-row">
                                        <div class="col">
                                            <input type="text" id="datestart" name="startDateStr" class="form-control" placeholder="날짜선택"
                                            value="<#if abbyy?? && abbyy.startDate??>${abbyy.startDate?string["yyyy-MM-dd"]}</#if>" autocomplete="off" readonly>
                                        </div>
                                        <div class="col-auto">
                                            ~
                                        </div>
                                        <div class="col">
                                            <input type="text" id="dateend" name="endDateStr" class="form-control" placeholder="날짜선택"
                                            value="<#if abbyy?? && abbyy.endDate??>${abbyy.endDate?string["yyyy-MM-dd"]}</#if>" autocomplete="off" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr>

                            <div class="text-center">
                                <button type="button" class="btn btn-primary min-width200" id="registrationBtn">ABBYY 라이선스 <#if abbyy?? && abbyy.seq??>수정<#else>등록</#if></button>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

</div>
<link rel="stylesheet" href="/assets/css/easy-autocomplete.min.css"/>
<script src="/assets/js/jquery.easy-autocomplete.min.js"></script>
<#include "/layout/base_script.ftl">

<!-- custom script 위치 -->
<script>
    $(function(){

        // 계약회원사 검색 이벤트 캐치
        // $("#searchCom").on({
        //     keyup: function() {
        //         $("#searchResultChkText").text("");
        //         $("#searchResultChkText").css("display", "none");
        //     },
        //     keydown: function(event) {
        //         if(event.keyCode == 13) fnSearchCom();
        //     }
        // });

        $("#comList").on("change", function () {
            $("#comSeq").val($(this).val());
            $("#comName").val($("#comList option:selected").text());
        });

        $("#registrationBtn").click(function(){
            if($("#datestart").val() == ""){
                alert("Abbyy 라이선스 시작일을 입력해주시기 바랍니다.");
                return false;
            }
            if($("#dateend").val() == ""){
                alert("Abbyy 라이선스 종료일을 입력해주시기 바랍니다.");
                return false;
            }
            if($("#datestart").val() >= $("#dateend").val()){
                alert("시작일과 종료일 날짜에 오류가 있습니다. 확인해보시기 바랍니다.");
                return false;
            }

            if($("#abbyyLicenseKey").val() == ""){
                alert("Abbyy 라이선스 Key를 입력하세요");
                return false;
            }

            if(confirm("ABBYY 라이선스를 <#if abbyy?? && abbyy.seq??>수정<#else>등록</#if> 하시겠습니까?")){
                var datas = $("#addForm").serialize();
                $.ajax({
                    <#if abbyy?? && abbyy.seq??>
                        url : "/abbyy/licenseModify",
                        <#else>
                        url : "/abbyy/registration",
                    </#if>
                    type : 'POST',
                    data : datas,
                    dataType : 'JSON',
                    success:function(response){
                        if(response.result){
                            alert("Abbyy 라이선스가 <#if abbyy?? && abbyy.seq??>수정<#else>등록</#if> 되었습니다.");
                            document.location.href="/abbyy/detail?seq="+response.seq;
                        }
                    }
                });
            }
        })

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
        //         $("#searchCom").blur();
        //
        //
        //         return false;
        //     }
        // })
        //     .autocomplete( "instance" )._renderItem = function( ul, item ) {
        //     // console.log(ul);
        //     ul.css("z-index","9999");
        //     return $( "<li>" )
        //         .append( item.comName )
        //         .appendTo( ul );
        // };
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
                data.phrase = $("#searchCom").val();
                return data;
            },

            requestDelay: 400
        };

        $("#searchCom").easyAutocomplete(options);
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