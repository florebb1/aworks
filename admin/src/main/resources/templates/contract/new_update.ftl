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
                                    <li class="breadcrumb-item"><a href="/contract/new_list"> 계약 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">계약 수정</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <hr>

                <div class="card pt-3 pb-2 mb-5">

                    <form id="addForm">
                        <div class="detail-display">

                            <div class="row mb-3">
                                <div class="col-6">
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">계약번호</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractNumber!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">회사명</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.comName!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">계약명</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractName!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">시작일</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractStart?string["yyyy년 MM월 dd일"]}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">종료일</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractEnd?string["yyyy년 MM월 dd일"]}</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">계약담당자</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.userName!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">담당자 E-mail</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.loginId!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">담당자 연락처</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.userPhone!}</div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">상태</div>
                                        </div>
                                        <div class="col-8">
                                            <div class="currentStatus">

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-4">
                                            <div class="text-right font-w600">ICT 담당자</div>
                                        </div>
                                        <div class="col-8">
                                            <div>${comContract.contractIctName}</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="w-100"></div>
                                <div class="col text-right">
                                    <hr>
                                    <button type="button" class="btn btn-primary min-width120" data-toggle="modal" data-target="#modifyModal" data-seq="${comContract.seq?c}" data-contractnumber="${comContract.contractNumber!}" data-comseq="${comContract.comSeq?c}" data-contractname="${comContract.contractName!}" data-userseq="${comContract.userSeq?c}" data-contractstatus="${comContract.contractStatus!}" data-contractchargername="${comContract.userName}" data-contractchargeremail="${comContract.loginId}" data-contractchargerphone="${comContract.userPhone}" data-contractictname="${comContract.contractIctName}" data-contractstart="${comContract.contractStart?string["yyyy-MM-dd"]}" data-contractend="${comContract.contractEnd?string["yyyy-MM-dd"]}">변경</button>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
                <form id="updateForm">
                    <input type="hidden" name="comContractSeq" value="${comContract.seq?c}">
                <div id="licenseList">
                    <#if count &gt; 0>
                        <#list comLicenses as row>

                        <input type="hidden" name="seq" value="${row.seq?c}">
                        <div class="licenseDetail card p-4">
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width120 pr-2"><div class="text-right">계약 종류</div></div>
                                <div class="flex-grow-1">

                                    <select name="contractType" class="form-control form-control-sm">
                                        <option value="1" <#if row.contractType?number = 1>selected</#if> >Pilot</option>
                                        <option value="2" <#if row.contractType?number = 2>selected</#if> >PoC</option>
                                        <option value="3" <#if row.contractType?number = 3>selected</#if> >본사업</option>
                                    </select>
                                </div>
                                <div class="min-width120 pr-2"><div class="text-right">라이선스 종류</div></div>
                                <div class="flex-grow-1">

                                    <select name="licenseType" class="form-control form-control-sm licenseType">
                                        <option value="1" <#if row.licenseType?number = 1>selected</#if> >PC형</option>
                                        <option value="2" <#if row.licenseType?number = 2>selected</#if> >Cloud형</option>
                                        <option value="3" <#if row.licenseType?number = 3>selected</#if> >On-Premise형</option>
                                    </select>
                                </div>
                                <div class="min-width120 pr-2"><div class="text-right">계약과금 종류</div></div>
                                <div class="flex-grow-1">

                                    <select name="subscribeType" class="form-control form-control-sm subscribeType">
                                        <#if row.licenseType?number = 2>
                                            <option value="1" <#if row.subscribeType?number = 1>selected</#if> >Hour</option>
                                            <option value="3" <#if row.subscribeType?number = 3>selected</#if> >Annual</option>
                                        <#else>
                                            <option value="3" <#if row.subscribeType?number = 3>selected</#if> >Annual</option>
                                        </#if>
                                    </select>
                                </div>
                            </div>
                            <hr class="mb-4">

                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">UnAttended 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="unattendedLicensePrice1" name="unattendedLicensePrice" value="${row.unattendedLicensePrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm unprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" <#if row.licenseType?number = 1>readonly</#if> ></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="unattendedLicenseListPrice1" name="unattendedLicenseListPrice" value="${row.unattendedLicenseListPrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm unlistprice" maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" <#if row.licenseType?number = 1>readonly</#if>></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="unattendedLicensePercent" readonly value="" placeholder="" class="form-control form-control-sm unper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="unAttendedCount1" name="unAttendedCount" value="${row.countUnattended?c}" placeholder="수량을 입력하세요" class="form-control form-control-sm uncount" maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" <#if row.licenseType?number = 1>readonly</#if>></div>
                            </div>
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">Attended 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedLicensePrice1" name="attendedLicensePrice" value="${row.attendedLicensePrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm atprice" <#if row.subscribeType?number = 1>readonly</#if> maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedLicenseListPrice1" name="attendedLicenseListPrice" value="${row.attendedLicenseListPrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm atlistprice" <#if row.subscribeType?number = 1>readonly</#if> maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm atper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="attendedCount1" name="attendedCount" value="${row.countAttended?c}" placeholder="수량을 입력하세요" class="form-control form-control-sm atcount" <#if row.subscribeType?number = 1>readonly</#if> maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                            </div>
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">Studio 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioLicensePrice1" name="studioLicensePrice" value="${row.studioLicensePrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm stprice" <#if row.subscribeType?number = 1>readonly</#if> maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioLicenseListPrice1" name="studioLicenseListPrice" value="${row.studioLicenseListPrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm stlistprice" <#if row.subscribeType?number = 1>readonly</#if> maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm stper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="studioCount1" name="studioCount" value="${row.countStudio?c}" placeholder="수량을 입력하세요" class="form-control form-control-sm stcount" <#if row.subscribeType?number = 1>readonly</#if> maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)"></div>
                            </div>
                            <div class="d-flex justify-content-center align-items-center mb-2">
                                <div class="min-width200 pr-2"><div class="text-right">WorkCenter 납품금액</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterLicensePrice1" name="workcenterLicensePrice" value="${row.workcenterLicensePrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm wcprice" <#if row.subscribeType?number = 1 || row.licenseType?number = 1>readonly</#if> maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" ></div>
                                <div class="min-width120 pr-2"><div class="text-right">List Price</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterLicenseListPrice1" name="workcenterLicenseListPrice" value="${row.workcenterLicenseListPrice?c}" placeholder="금액을 입력하세요" class="form-control form-control-sm wclistprice" <#if row.subscribeType?number = 1 || row.licenseType?number = 1>readonly</#if> maxlength="19" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" ></div>
                                <div class="min-width80 pr-2"><div class="text-right">할인율</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterLicensePercent1" readonly value="" placeholder="" class="form-control form-control-sm wcper"></div>
                                <div class="pl-2">%</div>
                                <div class="min-width80 pr-2"><div class="text-right">수량</div></div>
                                <div class="flex-grow-1"><input type="text" id="workcenterCount1" name="workcenterCount" value="${row.countWorkcenter?c}" placeholder="수량을 입력하세요" class="form-control form-control-sm wccount" <#if row.subscribeType?number = 1 || row.licenseType?number = 1>readonly</#if> maxlength="10" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)" ></div>
                            </div>
                            <hr>
                            <#if row_index = 0>
                            <div class="row mt-2">
                                <div class="col-12 text-right"><button type="button" class="btn btn-primary min-width120 licenseAdd">추가</button></div>
                            </div>
                            </#if>
                        </div>
                        </#list>
                    <#else>
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

                                    <select name="subscribeType" class="form-control form-control-sm subscribeType">

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
                    </#if>
                </div>
                </form>
                <div class="text-right">
                    <button type="button" class="btn btn-primary min-width80 btn-make">저장</button>
                </div>


                <div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modifyModalLabel">정보 변경</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <i class="icon-cancel"></i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="editForm">
                                    <input type="hidden" name="seq" id="seq">
                                    <input type="hidden" name="userSeq" id="userSeq">
                                    <input type="hidden" name="userName" id="userName">
                                        <div class="row mb-3">
                                            <div class="col-6">
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">계약번호</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractNumber" id="contractNumber" value="" placeholder="" class="form-control" readonly maxlength="20"></div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">회사명</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div>
                                                            <select name="comSeq" id="comSeq" class="form-control form-control-sm">
                                                                <option value="">회사를 선택하세요</option>
                                                                <#list companies as com>
                                                                    <option value="${com.seq?c}">${com.comName}</option>
                                                                </#list>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">계약명</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractName" id="contractName" value="" placeholder="" class="form-control" maxlength="45"></div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">시작일</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractStart" id="datestart2" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly></div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">종료일</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractEnd" id="dateend2" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">계약담당자</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractChargerName" value="" id="searchUser" placeholder="" class="form-control" maxlength="10"></div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">담당자 E-mail</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractChargerEmail" id="contractChargerEmail" value="" placeholder="" class="form-control" readonly></div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">담당자 연락처</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractChargerPhone" id="contractChargerPhone" value="" placeholder="" class="form-control" readonly></div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">상태</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div>
                                                            <input type="text" name="" id="currentStatus" class="form-control" readonly>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <div class="text-right font-w600">ICT 담당자</div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div><input type="text" name="contractIctName" id="contractIctName" value="" placeholder="" class="form-control"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                </form>
                            </div>
                            <div class="modal-footer d-flex justify-content-center align-items-center">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                <button type="button" class="btn btn-primary btnUpdate">저장</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<input type="hidden" id="startDate" value="${comContract.contractStart?string["yyyy-MM-dd"]}">
<input type="hidden" id="endDate" value="${comContract.contractEnd?string["yyyy-MM-dd"]}">
<#include "/layout/base_script.ftl">
<link rel="stylesheet" href="/assets/css/easy-autocomplete.min.css"/>
<script src="/assets/js/jquery.easy-autocomplete.min.js"></script>
<script src="/assets/js/page/contract/contractUpdate.js"></script>
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">