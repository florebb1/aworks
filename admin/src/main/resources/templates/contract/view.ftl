<#include "/layout/base.ftl">

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
                                        <li class="breadcrumb-item"><a href="/contract/new_list">계약회사 관리</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">계약회사 상세</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col d-flex align-items-center justify-content-end">
                            </div>
                            <div class="col-auto">
                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="card">
                        <form id="writeForm">
                            <input type="hidden" name="seq" id="seq" value="<#if company??>${company.seq}</#if>">
                            <input type="hidden" name="contractStart" id="contractStart" value="${comContract.contractStart?string["yyyy-MM-dd"]}">
                            <input type="hidden" name="contractEnd" id="contractEnd" value="${comContract.contractEnd?string["yyyy-MM-dd"]}">
                            <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">
                                <div class="">
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">회사명</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div class="miw300">
                                                <div><#if company??>${company.comName}</#if></div>
                                            </div>  -->
                                            <#if company??>${company.comName}</#if>
                                        </div>
                                        <#--  <div class="col">
                                            <button type="button" class="btn btn-light btn-comName-duple">중복확인</button>
                                        </div>  -->
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">계약일 정보</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div class="">
                                                <div>${comContract.contractStart?string["yyyy-MM-dd"]}</div>
                                                <div>${comContract.contractEnd?string["yyyy-MM-dd"]}</div>
                                            </div>  -->
                                            ${comContract.contractStart?string["yyyy-MM-dd"]}
                                            ~
                                            ${comContract.contractEnd?string["yyyy-MM-dd"]}
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">계약 히스토리</div>
                                        </div>
                                        <div class="col-10">
                                            <div class="contHistory history-wrap"></div>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">정산 담당자 이름</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div class="miw300">
                                                <div>${company.serviceName}</div>
                                            </div>  -->
                                            ${company.serviceName}
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">정산 담당자 연락처</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div class="miw300">
                                                <div>${company.servicePhone}</div>
                                            </div>  -->
                                            ${company.servicePhone}
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">정산 담당자 이메일</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div class="miw300">
                                                <div>${company.serviceEmail}</div>
                                            </div>  -->
                                            ${company.serviceEmail}
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">계약 담당자 지정</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div>
                                                <#if company.userSeq??>
                                                    ${company.userName} (${company.loginId})
                                                <#else>
                                                    -
                                                </#if>
                                            </div>  -->
                                            <#if company.userSeq?? && company.userName??>${company.userName} (${company.loginId})<#else><#if company.userSeq??>${company.loginId}<#else>-</#if></#if>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-2">
                                            <div class="text-right font-w600">계약 상태</div>
                                        </div>
                                        <div class="col-10">
                                            <#--  <div>
                                                <#if company.status = 0>
                                                    계약진행
                                                <#else>
                                                    계약해지
                                                </#if>
                                            </div>  -->
                                            <#if company.status = 0>계약진행<#else>계약해지</#if>
                                            <div id="contractReasonFrom" style="display: none">
                                                <#if company.status = 1><#if company.contractReason??>${company.contractReason}</#if></#if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-info min-width120" type="button" onclick="document.location.href='/contract/list'">목록</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


<#include "/layout/base_script.ftl">

<script type="text/javascript">
    $(function(){

        /* DatePicker Script */
        $('#contractStart_m').datepicker({
            uiLibrary: 'bootstrap4',
            format: 'yyyy-mm-dd',
            footer: true,
            showOtherMonths: true
        });
        $('#contractEnd_m').datepicker({
            uiLibrary: 'bootstrap4',
            format: 'yyyy-mm-dd',
            footer: true,
            showOtherMonths: true
        });

        // 계약 해지 유무 체크 이벤트 (사유 노출 처리)
        var contStatus = ${company.status};
        if(contStatus == 1) $("#contractReasonFrom").css("display", "block");

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
                console.log(result[i].status);
                var contHistStart = getFormatDate(result[i].contractStart);
                var contHistEnd = getFormatDate(result[i].contractEnd);
                var contHistStatus = result[i].status;
                if(contHistStatus == 0) contHistStatus = "수정일:";
                else if(contHistStatus == 1) contHistStatus = "연장일:";
                else contHistStatus = "등록일:";
                var createDatetime = getFormatDate(result[i].createDatetime);
                data += contHistStart+" ~ "+contHistEnd+" ("+contHistStatus+" "+createDatetime+")";

            }
            $(".contHistory").html(data);
        });
    });
</script>

<#include "/layout/footer.ftl">