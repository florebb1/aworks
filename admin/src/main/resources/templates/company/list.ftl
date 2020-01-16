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
                                    <li class="breadcrumb-item active" aria-current="page">회사 관리</li>
                                    <#--<li class="breadcrumb-item active" aria-current="page">계약회사 목록</li>-->
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 회사 <span id="totalCnt">0</span> 개</p>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-backdrop="static" data-target="#companyModal" data-seq="">회사 등록</button>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="10">
                    <input type="hidden" id="sort" name="sort" value="create_datetime">
                    <input type="hidden" id="order" name="order" value="1">
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
                                <option value="comPhone">회사 연락처</option>
                                <option value="comEmail">회사 이메일</option>
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
                            <col width="40px">
                            <col width="100px">
                            <col width="">
                            <col width="13%">
                            <col width="13%">
                            <col width="13%">
                            <col width="13%">
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
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="seq" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"  style="cursor:pointer"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>회사명</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="com_name" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>회사 연락처</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="com_phone" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>회사 대표이메일</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="com_email" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
                            <th scope="col" style="vertical-align:middle;">
                                <div class="d-flex justify-content-start align-items-center">
                                    <span>계약정보</span>
                                    <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="countContract" data-orderby="1">
                                        <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                    </button>
                                </div>
                            </th>
<#--                            <th scope="col">-->
<#--                                <span>라이선스정보</span>-->
<#--                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="license_count" data-orderby="1">-->
<#--                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
<#--                                </button>-->
<#--                            </th>-->
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
            <div class="modal-body pa-0">
                <form id="writeForm">
                    <input type="hidden" name="seq" id="seq">
                    <input type="hidden" name="bComName" id="bComName">
                    <div id="contentMain" class="input-display">

                        <div class="form-row">
                            <div class="col-3 main-form-title">
                                <span>회사명</span>
                            </div>

                            <div class="col-7">
                                <input type="text" class="form-control input-form" name="comName" id="comName" placeholder="" required=""
                                       value="" maxlength="30">
                                <div class="text-info-mih">
                                    <small id="comNameChkText" class="form-text text-danger" style="display: none"></small>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-3 main-form-title">
                                <span>회사 연락처</span>
                            </div>

                            <div class="col-7">
                                <input type="test" class="form-control input-form" name="comPhone" id="comPhone" placeholder="" required=""
                                       value="" maxlength="20" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)">
                                <div class="text-info-mih">
                                    <small id="comNameChkText" class="form-text text-danger" style="display: none"></small>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-3 main-form-title">
                                <span>회사 대표 이메일</span>
                            </div>

                            <div class="col-7">
                                <input type="text" class="form-control input-form" name="comEmail" id="comEmail" placeholder="" required=""
                                       value="" maxlength="50">
                                <div class="text-info-mih">
                                    <small id="comNameChkText" class="form-text text-danger" style="display: none"></small>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
                <button type="button" class="btn btn-primary btn-save">
                    확 인
                </button>
            </div>
        </div>
    </div>
</div>

<table id="comContractListByExeclTable" style="display:none;">
    <thead>
    <tr>
        <th scope="col">No</th>
        <th scope="col">회사명</th>
        <th scope="col">회사연락처</th>
        <th scope="col">회사 대표이메일</th>
        <th scope="col">계약정보</th>
        <th scope="col">등록일</th>
    </tr>
    </thead>
    <tbody id="comContractListByExeclBody"></tbody>
</table>


<#include "/layout/base_script.ftl">
<script src="/assets/plugins/bootpag/jquery.bootpag.min.js"></script>
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/company/companyList.js"></script>


<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">