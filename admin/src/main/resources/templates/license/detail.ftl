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
                                    <li class="breadcrumb-item"><a href="/license/list">라이선스 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">라이선스 상세보기</li>
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
                    <input type="hidden" name="seq" id="seq" value="${license.seq?c}">
                    <input type="hidden" name="comUUid" id="comUUid" value="${license.comUUid!''}">
                    <div class="detail-display">
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">라이센스 타입</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <#if license.licenseType?number = 1>
                                        PC형
                                    <#elseif license.licenseType?number = 2>
                                        Cloud 형
                                    <#else>
                                        On-Premise형
                                    </#if>
                                </div>
                            </div>

                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">계약 번호</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <#if license.contractNumber??>${license.contractNumber}</#if>
                                    <#--<div class="text-info-mih">-->
                                        <#--&lt;#&ndash;  <small id="" class="form-text text-danger">* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.</small>  &ndash;&gt;-->
                                        <#--<!--  <small id="" class="form-text text-danger">* 아이디(이메일)을 입력해 주세요.</small>  &ndash;&gt;-->
                                    <#--</div>-->
                                </div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">Unattended Bot Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <#if license.countUnattended?exists>${license.countUnattended}<#else>0</#if>

                                </div>
                            </div>

                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">Attended Bot Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <#if license.countAttended?exists>${license.countAttended}<#else>0</#if>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">Studio Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <#if license.countStudio?exists>${license.countStudio}<#else>0</#if>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">WorkCenter Count</div>
                            </div>
                            <div class="col-9">
                                <div>
                                    <#if license.countWorkcenter?exists>${license.countWorkcenter}<#else>0</#if>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">상태</div>
                            </div>
                            <div class="col-9">

                                <div id="strStatus">

                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="text-center">
                            <button type="button" class="btn btn-primary btn-reg"
                                    data-target="<#if license.licenseType?number = 1>#mini-modal<#else>#work-modal</#if>"
                                    data-toggle="modal" data-licensetype="${license.licenseType!}" data-subscribetype="${license.subscribeType}" data-count1="<#if license.countUnattended??>${license.countUnattended?c}<#else>0</#if>" data-use1="<#if license.countUnAttendedUse??>${license.countUnAttendedUse?c}<#else>0</#if>" data-count2="<#if license.countAttended??>${license.countAttended?c}<#else>0</#if>" data-use2="<#if license.countAttendedUse??>${license.countAttendedUse?c}<#else>0</#if>" data-count3="<#if license.countStudio??>${license.countStudio?c}<#else>0</#if>" data-use3="<#if license.countStudioUse??>${license.countStudioUse?c}<#else>0</#if>" data-count4="<#if license.countWorkcenter??>${license.countWorkcenter?c}<#else>0</#if>" data-use4="<#if license.countWorkcenterUse??>${license.countWorkcenterUse?c}<#else>0</#if>">라이선스 사용 등록</button> <!--button type="button" class="btn btn-primary" id="licenseEmail">라이선스 이메일 발송</button-->
                        </div>
                    </div>

                </form>

                </div>
                <div class="text-center">
                    <button class="btn btn-primary min-width120" type="button" onclick="document.location.href='/license/list'">목록</button>
                </div>
                <div class="mt-5">
                    <table class="table">
                        <colgroup>
                            <col width="60px">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <span>No</span>
                            </th>
                            <th scope="col">
                                <span>발급일</span>
                            </th>
                            <th scope="col">
                                <span>라이선스 이름</span>

                            </th>

                            <#if license.licenseType?number = 1 >
                            <th scope="col">
                                <span>발급 Mac Address</span>
                            </th>
                            <#else>
                                <th scope="col">
                                    <span>com UUID</span>
                                </th>
                            </#if>
                            <th scope="col">
                                <span>상태</span>
                            </th>
                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <#if comLicenseTotal?number gt 0>
                            <#list comLicenseUses as row>
                                <#assign no = comLicenseTotal-row_index>
                                <tr >
                                    <td style="cursor: pointer" >${no}</td>
                                    <td style="cursor: pointer" ><#if row.createDatetime??>${row.createDatetime?string["yyyy-MM-dd"]}</#if></td>
                                    <td style="cursor: pointer" >${row.licenseName}</td>
                                    <td style="cursor: pointer" ><#if row.macAddress??>${row.macAddress}<#else>${row.comUuid!}</#if></td>
                                    <td style="cursor: pointer" >
                                        <#if row.status = 0>
                                            사용가능
                                        <#else>
                                            사용불가
                                        </#if>
                                    </td>
                                    <td>
                                        <#--<div class="btn-group btn-group-action">-->
                                            <#--<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">-->
                                                <#--<i class="icon-navigation-more font12"></i>-->
                                            <#--</button>-->
                                            <#--<div class="dropdown-menu">-->
                                                <#--<button type="button" class="dropdown-item licenseStatus" data-seq="${row.seq}" data-status="${row.status}">-->
                                                    <#--<i class="icon-window-new mr-2"></i>-->
                                                    <#--<#if row.status?exists>-->
                                                        <#--<#if row.status?number = 0>-->
                                                            <#--사용불가로 변경-->
                                                        <#--<#else>-->
                                                            <#--사용가능으로 변경-->
                                                        <#--</#if>-->
                                                    <#--<#else>-->
                                                        <#--사용가능으로 변경-->
                                                    <#--</#if>-->
                                                <#--</button>-->
                                                <#--&lt;#&ndash;<button type="button" class="dropdown-item" data-seq="${row.seq}">&ndash;&gt;-->
                                                    <#--&lt;#&ndash;<i class="icon-layers mr-2"></i>삭제&ndash;&gt;-->
                                                <#--&lt;#&ndash;</button>&ndash;&gt;-->
                                                <#--<button type="button" class="dropdown-item reDownload" data-seq="${row.seq}" data-status="${row.status}">-->
                                                    <#--<i class="icon-window-new mr-2"></i>다운로드-->
                                                <#--</button>-->
                                                <#--<button type="button" class="dropdown-item reDownloadOld" data-seq="${row.seq}" data-status="${row.status}">-->
                                                    <#--<i class="icon-window-new mr-2"></i>V1.0.1 다운로드-->
                                                <#--</button>-->
                                                <#--<button type="button" class="dropdown-item reMailSend" data-seq="${row.seq}" data-status="${row.status}">-->
                                                    <#--<i class="icon-layers mr-2"></i>메일발송-->
                                                <#--</button>-->
                                            <#--</div>-->
                                        <#--</div>-->
                                        <div class="more-action-dropdown">
                                            <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>
                                            <div class="more-action-dropdown-content" style="top:-163px">
                                                <button type="button" class="more-action-item licenseStatus"  data-seq="${row.seq?c}" data-status="${row.status}">
                                                    <i class="icon-compose mr-2"></i>
                                                    <#if row.status?exists>
                                                    <#if row.status?number = 0>
                                                    사용불가로 변경
                                                    <#else>
                                                    사용가능으로 변경
                                                    </#if>
                                                    <#else>
                                                    사용가능으로 변경
                                                    </#if>
                                                </button>
                                                <#--<button type="button" class="more-action-item" data-seq="${row.seq}">-->
                                                <#--<i class="icon-layers mr-2"></i>삭제-->
                                                <#--</button>-->
                                                <button type="button" class="more-action-item reDownload" data-seq="${row.seq?c}" data-status="${row.status}">
                                                <i class="icon-window-new mr-2"></i>다운로드
                                                </button>
                                                <button type="button" class="more-action-item reDownloadOld" data-seq="${row.seq?c}" data-status="${row.status}">
                                                <i class="icon-window-new mr-2"></i>V1.0.1 다운로드
                                                </button>
                                                <button type="button" class="more-action-item reMailSend" data-seq="${row.seq?c}" data-status="${row.status}">
                                                <i class="icon-layers mr-2"></i>메일발송
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </#list>
                        <#else>
                            <tr>
                                <td colspan="9" align="center">사용신청된 라이선스가 없습니다.</td>
                            </tr>
                        </#if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="work-modal" tabindex="-1" role="dialog" aria-labelledby="comUserModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">라이선스 사용 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0" >
                <form id="writeForm">
                    <input type="hidden" name="licenseSeq" value="${license.seq?c}">
                    <input type="hidden" name="comUuid" id="wccomUuid" value="">
                    <input type="hidden" id="limit1" >
                    <input type="hidden" id="limit2" >
                    <input type="hidden" id="limit3" >
                    <input type="hidden" id="limit4" >
                    <input type="hidden" id="checkLicenseType" value="${license.licenseType}">
                    <input type="hidden" id="checkSubscribeType" value="${license.subscribeType}">
                    <div id="contentMain" class="input-display pt-5 pb-5 pl-3 pr-4" style="overflow:hidden">
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">License Name</div>
                            </div>
                            <div class="col-7">

                                <input type="text" class="form-control input-form " name="licenseName" id="licenseName" placeholder="" required=""
                                       value="" maxlength="20">
                                <div class="text-info-mih">
                                    <small id="licenseNameStr" class="form-text text-danger" style="display: none"></small>
                                </div>

                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">Organization</div>
                            </div>
                            <div class="col-7" id="modalFile">
                                <#--<div class="custom-file">-->
                                    <#--<input type="file" class="custom-file-input" name="comUuidFile" id="comUuidFile" placeholder="" required=""-->
                                           <#--value="">-->
                                    <#--<label id=“fileLabel” class=“custom-file-label” for=“comUuidFile”>이미지 파일을 첨부해 주세요</label>-->
                                <#--</div>-->


                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">Unattended Bot Count</div>
                            </div>
                            <div class="col-7">

                                <input type="text" class="form-control input-form" name="countUnattended" id="countUnattended" placeholder="" required=""
                                       value="" maxlength="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('1')">
                                <div class="text-info-mih">
                                    <small id="countUnattended" class="form-text text-danger" style="display: none"></small>
                                </div>

                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">Attended Bot Count</div>
                            </div>
                            <div class="col-7">

                                <input type="text" class="form-control input-form" name="countAttended" id="countAttended" placeholder="" required=""
                                       value="" maxlength="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('2')">
                                <div class="text-info-mih">
                                    <small id="countAttended" class="form-text text-danger" style="display: none"></small>
                                </div>

                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">Studio Count</div>
                            </div>
                            <div class="col-7">

                                <input type="text" class="form-control input-form" name="countDeveloper" id="countDeveloper" placeholder="" required=""
                                       value="" maxlength="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('3')">
                                <div class="text-info-mih">
                                    <small id="countDeveloper" class="form-text text-danger" style="display: none"></small>
                                </div>

                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">WorkCenter Count</div>
                            </div>
                            <div class="col-7">

                                <input type="text" class="form-control input-form" name="countWorkcenter" id="countWorkcenter" placeholder="" required=""
                                       value="" maxlength="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('4')">
                                <div class="text-info-mih">
                                    <small id="countWorkcenter" class="form-text text-danger" style="display: none"></small>
                                </div>

                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫 기</button>
                <button type="button" class="btn btn-info btn-wc-apply">신 청</button>
                <button type="button" class="btn btn-info btn-wc-apply_old">V1.0.1 신 청</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="mini-modal" tabindex="-1" role="dialog" aria-labelledby="comUserModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="comUserModalCenterTitle">라이선스 사용 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0">
                <form id="miniWriteForm">
                    <input type="hidden" name="licenseSeq" value="${license.seq?c}">
                    <input type="hidden" name="botType" value="1">
                    <div id="contentMain" class="input-display pt-5 pb-5 pl-3 pr-4" style="overflow:hidden">
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">License Name</div>
                            </div>
                            <div class="col-7">

                                <input type="text" class="form-control input-form " name="licenseName" id="mlicenseName" placeholder="" required=""
                                       value="" maxlength="20">
                                <div class="text-info-mih">
                                    <small id="mlicenseNameStr" class="form-text text-danger" style="display: none"></small>
                                </div>

                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div> -->
                        </div>
                        <div class="row">
                            <div class="col-3 d-flex justify-content-end align-items-center">
                                <div class="pl-2 pb-4 text-right">Mac Address</div>
                            </div>
                            <div class="col-7">
                                <input type="text" class="form-control input-form" name="macAddress" id="macAddress" placeholder="" required=""
                                       value="" maxlength="17">
                                <div class="text-info-mih">
                                    <small id="comNameChkText" class="form-text text-danger" style="display: none"></small>
                                </div>
                            </div>
                            <#--<div class="col-9"><button type="button" class="btn btn-light btn-comName-duple">중복확인</button></div>-->
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫 기</button>
                <button type="button" class="btn btn-info btn-mini-apply">신 청</button>
            </div>
        </div>
    </div>
</div>


<#include "/layout/base_script.ftl">
<script type="text/javascript" src="/assets/js/fileSaver.min.js"></script>
<!-- custom script 위치 -->
<script>
    $(function(){
        var startdate = '${comContract.contractStart?string["yyyy-MM-dd"]}';
        var enddate = '${comContract.contractEnd?string["yyyy-MM-dd"]}';
        var today = moment(new Date()).format("YYYY-MM-DD");
        var left1 = <#if license.countUnattended??>${license.countUnattended?c}<#else>0</#if> - ${license.countUnAttendedUse?c};
        var left2 = <#if license.countAttended??>${license.countAttended?c}<#else>0</#if> - ${license.countAttendedUse?c};
        var left3 = <#if license.countStudio??>${license.countStudio?c}<#else>0</#if> - ${license.countStudioUse?c};
        var left4 = <#if license.countWorkcenter??>${license.countWorkcenter?c}<#else>0</#if> - ${license.countWorkcenterUse?c};

        if(${license.licenseStatus!0} == 1 ) {
            // alert(1);
            $(".btn-reg").attr("disabled",true).css("background","#ccc").css("border","1px solid #ccc");
            $("#strStatus").html("관리자 사용불가 처리");
            // $(".btn-reg").data("target","");
        }else if(enddate != "" && enddate < today){
            $(".btn-reg").attr("disabled",true).css("background","#ccc").css("border","1px solid #ccc");
            $("#strStatus").html("계약기간 만료");
        }else if(left1 <= 0 && left2 <= 0 && left3 <= 0 && left4 <= 0){
            $(".btn-reg").attr("disabled",true).css("background","#ccc").css("border","1px solid #ccc");
            $("#strStatus").html("발급개수 부족");
        }else{
            $("#strStatus").html("사용가능");
        }

        $(".btn-wc-apply").click(function(){
            if($("#licenseName").val() == ""){
                alert("라이선스명을 입력해 주세요");
                return false;
            }
            if($("#comUuidFile").val() == ""){
                alert("Organization 파일을 업로드 해주시기 바랍니다.");
                return false;
            }

            if($("#checkLicenseType").val() == "2" && $("#checkSubscribeType").val() == "1"){
                if($("#countUnattended").val() == ""){
                    alert("Unattended Bot Count를 1개 이상 입력하시기 바랍니다.");
                    return false;
                }
                if($("#countUnattended").val() == 0){
                    alert("Unattended Bot Count를 1개 이상 입력하시기 바랍니다.");
                    return false;
                }
            }else{
                if($("#countUnattended").val() == "" && $("#countAttended").val() == "" && $("#countDeveloper").val() == "" && $("#countWorkcenter").val() == ""){
                    alert("1개 이상의 라이선스를 입력하시기 바랍니다.");
                    return false;
                }

                if($("#countUnattended").val() == 0 && $("#countAttended").val() == 0 && $("#countDeveloper").val() == 0 && $("#countWorkcenter").val() == 0){
                    alert("신청개수는 1개 이상이어야 합니다.");
                    return false;
                }

                if($("#countDeveloper").val() == 0 || $("#countDeveloper").val() == ""){
                    if($("#countWorkcenter").val() > 0){
                        alert("Studio 신청개수를 입력하시기 바랍니다.(WorkCenter는 단독으로 신청이 불가능합니다. Studio와 함께 신청해주세요");
                        return false;
                    }
                }
            }

            if($("#countDeveloper").val() == 0 || $("#countDeveloper").val() == ""){
                if($("#countWorkcenter").val() > 0){
                    alert("Studio 신청개수를 입력하시기 바랍니다.(WorkCenter는 단독으로 신청이 불가능합니다. Studio와 함께 신청해주세요");
                    return false;
                }
            }
            if(confirm("라이선스를 신청하시겠습니까?")){
                var datas = $("#writeForm").serialize();
                $.ajax({
                    url: "/license/license_apply",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            // alert("신청 되었습니다.");
                            <#--<#if email?exists && email != ''>-->
                            <#--if(confirm("파일을 이메일로 발송하시겠습니까?")){-->
                                <#--$.ajax({-->
                                    <#--url : "/license/mailSend",-->
                                    <#--type : 'POST',-->
                                    <#--data : "license="+response.license+"&email=${email!}",-->
                                    <#--dataType : 'JSON',-->
                                    <#--success:function(response){-->
                                        <#--console.log(response);-->
                                        <#--// var blob = new Blob([response.license], {type: "text/plain;charset=utf-8"});-->
                                        <#--// saveAs(blob, "license.txt");-->
                                        <#--alert("메일이 발송되었습니다.");-->
                                        <#--location.reload();-->
                                    <#--}-->
                                <#--});-->
                            <#--}else{-->
                                <#--var blob = new Blob([response.license], {type: "text/plain;charset=utf-8"});-->
                                <#--saveAs(blob, "license.license");-->
                                <#--location.reload();-->
                            <#--}-->
                            <#--<#else>-->
                            var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license_"+$("#licenseName").val()+".license");
                            // location.reload();
                            setTimeout(function () {
                                location.reload();
                            }, 500);
                            <#--</#if>-->
                        }else{
                            if(response.errorCode == "-1"){
                                alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                return false;
                            }else{
                                alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                            }

                        }
                    }
                });
            }
        })

        $(".btn-wc-apply_old").click(function(){
            if(confirm("V1.0.1 라이선스를 신청하시겠습니까?")){
                var datas = $("#writeForm").serialize();
                $.ajax({
                    url: "/license/license_apply_old",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        if(response.result){
                            // alert("신청 되었습니다.");

                            var blob = new Blob([response.license], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license.txt");
                            // location.reload();
                            setTimeout(function () {
                                location.reload();
                            }, 500);

                        }else{
                            alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                        }
                    }
                });
            }
        })

        $("body").on("change","#comUuidFile",function(){
            var inputFiles = this.files;
            if(inputFiles == undefined || inputFiles.length == 0) return;


            var file = inputFiles[0];
            //console.log(file);

            // 섬네일 생성
            var reader = new FileReader();
            reader.onload = function (event) {
                var contents = event.target.result;

                // console.log(contents);
                $("#wccomUuid").val(contents);
            };
            reader.readAsText(inputFiles[0]);
        })

        $(".btn-mini-apply").click(function(){
            var regex = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/;
            if($("#mlicenseName").val() == ""){
                alert("라이선스명을 입력해주세요");
                return false;
            }

            if($("#macAddress").val() == ""){
                alert("맥어드레스를 입력해주세요")
                return false;
            }

            if(!regex.test($("#macAddress").val())) {
                alert("Mac주소 형식에 알맞게 입력하세요\n(예 : aa-bb-cc-dd-ee-ff 또는 11:22:33:44:55:66)");
                return false;
            }
            if(confirm("라이선스를 신청하시겠습니까?")){
                var datas = $("#miniWriteForm").serialize();
                $.ajax({
                    url: "/license/license_serial_make",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            // alert("신청 되었습니다.");
                            <#--<#if email?exists && email != ''>-->
                            <#--if(confirm("파일을 이메일로 발송하시겠습니까?")){-->
                                <#--$.ajax({-->
                                    <#--url : "/license/mailSend",-->
                                    <#--type : 'POST',-->
                                    <#--data : "license="+response.license+"&email=${email!}",-->
                                    <#--dataType : 'JSON',-->
                                    <#--success:function(response){-->
                                        <#--console.log(response);-->
                                        <#--// var blob = new Blob([response.license], {type: "text/plain;charset=utf-8"});-->
                                        <#--// saveAs(blob, "license.txt");-->
                                        <#--alert("메일이 발송되었습니다.");-->
                                        <#--location.reload();-->
                                    <#--}-->
                                <#--});-->
                            <#--}else{-->
                                <#--var blob = new Blob([response.license], {type: "text/plain;charset=utf-8"});-->
                                <#--saveAs(blob, "license.license");-->
                                <#--location.reload();-->
                            <#--}-->
                            <#--<#else>-->
                            var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license_"+$("#mlicenseName").val()+".license");
                            // location.reload();
                            // setTimeout(function () {
                            //     location.reload();
                            // }, 500);
                            <#--</#if>-->
                        }else{
                            if(response.msg == "duple"){
                                alert("이미 등록된 mac address입니다.");
                                return false;
                            }else{
                                if(response.errorCode == "-1"){
                                    alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                    return false;
                                }else{
                                    alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                                }
                            }

                        }
                    }
                });
            }
        })

        $("body").on("click",".reDownload", function(){
            if(confirm("라이선스 파일을 다운로드 하시겠습니까?")) {
                var seq = $(this).data("seq");
                $.ajax({
                    url: "/license/re_download",
                    type: 'GET',
                    data: "seq=" + seq,
                    dataType: 'JSON',
                    success: function (response) {
                        console.log(response);
                        var blob = new Blob([response.data.license], {type: "text/plain;charset=utf-8"});
                        saveAs(blob, "license_"+response.data.licenseName+".license");
                        // setTimeout(function () {
                        //     location.reload();
                        // }, 500);
                        // location.reload();
                    }
                });
            }
        })

        $("body").on("click",".reDownloadOld", function(){
            if(confirm("v1.0.1 파일을 다운로드 하시겠습니까?")) {
                var seq = $(this).data("seq");
                $.ajax({
                    url: "/license/re_download_old",
                    type: 'GET',
                    data: "seq=" + seq,
                    dataType: 'JSON',
                    success: function (response) {
                        var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                        saveAs(blob, "license.txt");
                        // setTimeout(function () {
                        //     location.reload();
                        // }, 500);
                        // location.reload();
                    }
                });
            }
        })

        $("body").on("click",".reMailSend", function(){
            <#if email?exists && email != ''>
            if(confirm("라이선스 파일을 ${email!} 주소로 발송 하시겠습니까?")) {
                var seq = $(this).data("seq");
                $.ajax({
                    url: "/license/re_emailsend",
                    type: 'GET',
                    data: "seq=" + seq+"&email=${email!}",
                    dataType: 'JSON',
                    success: function (response) {
                        alert("발송되었습니다");
                    }
                });
            }
            <#else>
            alert("계약 사용자의 이메일이 등록되어 있지 않습니다.");
            return false;
            </#if>
        })

        $("body").on("click",".licenseStatus",function(){
            var status = $(this).data("status");
            var seq= $(this).data("seq");
            if(status == 0){
                var msg = "사용불가로 변경하시겠습니까?";
                var mStatus = 1;
            }else{
                var msg = "사용가능으로 변경하시겠습니까?";
                var mStatus = 0;
            }
            if(confirm(msg)) {
                var seq = $(this).data("seq");
                $.ajax({
                    url: "/license/change_status_use",
                    type: 'PUT',
                    data: "seq=" + seq+"&status="+mStatus,
                    dataType: 'JSON',
                    success: function (response) {
                        alert("변경되었습니다.");
                        document.location.reload();
                    }
                });
            }
        })

        $('#work-modal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget)
            // var licenseSeq = button.data("licenseseq");
            //
            // $("#checkLicenseType").val($(this).data("licensetype"));
            // $("#checkSubscribeType").val($(this).data("subscribetype"));
            var limit1 = parseInt(button.data("count1"))- parseInt(button.data("use1"));
            var limit2 = parseInt(button.data("count2"))- parseInt(button.data("use2"));
            var limit3 = parseInt(button.data("count3"))- parseInt(button.data("use3"));
            var limit4 = parseInt(button.data("count4"))- parseInt(button.data("use4"));
            console.log(limit1);
            $("#limit1").val(limit1);
            $("#limit2").val(limit2);
            $("#limit3").val(limit3);
            $("#limit4").val(limit4);

            if(button.data("licensetype") == "2" && button.data("subscribetype") == "1") {
                $("#countAttended").attr("readonly", "readonly");
                $("#countDeveloper").attr("readonly", "readonly");
                $("#countWorkcenter").attr("readonly", "readonly");
            }else if(button.data("licensetype") == "2" && button.data("subscribetype") == "3"){
                $("#countWorkcenter").attr("readonly", "readonly");
            }else{
                $("#countAttended").attr("readonly",false);
                $("#countDeveloper").attr("readonly",false);
                $("#countWorkcenter").attr("readonly",false);
            }
            var html = '<div class="custom-file">\
                            <input type="file" class="custom-file-input" name="comUuidFile" id="comUuidFile" required value="" data-width="200" data-height="200">\
                            <label id="fileLabel" class="custom-file-label" for="comUuidFile">Organization File을 첨부 하세요</label>\
                        </div>\
                        <div class="text-info-mih">\
                            <small id="comNameChkText" class="form-text text-danger" style="display: none"></small>\
                            </div>';
            $("#modalFile").html(html);
        });
    })
    function checkLimit(limit){
        // unattended
        if(limit == "1"){

            if(parseInt($("#limit1").val()) < parseInt($("#countUnattended").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit1").val()+"개 신청 가능합니다.");
                $("#countUnattended").val($("#limit1").val());
            }
        }

        if(limit == "2"){

            if(parseInt($("#limit2").val()) < parseInt($("#countAttended").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit2").val()+"개 신청 가능합니다.");
                $("#countAttended").val($("#limit2").val());
            }
        }
        if(limit == "3"){

            if(parseInt($("#limit3").val()) < parseInt($("#countDeveloper").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit3").val()+"개 신청 가능합니다.");
                $("#countDeveloper").val($("#limit3").val());
            }
        }

        if(limit == "4"){
            console.log($("#limit4").val()+"::"+$("#countWorkcenter").val());
            if(parseInt($("#limit4").val()) < parseInt($("#countWorkcenter").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit4").val()+"개 신청 가능합니다.");
                $("#countWorkcenter").val($("#limit4").val());
            }
        }
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">