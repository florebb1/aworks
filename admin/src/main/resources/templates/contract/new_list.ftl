<#include "/layout/base.ftl">
<#import "../pagination.ftl" as pagination />
<style>
    .ui-autocomplete {
        z-index: 2000 !important;
    }
</style>

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
                                    <li class="breadcrumb-item active" aria-current="page"> <#if company?exists>${company.comName}</#if> 계약 관리 </li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col-auto">
                            <a class="btn btn-primary btn-block" href="/contract/new_write?comSeq=<#if company?exists>${company.seq?c}</#if>">계약생성</a>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="10">
                    <input type="hidden" id="sort" name="sort" value="create_datetime">
                    <input type="hidden" id="order" name="order" value="1">
                    <input type="hidden" id="comSeq" name="comSeq" value="${RequestParameters.comSeq!}">
                    <div class="form-row mb-3">
                        <div class="col-4">
                            <div class="form-row">
                                <div class="col">
                                    <input type="text" id="datestart" name="startDate" class="form-control" style="background:#fff" placeholder="시작일 선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                                </div>
                                <div class="col-auto">~</div>
                                <div class="col">
                                    <input type="text" id="dateend" name="endDate" class="form-control" style="background:#fff" placeholder="종료일 선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="col-2">
                            <select class="custom-select" name="contractStatus" id="contractStatus">
                                <option value="">전체</option>
                                <option value="1">대기</option>
                                <option value="2">사용</option>
                                <option value="3">종료</option>
                            </select>
                        </div>
                        <div class="col-2">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="contractNumber">계약번호</option>
                                <option value="comName">회사명</option>
                                <option value="contractName">계약명</option>
                                <option value="userName">계약담당자</option>
                            </select>
                        </div>
                        <div class="col-4">
                            <div class="input-group">
                                <input type="text" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search" value="${RequestParameters.searchWord!}">
                                <div class="input-group-append">
                                    <button class="btn btn-primary d-flex align-items-center" type="submit" id="button-search">
                                        <i class="icon-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <hr>

                <div class="form-row mb-3">
                    <div class="col d-flex justify-content-start">
                        <button type="button" class="btn btn-light btn-checkdelete">선택삭제</button>
                        <button type="button" class="btn btn-light ml-1 btn-exceldownload" onclick="excelDownload()">엑셀다운로드</button>
                    </div>
                    <div class="col d-flex justify-content-end">
                        <div class="btn-group" role="group" aria-label="Basic example">
                            <button type="button" class="btn btn-primary btn-row" data-row="10">10개</button>
                            <button type="button" class="btn btn-light btn-row" data-row="20">20개</button>
                            <button type="button" class="btn btn-light btn-row" data-row="30">30개</button>
                        </div>
                    </div>
                </div>

                <form id="listForm">
                    <table class="table">
                        <colgroup>
                            <col width="40px">
                            <col width="100px">
                            <col width="280px">
                            <col>
                            <col width="260px">
                            <col width="120px">
                            <col width="120px">
                            <col width="120px">
                            <col width="130px">
                            <col width="120px">
                            <col width="100px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <div class="form-check">
                                    <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>No</span>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>계약번호</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_number" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>회사명</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="c.com_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>계약명</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>시작일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_start" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>종료일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_end" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>상태</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_status" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>계약 담당자</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="user_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="create_datetime" data-orderby="0">
                                        <i class="icon-caret-down "></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="contractList">
                        </tbody>
                    </table>
                </form>
                <nav id="paging" class="d-flex justify-content-center">

                </nav>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="companyModal" tabindex="-1" role="dialog" aria-labelledby="companyModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="companyModalCenterTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div id="contract-company-modal-view"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="comLicenseModal" tabindex="-1" role="dialog" aria-labelledby="comLicenseModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="comLicenseModalCenterTitle">계약회사 라이선스 목록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0">
                <div id="contentMain" class="input-display">
                    <form id="clSearchForm">
                        <input type="hidden" id="clSeq" name="clSeq" value="">
                        <input type="hidden" id="clTotal" name="clTotal" value="">
                        <input type="hidden" id="clPage" name="clPage" value="0">
                        <input type="hidden" id="clOrder" name="clOrder" value="0">
                        <input type="hidden" id="clSort" name="clSort" value="create_datetime">

                        <div class="form-row mb-4">

                            <div class="col-4">

                                <select class="custom-select" name="clContractType" id="clContractType">
                                    <option value="">전체</option>
                                    <option value="1">Pilot</option>
                                    <option value="2">PoC</option>
                                    <option value="3">본사업</option>
                                </select>
                            </div>
                            <div class="col-3">

                                <select class="custom-select" name="clLicenseType" id="clLicenseType">
                                    <option value="">전체</option>
                                    <option value="1">PC형</option>
                                    <option value="2">Cloud형</option>
                                    <option value="3">On-premise형</option>
                                </select>
                            </div>
                            <div class="col-2">

                                <select class="custom-select" name="clSubscribeType" id="clSubscribeType">
                                    <option value="">전체</option>
                                    <option value="1">Hour</option>

                                    <option value="3">Annual</option>
                                </select>
                            </div>

                            <div class="col-2">

                                <select class="custom-select" name="clLicenseStatus" id="clLicenseStatus">
                                    <option value="">전체</option>
                                    <option value="0">사용가능</option>
                                    <option value="1">관리자 사용불가</option>
                                    <option value="2">계약기간 만료</option>
                                    <option value="3">발급개수 부족</option>
                                </select>
                            </div>
                            <div class="col-1">

                                <button class="btn btn-primary d-flex align-items-center" type="button" id="cl-button-search" style="padding:.575rem .75rem">
                                    <i class="icon-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <hr>

                    <div class="form-row mb-3">
                        <div class="col d-flex justify-content-start">
                            <button type="button" class="btn btn-light cl-btn-checkdelete">선택삭제</button>
                            <button type="button" class="btn btn-light ml-1 cl-btn-exceldownload" onclick="excelSubDownload()">선택 엑셀 다운로드</button>
                        </div>
                    </div>
                    <form id="clListForm">
                        <table class="table">
                            <colgroup>
                                <col width="30px">
                                <col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">
                                    <div class="form-check">
                                        <input class="form-check-input position-static" type="checkbox" id="clAllChk" value="" aria-label="...">
                                    </div>
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
                                    <span>Attended 수량</span>
                                </th>

                                <th scope="col">
                                    <span>Studio 수량</span>
                                </th>

                                <th scope="col">
                                    <span>WorkCenter 수량</span>
                                </th>
                                <th scope="col">
                                    <span>라이선스 상태</span>
                                </th>
                                <th scope="col">
                                    <span>Action</span>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="clSearchList"></tbody>
                        </table>
                    </form>
                    <div class="d-flex justify-content-center align-items-center" id="cl-page-selection"></div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
            </div>
        </div>
    </div>
</div>


<table id="comContractListByExeclTable" style="display:none;">
    <thead>
    <tr>
        <th scope="col">No</th>
        <th scope="col">계약번호</th>
        <th scope="col">회사명</th>
        <th scope="col">계약명</th>
        <th scope="col">시작일</th>
        <th scope="col">종료일</th>
        <th scope="col">계약담당자</th>
        <th scope="col">담당자 E-mail</th>
        <th scope="col">담당자 연락처</th>
        <th scope="col">상태</th>
        <th scope="col">ICT 계약담당자</th>
        <th scope="col">계약종류</th>
        <th scope="col">라이선스종류</th>
        <th scope="col">과금종류</th>
        <th scope="col">UnAttended 납품금액</th>
        <th scope="col">UnAttended List price</th>
        <th scope="col">UnAttended 수량</th>
        <th scope="col">Attended 납품금액</th>
        <th scope="col">Attended List price</th>
        <th scope="col">Attended 수량</th>
        <th scope="col">Studio 납품금액</th>
        <th scope="col">Studio List price</th>
        <th scope="col">Studio 수량</th>
        <th scope="col">Workcenter 납품금액</th>
        <th scope="col">Workcenter List price</th>
        <th scope="col">Workcenter 수량</th>
        <th scope="col">등록일</th>
    </tr>
    </thead>
    <tbody id="comContractListByExeclBody"></tbody>
</table>
<table id="licenseListByExeclTable" style="display:none;">
    <thead>

    <tr>
        <th scope="col">No</th>
        <th scope="col">계약번호</th>
        <th scope="col">회사명</th>
        <th scope="col">계약명</th>
        <th scope="col">시작일</th>
        <th scope="col">종료일</th>
        <th scope="col">계약담당자</th>
        <th scope="col">담당자 E-mail</th>
        <th scope="col">담당자 연락처</th>
        <th scope="col">상태</th>
        <th scope="col">ICT 계약담당자</th>
        <th scope="col">계약종류</th>
        <th scope="col">라이선스종류</th>
        <th scope="col">과금종류</th>
        <th scope="col">UnAttended 납품금액</th>
        <th scope="col">UnAttended List price</th>
        <th scope="col">UnAttended 수량</th>
        <th scope="col">Attended 납품금액</th>
        <th scope="col">Attended List price</th>
        <th scope="col">Attended 수량</th>
        <th scope="col">Studio 납품금액</th>
        <th scope="col">Studio List price</th>
        <th scope="col">Studio 수량</th>
        <th scope="col">Workcenter 납품금액</th>
        <th scope="col">Workcenter List price</th>
        <th scope="col">Workcenter 수량</th>
        <th scope="col">등록일</th>
    </tr>
    </thead>
    <tbody id="licenseListByExeclBody"></tbody>
</table>
<#include "/layout/base_script.ftl">
<script src="/assets/plugins/bootpag/jquery.bootpag.min.js"></script>
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/contract/contractList.js"></script>
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">