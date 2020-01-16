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
                                    <li class="breadcrumb-item"><a href="/contract/new_list">계약 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">상세 내용</li>
                                </ol>
                            </nav>
                        </div>
                        <#--<div class="col d-flex align-items-center justify-content-end">-->
                        <#--<p>전체 레포지토리 <span></span>개</p>-->
                        <#--</div>-->

                    </div>
                </div>

                <hr>

                <div class="card pt-3 pb-2 mb-5">

                    <form id="addForm">
                        <div class="detail-display">

                            <div class="row mb-3">
                                <div class="col-6">
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">계약번호</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractNumber!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">회사명</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.comName!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">계약명</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractName!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">시작일</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractStart?string["yyyy년 MM월 dd일"]}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">종료일</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractEnd?string["yyyy년 MM월 dd일"]}</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">계약담당자</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.userName!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">담당자 E-mail</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.loginId!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">담당자 연락처</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.userPhone}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">상태</div>
                                        </div>
                                        <div class="col-8">
                                            <div id="currentStatus">

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <div class="text-right font-w600">ICT 계약담당자</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractIctName}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </form>

                </div>
                <div class="mt-5">
                    <p>라이선스 목록</p>
                    <table class="table">
                        <colgroup>
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">
                                    <span>No</span>
                                </th>
                                <th scope="col">
                                    <span>계약 종류</span>
                                </th>
                                <th scope="col">
                                    <span>라이선스 종류</span>
                                </th>
                                <th scope="col">
                                    <span>과금종류</span>
                                </th>
                                <th scope="col">
                                    <span>UnAttended 수량</span>
                                </th>
                                <th scope="col">
                                    <span>UnAttended Price</span>
                                </th>
                                <th scope="col">
                                    <span>Attended 수량</span>
                                </th>
                                <th scope="col">
                                    <span>Attended Price</span>
                                </th>
                                <th scope="col">
                                    <span>Studio 수량</span>
                                </th>
                                <th scope="col">
                                    <span>Studio Price</span>
                                </th>
                                <th scope="col">
                                    <span>WorkCenter 수량</span>
                                </th>
                                <th scope="col">
                                    <span>WorkCenter Price</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        <#list comLicense as row>
                            <tr>
                                <td>
                                    ${comLicense?size - row_index}
                                </td>
                                <td>
                                    <#if row.contractType?number = 1>
                                        Pilot
                                    <#elseif row.contractType?number = 2>
                                        PoC
                                    <#else>
                                        본사업
                                    </#if>
                                </td>
                                <td>
                                    <#if row.licenseType?number = 1>
                                        PC형
                                    <#elseif row.licenseType?number = 2>
                                        Colud형
                                    <#else>
                                        On-Premise형
                                    </#if>
                                </td>
                                <td>
                                    <#if row.subscribeType?number = 1>
                                        Hour
                                    <#elseif row.subscribeType?number = 2>
                                        Month
                                    <#else>
                                        Annual
                                    </#if>
                                </td>
                                <td>${row.countUnattended!0}</td>
                                <td>${row.unattendedLicenseListPrice!0}</td>
                                <td>${row.countAttended!0}</td>
                                <td>${row.attendedLicenseListPrice!0}</td>
                                <td>${row.countStudio!0}</td>
                                <td>${row.studioLicenseListPrice!0}</td>
                                <td>${row.countWorkcenter!0}</td>
                                <td>${row.workcenterLicenseListPrice!0}</td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(function() {
        var startdate = '${comContract.contractStart?string["yyyy-MM-dd"]}';
        var enddate = '${comContract.contractEnd?string["yyyy-MM-dd"]}';
        var today = moment(new Date()).format("YYYY-MM-DD");
        if (enddate != "" && enddate < today) {
            $("#currentStatus").html("종료");
        } else if (startdate != "" && startdate > today) {
            $("#currentStatus").html("대기");
        } else if (enddate != "" && enddate >= today && startdate != "" && startdate <= today) {
            $("#currentStatus").html("사용");
        } else {
            $("#currentStatus").html("대기");
        }
    });
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">