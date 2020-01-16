<#include "/layout/base.ftl">
<#import "../pagination.ftl" as pagination />
<#if license.downloadCount &lt;= 0>
    <#assign readonly = "">
<#else>
    <#assign readonly = "readonly">
</#if>
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
                                    <li class="breadcrumb-item"><a href="#">라이선스 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">라이선스 수정</li>
                                </ol>
                            </nav>
                        </div>
                        <#--<div class="col d-flex align-items-center justify-content-end">-->
                        <#--<p>전체 레포지토리 <span></span>개</p>-->
                        <#--</div>-->

                    </div>
                </div>

                <hr>

                <div class="card pt-5 pb-5">

                    <form id="addForm">
                        <input type="hidden" name="seq" id="seq" value="${license.seq}">
                        <input type="hidden" name="comUUid" id="comUUid" value="${license.comUUid!''}">
                        <input type="hidden" name="createDatetimeStr" id="createDatetimeStr" value="${license.createDatetime?string["yyyy-MM-dd"]}">
                        <input type="hidden" name="downloadCount" id="downloadCount" value="${license.downloadCount}">
                        <input type="hidden" name="licenseType" id="licenseType" value="${license.licenseType}">
                        <div class="detail-display">
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">라이센스 타입</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <#if license.licenseType?number = 0>
                                            Work Center
                                        <#elseif license.licenseType?number = 1>
                                            Mini
                                        <#else>
                                            Studio
                                        </#if>
                                    </div>
                                </div>

                            </div>
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">계약회원사 정보 검색</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" name="searchCom" id="searchCom" value="${license.comName!}" placeholder="" readonly>
                                        <input type="hidden" name="comSeq" id="comSeq" value="${license.comSeq!}" >
                                        <input type="hidden" name="comName" id="comName" value="${license.comName!}">
                                        <#--<button id="searchComBtn" class="form-control" type="button" onclick="fnSearchCom()">검색</button>-->
                                        <#--<div id="searchResult" <#if license.comSeq??><#else>style="display: none"</#if>>-->
                                        <#--<select class="custom-select mxw300" id="comList" name="comList">-->
                                        <#--<#if license.comSeq??>-->
                                        <#--<option value="${license.comSeq}" selected>${license.comName}</option>-->
                                        <#--</#if>-->
                                        <#--</select>-->
                                        <#--<input type="hidden" name="comSeq" id="comSeq" value="${license.comSeq}" >-->
                                        <#--<input type="text" class="form-control" name="comName" id="comName" value="${license.comName}" readonly>-->
                                        <#--</div>-->
                                        <#--<div class="text-info-mih">-->
                                        <#--<small id="searchResultChkText" class="form-text text-danger" style="display: none"></small>-->
                                        <#--</div>-->
                                    </div>
                                </div>

                            </div>

                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">Subscribe Type</div>
                                </div>
                                <div class="col-9">
                                    <div class="form-check form-check-inline">
                                        <input type="radio" id="subscribeType1" name="subscribeType" class="form-control" value="1"
                                                <#if license.subscribeType = 1>checked</#if> ${readonly}>
                                        <label class="form-check-label">종량제(사용량)</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="radio" id="subscribeType2" name="subscribeType" class="form-control" value="0"
                                                <#if license.subscribeType = 0>checked</#if> ${readonly}>
                                        <label class="form-check-label">정액제(연단위)</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">라이선스 이용일</div>
                                </div>
                                <div class="col-9">
                                    <div class="form-row">
                                        <div class="col">
                                            <input type="text" id="datestart" name="startDateStr" class="form-control" placeholder="날짜선택"
                                                value="<#if license.startDate?exists>${license.startDate?string["yyyy-MM-dd"]}<#else></#if>" readonly>
                                        </div>
                                        <div class="col-auto">~</div>
                                        <div class="col">
                                            <input type="text" id="dateend" name="endDateStr" class="form-control" placeholder="날짜선택"
                                                value="<#if license.endDate?exists>${license.endDate?string["yyyy-MM-dd"]}<#else></#if>" readonly>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">Unattended Bot Count</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" id="countUnattended" name="countUnattended" placeholder="" required="" value="<#if license.countUnattended??>${license.countUnattended?c}<#else>0</#if>" ${readonly}>

                                    </div>
                                </div>

                            </div>
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">Attended Bot Count</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" id="countAttended" name="countAttended" placeholder="" required="" value="<#if license.countAttended??>${license.countAttended?c}<#else>0</#if>" ${readonly}>

                                    </div>
                                </div>

                            </div>
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">Developer Count</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" id="countDeveloper" name="countDeveloper" placeholder="" required="" value="<#if license.countDeveloper??>${license.countDeveloper?c}<#else>0</#if>" ${readonly}>

                                    </div>
                                </div>

                            </div>
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">Unattended Bot Price</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" id="priceUnattended" name="priceUnattended" placeholder="" required="" value="<#if license.priceUnattended??>${license.priceUnattended?c}<#else>0</#if>" ${readonly}>
                                    </div>
                                </div>

                            </div>
                            <div class="row mb-4">
                                <div class="col-3">
                                    <div class="text-right font-w600">Attended Bot Price</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" id="priceAttended" name="priceAttended" placeholder="" required="" value="<#if license.priceAttended??>${license.priceAttended?c}<#else>0</#if>" ${readonly}>
                                    </div>
                                </div>

                            </div>
                            <div class="row mb-5">
                                <div class="col-3">
                                    <div class="text-right font-w600">Developer Bot Price</div>
                                </div>
                                <div class="col-9">
                                    <div class="miw300">
                                        <input type="text" class="form-control" id="priceDeveloper" name="priceDeveloper" placeholder="" required="" value="<#if license.priceDeveloper??>${license.priceDeveloper?c}<#else>0</#if>" ${readonly}>
                                    </div>
                                </div>

                            </div>

                            <hr>


                            <#--<div class="row mb-4">-->
                            <#--<div class="col-3">-->
                            <#--<div class="text-right font-w600">상태</div>-->
                            <#--</div>-->
                            <#--<div class="col-3">-->
                            <#--<div class="miw300">-->
                            <#--<select name="status" id="status">-->
                            <#--<option value="0" <#if license.status?number = 0>selected</#if>>신청</option>-->
                            <#--<option value="1" <#if license.status?number = 1>selected</#if>>발급완료</option>-->

                            <#--</select>-->
                            <#--</div>-->
                            <#--</div>-->

                            <#--</div>-->
                            <div class="text-center">
                                <button type="button" class="btn btn-primary min-width120" id="licenseModify">라이선스 수정</button>
                            </div>
                        </div>
                    </form>

                </div>

            </div>
        </div>
    </div>

</div>

<#include "/layout/base_script.ftl">

<!-- custom script 위치 -->
<script>
    $(function(){

        // 계약회원사 검색 이벤트 캐치
        $("#searchCom").on({
            keyup: function() {
                $("searchResultChkText").text("");
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

        $("#licenseModify").click(function(){
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
            if(confirm("라이선스를 수정하시겠습니까?")){
                var datas = $("#addForm").serialize();
                $.ajax({
                    url : "/license/modify",
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
                            alert("라이선스가 수정되었습니다.");
                            document.location.href="/license/detail?seq="+response.seq;
                        }
                    }
                });
            }
        })
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