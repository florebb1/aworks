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
                                    <li class="breadcrumb-item active" aria-current="page">라이선스 관리</li>
<#--                                    <li class="breadcrumb-item active" aria-current="page">계약회사 목록</li>-->
                                </ol>
                            </nav>
                        </div>
                        <#--                        <div class="col d-flex align-items-center justify-content-end">-->
                        <#--                            <p>전체 회사 <span id="totalCnt">0</span> 개</p>-->
                        <#--                        </div>-->
<#--                        <div class="col-auto">-->
<#--                            <a class="btn btn-primary btn-block" href="/contract/new_write">계약 추가</a>-->
<#--                        </div>-->
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="10">
                    <input type="hidden" id="sort" name="sort" value="1">
                    <input type="hidden" id="order" name="order" value="1">
                    <input type="hidden" name="contractSeq" value="${RequestParameters.contractSeq!}">
                    <div class="form-row mb-3">
                        <div class="col-4">
                            <div class="form-row">
                                <div class="col">
                                    <input type="text" id="datestart" name="startDate" class="form-control" style="background:#fff" placeholder="날짜선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                                </div>
                                <div class="col-auto">~</div>
                                <div class="col">
                                    <input type="text" id="dateend" name="endDate" class="form-control" style="background:#fff" placeholder="날짜선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                                </div>
                            </div>
                        </div>
                        <div class="col-2">
                            <select class="custom-select" name="searchType" id="searchType">
                                <option value="">통합</option>
                                <option value="comName">회사명</option>
                            </select>
                        </div>
                        <div class="col-6">
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
                        <button type="button" class="btn btn-light ml-1 btn-exceldownload" onclick="excelDownload()">선택 엑셀 다운로드</button>
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
                            <col width="30px">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <div class="form-check">
                                    <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                </div>
                            </th>
                            <th scope="col">
                                <span>No</span>
                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="seq" data-orderby="1">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"  style="cursor:pointer"></i>-->
                                <#--</button>-->
                            </th>
                            <th scope="col">
                                <span>계약번호</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="com_name" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>라이선스 타입</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="name" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>UnAttended Count</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="service_name" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>Attended Count</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="contract_count" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>Studio Count</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="license_count" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>상태</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="license_count" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>등록일</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="create_datetime" data-orderby="0">

                                    <i class="icon-caret-down "></i>

                                </button>
                            </th>

                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="licenseList">
                        <#--<tr>-->
                            <#--<td><input type="checkbox"></td>-->
                            <#--<td>1</td>-->
                            <#--<td><a href="/contract/new_view" style="text-decoration: underline">20190516-0000</a></td>-->
                            <#--<td>Work Center</td>-->
                            <#--<td>1,000</td>-->
                            <#--<td>1,000</td>-->
                            <#--<td>1,000</td>-->
                            <#--<td>2019-01-01</td>-->
                        <#--</tr>-->
                        <#--<#if results??>-->
                        <#--<#assign resultSize = results?size>-->
                        <#--<#if resultSize &gt; 0>-->
                        <#--<#list results as row>-->
                        <#--<tr>-->
                        <#--<td scope="row">-->
                        <#--<div class="form-check">-->
                        <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                        <#--</div>-->
                        <#--</td>-->
                        <#--<td style="cursor: pointer" onclick="contractViewDetail(${row.seq})">${row.seq}</td>-->
                        <#--<td style="cursor: pointer" onclick="contractViewDetail(${row.seq})">${row.comName}</td>-->
                        <#--<td style=nter" onclick="contractViewDetail(${row.seq})"><#if row.userName??>${row.userName}<#else>-</#if></td>-->
                        <#--<td style="cursor: po"cursor: poiinter" onclick="contractViewDetail(${row.seq})">${row.serviceName}</td>-->
                        <#--<td style="cursor: pointer" onclick="contractViewDetail(${row.seq})"><#if row.contractType = 0>온라인<#else>오프라인</#if></td>-->
                        <#--<td style="cursor: pointer" onclick="contractViewDetail(${row.seq})">${row.createDatetime?string["yyyy-MM-dd"]}</td>-->
                        <#--<td style="cursor: pointer" onclick="contractViewDetail(${row.seq})"><#if row.status = 0>사용중<#else>해지</#if></td>-->
                        <#--<td>-->
                        <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                        <#--<i class="icon-newpage"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                        <#--<i class="icon-urlcopy"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-backdrop="static" data-target="#companyModal" data-seq="${row.seq}" title="수정">-->
                        <#--<i class="icon-modify"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-backdrop="static" data-target="#comUserModal" data-seq="${row.seq}" title="계약회사 소속 사용자">-->
                        <#--<i class="icon-urlcopy"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-backdrop="static" data-target="#comLicenseModal" data-seq="${row.seq}" title="계약회사 라이센스 목록">-->
                        <#--<i class="icon-urlcopy"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-backdrop="static" data-target="#ccpInfoModal" data-seq="${row.seq}" title="결제내역 조회">-->
                        <#--<i class="icon-urlcopy"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-backdrop="static" data-target="#ccapInfoModal" data-seq="${row.seq}" title="미수금 내역 조회">-->
                        <#--<i class="icon-urlcopy"></i>-->
                        <#--</button>-->
                        <#--<button type="button" class="btn btn-danger btn-sm comDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                        <#--<i class="icon-delete"></i>-->
                        <#--</button>-->
                        <#--</td>-->
                        <#--</tr>-->
                        <#--</#list>-->
                        <#--<#else>-->
                        <#--<tr>-->
                        <#--<td colspan="9" align="center">계약된 회사가 없습니다.</td>-->
                        <#--</tr>-->
                        <#--</#if>-->
                        <#--</#if>-->
                        </tbody>
                    </table>
                </form>
                <#--<nav aria-label="Page navigation">-->
                <#--<ul class="pagination d-flex justify-content-center">-->
                <#--<@pagination.first />-->
                <#--<@pagination.numbers />-->
                <#--<@pagination.last />-->
                <#--</ul>-->
                <#--</nav>-->
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

<div class="modal fade" id="comUserModal" tabindex="-1" role="dialog" aria-labelledby="comUserModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="comUserModalCenterTitle">계약회사 소속 사용자</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0">
                <div id="cuContentMain" class="input-display pt-5 pb-5 pl-3 pr-3">

                    <form id="cuListForm">
                        <input type="hidden" id="cuTotal" name="cuTotal" value="">
                        <input type="hidden" id="cuPage" name="cuPage" value="0">
                        <input type="hidden" id="cuOrder" name="cuOrder" value="0">
                        <input type="hidden" id="cuSort" name="cuSort" value="create_datetime">
                        <table class="table">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">
                                    <span>No</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-3">
                                        <i class="icon-caret-down seq"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>이메일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-3">
                                        <i class="icon-caret-down app_type"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>닉네임</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-3">
                                        <i class="icon-caret-down app_name"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>연락처</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-3">
                                        <i class="icon-caret-down create_datetime"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>직급</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-3">
                                        <i class="icon-caret-down last_update"></i>
                                    </button>
                                </th>
                                <th scope="col">
                                    <span>등록일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-3">
                                        <i class="icon-caret-down downloadCnt"></i>
                                    </button>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="cuList"></tbody>
                        </table>
                    </form>
                    <div id="cu-page-selection"></div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫 기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="comLicenseModal" tabindex="-1" role="dialog" aria-labelledby="comLicenseModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="comLicenseModalCenterTitle">계약회사 라이센스 목록</h5>
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
                                <div class="form-row">
                                    <div class="col">
                                        <input type="text" id="clDatestart" name="clStartDate" class="form-control" placeholder="날짜선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                                    </div>
                                    <div class="col-auto">~</div>
                                    <div class="col">
                                        <input type="text" id="clDateend" name="clEndDate" class="form-control" placeholder="날짜선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="col-2">
                                <select class="custom-select" name="clSearchType" id="clSearchType">
                                    <option value="">통합</option>
                                    <option value="comName">회사명</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="clSearchWord" name="clSearchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="cl-button-search" value="">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary d-flex align-items-center" type="button" id="cl-button-search">
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
                            <button type="button" class="btn btn-light cl-btn-checkdelete">선택삭제</button>
                            <button type="button" class="btn btn-light ml-1 cl-btn-exceldownload">선택 엑셀 다운로드</button>
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
                                    <span>시작일</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down seq"></i>-->
                                    <#--</button>-->
                                </th>
                                <th scope="col">
                                    <span>종료일</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down app_type"></i>-->
                                    <#--</button>-->
                                </th>
                                <th scope="col">
                                    <span>등록일</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down app_name"></i>-->
                                    <#--</button>-->
                                </th>
                                <th scope="col">
                                    <span>계약방식</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down create_datetime"></i>-->
                                    <#--</button>-->
                                </th>
                                <th scope="col">
                                    <span>상태</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down last_update"></i>-->
                                    <#--</button>-->
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

<div class="modal fade" id="ccpInfoModal" tabindex="-1" role="dialog" aria-labelledby="ccpInfoModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ccpInfoModalCenterTitle">계약회사 결제내역</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0">
                <div id="ccpInfoContentMain" class="input-display">
                    <form id="ccpSearchForm">
                        <input type="hidden" id="ccpiComSeq" name="ccpiComSeq" value="">
                        <input type="hidden" id="ccpTotal" name="ccpTotal" value="">
                        <input type="hidden" id="ccpPage" name="ccpPage" value="0">
                        <input type="hidden" id="ccpOrder" name="ccpOrder" value="0">
                        <input type="hidden" id="ccpSort" name="ccpSort" value="create_datetime">

                        <div class="form-row">
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">결제일 선택</span>
                                    </div>
                                    <select id="year" class="custom-select"  name="year"></select>
                                    <select id="month" class="custom-select"  name="month"></select>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">결제금액 입력</span>
                                    </div>
                                    <input type="text" class="form-control" id="payNow" name="payNow" placeholder="결제금액을 입력해주세요" aria-label="" aria-describedby="ccp-button-search" value="">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary d-flex align-items-center" type="button" id="payNowGo">
                                            <i class="icon-checkmark"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="text-info-mih">
                                    <small id="payNowChkText" class="form-text text-danger"></small>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="form-row mb-4">
                            <div class="col-4">
                                <div class="form-row">
                                    <div class="col">
                                        <input type="text" id="ccpDatestart" name="ccpStartDate" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly>
                                    </div>
                                    <div class="col-auto">~</div>
                                    <div class="col">
                                        <input type="text" id="ccpDateend" name="ccpEndDate" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="col-2">
                                <select class="custom-select" name="ccpSearchType" id="ccpSearchType">
                                    <option value="">통합</option>
                                    <option value="payment">결제금액</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="ccpSearchWord" name="ccpSearchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="ccp-button-search" value="">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary d-flex align-items-center" type="button" id="ccp-button-search">
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
                            <button type="button" class="btn btn-light ccp-btn-checkdelete">선택삭제</button>
                            <#--<button type="button" class="btn btn-light ml-1 ccp-btn-exceldownload">선택 엑셀 다운로드</button>-->
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
                                        <input class="form-check-input position-static ccpAllChk" type="checkbox" id="" value="" aria-label="...">
                                    </div>
                                </th>
                                <th scope="col">
                                    <span>No</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-caret-down seq"></i>-->
                                    <#--</button>-->
                                </th>
                                <th scope="col">
                                    <span>결제 년/월</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-caret-down create_datetime"></i>-->
                                    <#--</button>-->
                                </th>
                                <#--<th scope="col">-->
                                <#--<span>수정일</span>-->
                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                <#--<i class="icon-caret-down update_datetime"></i>-->
                                <#--</button>-->
                                <#--</th>-->
                                <th scope="col">
                                    <span>결제 금액</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-caret-down payment"></i>-->
                                    <#--</button>-->
                                </th>
                                <#--<th scope="col">-->
                                <#--<span>Action</span>-->
                                <#--</th>-->
                            </tr>
                            </thead>
                            <tbody id="ccpInfoList"></tbody>
                        </table>
                    </form>
                    <div class="d-flex justify-content-center align-items-center" id="ccp-page-selection"></div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="ccapInfoModal" tabindex="-1" role="dialog" aria-labelledby="ccapInfoModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ccapInfoModalCenterTitle">계약회사 미수금 내역</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <#--<div id="recomm-modal-view"></div>-->
            <div class="modal-body pa-0">
                <div id="ccapInfoContentMain" class="input-display">
                    <form id="ccapSearchForm">
                        <input type="hidden" id="ccapiComSeq" name="ccapiComSeq" value="">
                        <input type="hidden" id="ccapTotal" name="ccapTotal" value="">
                        <input type="hidden" id="ccapPage" name="ccapPage" value="0">
                        <input type="hidden" id="ccapOrder" name="ccapOrder" value="0">
                        <input type="hidden" id="ccapSort" name="ccapSort" value="create_datetime">

                        <div class="form-row">
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">결제일 선택</span>
                                    </div>
                                    <select id="year_ccapi" class="custom-select" name="year_ccapi"></select>
                                    <select id="month_ccapi" class="custom-select" name="month_ccapi"></select>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">결제금액 입력</span>
                                    </div>
                                    <input type="text" class="form-control" id="accruedPayNow" name="accruedPayNow" placeholder="미수금액을 입력해주세요" aria-label="" aria-describedby="payNowGo" value="">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary d-flex align-items-center" type="button" id="accruedPayNowGo">
                                            <i class="icon-checkmark"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="text-info-mih">
                                    <small id="accruedPayNowChkText" class="form-text text-danger"></small>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="form-row mb-4">
                            <div class="col-4">
                                <div class="form-row">
                                    <div class="col">
                                        <input type="text" id="ccapDatestart" name="ccapStartDate" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly>
                                    </div>
                                    <div class="col-auto">~</div>
                                    <div class="col">
                                        <input type="text" id="ccapDateend" name="ccapEndDate" class="form-control" placeholder="날짜선택" value="" autocomplete="off" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="col-2">
                                <select class="custom-select" name="ccapSearchType" id="ccapSearchType">
                                    <option value="">통합</option>
                                    <option value="accruedPayment">결제금액</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="ccapSearchWord" name="ccapSearchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="ccap-button-search" value="">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary d-flex align-items-center" type="button" id="ccap-button-search">
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
                            <button type="button" class="btn btn-light ccapi-btn-checkdelete">선택삭제</button>
                            <#--<button type="button" class="btn btn-light ml-1 ccap-btn-exceldownload">선택 엑셀 다운로드</button>-->
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
                                        <input class="form-check-input position-static ccapiAllChk" type="checkbox" id="" value="" aria-label="...">
                                    </div>
                                </th>
                                <th scope="col">
                                    <span>No</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-caret-down seq"></i>-->
                                    <#--</button>-->
                                </th>
                                <th scope="col">
                                    <span>결제 년/월</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-caret-down create_datetime"></i>-->
                                    <#--</button>-->
                                </th>
                                <#--<th scope="col">-->
                                <#--<span>수정일</span>-->
                                <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                <#--<i class="icon-caret-down update_datetime"></i>-->
                                <#--</button>-->
                                <#--</th>-->
                                <th scope="col">
                                    <span>미수금액</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-3">-->
                                    <#--<i class="icon-caret-down accrued_payment"></i>-->
                                    <#--</button>-->
                                </th>
                                <#--<th scope="col">-->
                                <#--<span>Action</span>-->
                                <#--</th>-->
                            </tr>
                            </thead>
                            <tbody id="ccapInfoList"></tbody>
                        </table>
                    </form>
                    <div class="d-flex justify-content-center align-items-center" id="ccap-page-selection"></div>
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
        <th scope="col">회사명</th>
        <th scope="col">계약회원명</th>
        <th scope="col">운영담당자</th>
        <th scope="col">등록일</th>
        <th scope="col">상태</th>
    </tr>
    </thead>
    <tbody id="comContractListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/plugins/bootpag/jquery.bootpag.min.js"></script>
<script src="/assets/js/page/license/licenseList.js"></script>
<script type="text/javascript">
    $(function(){

        var toDay = new Date();
        var year = Number(toDay.getFullYear());
        var month = Number(toDay.getMonth()+1);
        for(var i = year -5 ; i < year + 12; i++) {
            if(year == i) {
                $("#year").append('<option value="'+i+'" selected>'+i+'</option>');
                $("#year_ccapi").append('<option value="'+i+'" selected>'+i+'</option>');
            } else {
                $("#year").append('<option value="'+i+'">'+i+'</option>');
                $("#year_ccapi").append('<option value="'+i+'">'+i+'</option>');
            }
        }
        for(var i = 1; i < 13; i++) {
            if(month == i) {
                $("#month").append('<option value="'+i+'" selected>'+i+'</option>');
                $("#month_ccapi").append('<option value="'+i+'" selected>'+i+'</option>');
            } else {
                $("#month").append('<option value="'+i+'">'+i+'</option>');
                $("#month_ccapi").append('<option value="'+i+'">'+i+'</option>');
            }
        }

        $("#searchType").val('${RequestParameters.searchType!}');
        $('[data-toggle="tooltip"]').tooltip();

        // 정렬 순서 변경 처리
        // $(".icon-caret-down").on("click", function(){
        //     var fullStringClassName = $(this).attr("class");
        //     var className = fullStringClassName.substring(45);
        //     $("#sort").val(className);
        //     $("#searchForm").submit();
        // });
    });

    function paging(pageValue) {
        if(window.location.search != "") {
            var query = window.location.search.replace("?", "");
            query = query.split("&");
            query.forEach(function (one, i) {
                console.log(one.indexOf("page="));
                if (one.indexOf("page=") > -1) {
                    query.splice(i, 1);
                }
            });
            query.push("page=" + pageValue);
            query = query.join("&");
            document.location.href = "?"+query;
        }else{
            document.location.href = "?page="+pageValue;
        }
    }

    function excelDownload(){

        $("#comContractListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("계약회사를 1개 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|") };
            $.ajax({
                url: "/contract/execlDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var companyList = response.list;
                var html = '';
                for(var i=0;i<companyList.length;i++) {
                    var comName = companyList[i].comName;
                    if(comName == null || comName == "") comName = "";
                    var userName = String(companyList[i].userName);
                    if(userName == null || userName == "") userName = "";
                    var serviceName = companyList[i].serviceName;
                    if(serviceName == null || serviceName == "") serviceName = "";
                    var createDatetime = getFormatDate(companyList[i].createDatetime);
                    var status = companyList[i].status;
                    if(status == 0) status = "계약진행";
                    else if(status == 1) status = "계약해지";
                    html =
                        '<tr>' +
                        '<td>'+(i+1)+'</td>'+
                        '<td>'+comName+'</td>'+
                        '<td>'+userName+'</td>'+
                        '<td>'+serviceName+'</td>'+
                        '<td>'+createDatetime+'</td>'+
                        '<td>'+status+'</td>'+
                        '</tr>';
                    $("#comContractListByExeclBody").append(html);
                }

                var filename = "contractCompanyList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('comContractListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
</script>

<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">