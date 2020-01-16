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
                                    <li class="breadcrumb-item"><a href="/contract/new_list"><#if company??>${company.comName!''}</#if> 계약 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">계약 생성</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="contractForm">
                    <div class="card p-4">
                        <div class="row">
                            <div class="col-6">
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">계약번호</div></div>
                                    <div class="w-70"><input type="text" name="contractNumber" id="contractNumber" value="" class="form-control form-control-sm" maxlength="20" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">회사명</div></div>
                                    <div class="w-70">
                                        <select name="comSeq" id="comSeq" class="form-control form-control-sm">
                                            <option value="">회사를 선택하세요</option>
                                            <#list companies as com>
                                                <option value="${com.seq?c}" <#if selectComSeq??><#if selectComSeq?c?number = com.seq?c?number>selected</#if></#if>>${com.comName}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">계약명</div></div>
                                    <div class="w-70"><input type="text" name="contractName" id="contractName" value="" class="form-control form-control-sm" maxlength="45"></div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">시작일</div></div>
                                    <div class="w-70">
                                        <input type="text" name="contractStart" id="datestart" value="" class="form-control form-control-sm" readonly style="background:#fff" placeholder="날짜를 선택하세요">
                                    </div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">종료일</div></div>
                                    <div class="w-70"><input type="text" id="dateend" name="contractEnd" value="" class="form-control form-control-sm" readonly style="background:#fff" placeholder="날짜를 선택하세요"></div>
                                </div>
                                <hr>

                            </div>
                            <div class="col-6">
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">계약담당자</div></div>
                                    <div class="w-70"><input type="text" name="contractChargerName" value="" id="searchUser" class="form-control form-control-sm" maxlength="10"></div>
                                    <input type="hidden" name="userSeq" id="userSeq" value="" >
                                    <input type="hidden" name="userName" id="userName" value="">
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">담당자 E-mail</div></div>
                                    <div class="w-70"><input type="email" name="contractChargerEmail" id="contractChargerEmail" value="" class="form-control form-control-sm" readonly></div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">담당자 연락처</div></div>
                                    <div class="w-70"><input type="text" name="contractChargerPhone" id="contractChargerPhone"  value="" class="form-control form-control-sm" readonly></div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">상태</div></div>
                                    <div class="w-70">
                                        <input type="text" id="contractStatus" class="form-control form-control-sm" readonly value="대기">

                                    </div>
                                </div>
                                <div class="d-flex justify-content-center align-items-center mb-2">
                                    <div class="w-30 pr-2"><div class="text-right">ICT 계약담당자</div></div>
                                    <div class="w-70"><input type="text" name="contractIctName" id="contractIctName" value="" class="form-control form-control-sm"></div>
                                </div>
                                <hr class="my-4">
                                <div class="row mt-2">
                                    <div class="col-12 text-right"><button type="button" class="btn btn-primary min-width120 btn-make">계약 생성</button></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="licenseList">
                        <div class="licenseDetail card p-4">
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width120 pr-2"><div class="text-right">계약 종류</div></div>
                                <div class="flex-grow-1">

                                    <select name="contractType" class="form-control form-control-sm">
                                        <option value="1">Pilot</option>
                                        <option value="2">PoC</option>
                                        <option value="3">본사업</option>
                                    </select>
                                </div>
                                <div class="min-width120 pr-2"><div class="text-right">라이선스 종류</div></div>
                                <div class="flex-grow-1">

                                    <select name="licenseType" class="form-control form-control-sm licenseType">
                                        <option value="1">PC형</option>
                                        <option value="2">Cloud형</option>
                                        <option value="3">On-Premise형</option>
                                    </select>
                                </div>
                                <div class="min-width120 pr-2"><div class="text-right">계약과금 종류</div></div>
                                <div class="flex-grow-1">

                                    <select name="subscribeType" id="subscribeType" class="form-control form-control-sm subscribeType">
                                        <option value="3">Annual</option>

                                    </select>
                                </div>
                            </div>
                            <hr class="mb-4">

                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">UnAttended 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="unattendedLicensePrice1" name="unattendedLicensePrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm unprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="unattendedLicenseListPrice1" name="unattendedLicenseListPrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm unlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="unattendedLicensePercent" readonly value="" placeholder="" class="form-control form-control-sm unper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="unAttendedCount1" name="unAttendedCount" value="0" placeholder="수량을 입력하세요" class="form-control form-control-sm uncount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>
                            </div>
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">Attended 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedLicensePrice1" name="attendedLicensePrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm atprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedLicenseListPrice1" name="attendedLicenseListPrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm atlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm atper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedCount1" name="attendedCount" value="" placeholder="수량을 입력하세요" class="form-control form-control-sm atcount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                            </div>
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">Studio 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioLicensePrice1" name="studioLicensePrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm stprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioLicenseListPrice1" name="studioLicenseListPrice" value="" placeholder="금액을 입력하세요" class="form-control form-control-sm stlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm stper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioCount1" name="studioCount" value="" placeholder="수량을 입력하세요" class="form-control form-control-sm stcount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                            </div>
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">WorkCenter 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterLicensePrice1" name="workcenterLicensePrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm wcprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterLicenseListPrice1" name="workcenterLicenseListPrice" value="0" placeholder="금액을 입력하세요" class="form-control form-control-sm wclistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm wcper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterCount1" name="workcenterCount" value="0" placeholder="수량을 입력하세요" class="form-control form-control-sm wccount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" readonly></div>
                            </div>
                            <hr>
                            <div class="row mt-2">
                                <div class="col-12 text-right"><button type="button" class="btn btn-primary min-width120 licenseAdd">추가</button></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>

<#include "/layout/base_script.ftl">
<link rel="stylesheet" href="/assets/css/easy-autocomplete.min.css"/>
<script src="/assets/js/jquery.easy-autocomplete.min.js"></script>
<script src="/assets/js/page/contract/contractWrite.js"></script>
<!-- custom script 위치 -->


<!-- custom script 끝 -->
<#include "/layout/footer.ftl">