<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<div class="sub-title-bg background-base-code background-h4">
    계약관리
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>계약정보관리</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>계약관리<i class="icon-cheveron-right"></i>계약정보관리</h5>
            </div>
        </div>
        <hr class="mt-1 mb-5">
    </div>
</section>

<section class="place-wrap-top-none">  -->
<section class="place-wrap">
    <div class="container">

        <!-- 계약회원이 아닐경우 -->
        <!-- <div class="row">
            <div class="col d-flex flex-column justify-content-center align-items-center minh-480">
                <p>대단히 죄송합니다.</p>
                <p>홍길동님은 비계약회원 입니다.</p>
                <p>계약정보는 라이선스 구매후 확인할 수 있습니다.</p>
                <a href="#" class="btn btn-outline-info btn-round mt-4">이용 및 구매방법 바로가기</a>
            </div>
        </div> -->
        <!-- 계약회원이 아닐경우 끝 -->

        <!-- 계약회원일경우 -->
        <div class="row">
            <div class="col-12 d-flex flex-row justify-content-center align-items-center cs-menu-wrap">
                <#--  <a href="/mypage/contract_management" class="cs-menu">대시보드</a>  -->
                <a href="/mypage/contract_management_info" class="cs-menu active">계약정보관리</a>
                <a href="/mypage/contract_management_license" class="cs-menu">라이선스관리</a>
                <#--  <a href="/mypage/contract_management_abbyy" class="cs-menu">ABBYY관리</a>  -->
                <a href="/mypage/contract_management_download" class="cs-menu">다운로드</a>
            </div>

            <div class="col-12 card mt-5 p-5">
                        <div class="mb-5">
                            <div class="border p-3">
                                <form id="addForm">
                                    <div class="detail-display">
                                        <div class="row mt-3">
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
                                                        <div class="text-right font-w600">계약명</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div>${comContract.contractName!}</div>
                                                    </div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">상태</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div>
                                                            <#if comContract.contractStatus?number = 1>
                                                                대기
                                                            <#elseif comContract.contractStatus?number = 2>
                                                                사용
                                                            <#else>
                                                                종료
                                                            </#if>
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
                        </div>




                        <div class="mb-5 minh-240">
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
                                            ${row_index+1}
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
                                        <td>${row.countUnattended}</td>
                                        <td>${row.unattendedLicenseListPrice}</td>
                                        <td>${row.countAttended}</td>
                                        <td>${row.attendedLicenseListPrice}</td>
                                        <td>${row.countStudio}</td>
                                        <td>${row.studioLicenseListPrice}</td>
                                        <td>${row.countWorkcenter}</td>
                                        <td>${row.workcenterLicenseListPrice}</td>

                                        <#--                                <td>${row.comContractCode}</td>-->
                                        <#--                                <td>-->
                                        <#--                                    <#if row.licenseType?number = 1>-->
                                        <#--                                        Node-Locked License-->
                                        <#--                                    <#elseif row.licenseType?number = 2>-->
                                        <#--                                        Floating License on Cloud-->
                                        <#--                                    <#else>-->
                                        <#--                                        Floating License on Premise-->
                                        <#--                                    </#if>-->
                                        <#--                                </td>-->
                                        <#--                                <td>${row.countUnattended!'-'}</td>-->
                                        <#--                                <td>${row.countAttended!'-'}</td>-->
                                        <#--                                <td>${row.countDeveloper!'-'}</td>-->
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>

                        <#--                        <div class="col-11 mt-5 mb-5">-->
                        <#--                            <table class="table">-->
                        <#--                                <colgroup>-->
                        <#--                                    <col width="30px">-->
                        <#--                                    <col>-->
                        <#--                                </colgroup>-->
                        <#--                                <thead>-->
                        <#--                                <tr>-->
                        <#--                                    <th scope="col">-->
                        <#--                                        <div class="form-check">-->
                        <#--                                            <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">-->
                        <#--                                        </div>-->
                        <#--                                    </th>-->
                        <#--                                    <th scope="col">계약번호</th>-->
                        <#--                                    <th scope="col">계약 시작일</th>-->
                        <#--                                    <th scope="col">계약 과금 정책</th>-->
                        <#--                                    <th scope="col">UnAttended 금액</th>-->
                        <#--                                    <th scope="col">Attended 금액</th>-->
                        <#--                                    <th scope="col">Develop 금액</th>-->
                        <#--                                </tr>-->
                        <#--                                </thead>-->
                        <#--                                <tbody id="licenseList">-->
                        <#--                                    <#list comContract as row>-->
                        <#--                                        <tr>-->
                        <#--                                            <td><input type="checkbox"></td>-->
                        <#--                                            <td>${row.comContractCode}</td>-->
                        <#--                                            <td>${row.contractStart?string["yyyy-MM-dd"]}</td>-->
                        <#--                                            <td>-->
                        <#--                                                <#if row.subscribeType?number = 0>-->
                        <#--                                                    Hour-->
                        <#--                                                <#elseif row.subscribeType?number = 1>-->
                        <#--                                                    Month-->
                        <#--                                                <#else>-->
                        <#--                                                    Annual-->
                        <#--                                                </#if>-->
                        <#--                                            </td>-->
                        <#--                                            <td>${row.priceUnattended!}</td>-->
                        <#--                                            <td>${row.priceAttended!}</td>-->
                        <#--                                            <td>${row.priceDeveloper!}</td>-->
                        <#--                                        </tr>-->
                        <#--                                    </#list>-->
                        <#--                                </tbody>-->
                        <#--                            </table>-->
                        <#--                        </div>-->
        </div>
        <!-- 계약회원일경우 끝 -->

    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(document).ready(function() {
        $('#contractBtn').click(function(){
            var comName = $('#companyName').val();
            var serviceName = $('#serviceName').val();
            var servicePhone = $('#servicePhone').val();
            var serviceEmail = $('#serviceEmail').val();
            var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            var phoneRegExp = /^\d{3}\d{3,4}\d{4}$/;
            if(!isEmpty(comName)) {
                alert('회사명 또는 단체, 개인명을 입력해 주세요.');
                return false
            }else if(!isEmpty(serviceName)) {
                alert('정산 담당자명이 존재하지 않습니다.');
                return false
            }else if(!isEmpty(servicePhone)) {
                alert('정산 담당자의 연락처가 존재하지 않습니다.');
                return false
            }else if(!phoneRegExp.test(servicePhone)) {
                alert('정산 담당자 연락처 형식이 옯바르지 않습니다.');
                return false
            }else if(!isEmpty(serviceEmail)) {
                alert('정산 담당자의 이메일이 존재하지 않습니다.');
                return false
            }else if(!emailRegExp.test(serviceEmail)) {
                alert('정산 담당자 이메일 형식이 옳바르지 않습니다.');
                return false
            }
            var datas = $("#contractForm").serialize();
            $.ajax({
                url: "/api/contractEdit",
                type: 'GET',
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    if(response.result == true) {
                        alert("계약정보가 저장되었습니다.");
                        location.reload();
                    }else {
                        alert("계약정보 저장중 에러가 발생하였습니다. 관리자에게 문의하세요.");
                    }
                }
            });
        });
    });
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">