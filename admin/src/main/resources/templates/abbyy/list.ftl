<#include "/layout/base.ftl">
<#import "../pagination.ftl" as pagination />
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
                                    <li class="breadcrumb-item active" aria-current="page">ABBYY 라이선스 관리</li>
                                    <#--<li class="breadcrumb-item active" aria-current="page">ABBYY 라이선스 목록</li>-->
                                </ol>
                            </nav>
                        </div>
                        <div class="col d-flex align-items-center justify-content-end">
                            <p>전체 ABBYY 라이선스 <span id="totalCnt">${total}</span> 개</p>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="searchForm">
                    <input type="hidden" id="row" name="row" value="${row}">
                    <input type="hidden" id="sort" name="sort" value="${sort!}">
                    <input type="hidden" id="order" name="order" value="${order!}">
                    <div class="form-row mb-3">
                        <div class="col-4">
                            <div class="form-row">
                            <div class="col">
                                <input type="text" id="datestart" name="startDate" class="form-control" placeholder="날짜선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly style="background:#fff">
                            </div>
                            <div class="col-auto">~</div>
                            <div class="col">
                                <input type="text" id="dateend" name="endDate" class="form-control" placeholder="날짜선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly style="background:#fff">
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
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                <#--</button>-->
                            </th>
                            <th scope="col">
                                <span>회사명</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="comName" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>등록일</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="create_datetime" data-orderby="0">

                                    <i class="icon-caret-down"></i>

                                </button>
                            </th>
                            <th scope="col">
                                <span>시작일</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="start_date" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>종료일</span>
                                <button type="button" class="btn btn-link border-0 p-0 ml-3 sorting" data-sort="end_date" data-orderby="1">
                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                </button>
                            </th>
                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="abbyyList">
                            <#--<#if total?number gt 0>-->
                                <#--<#list results as row>-->
                                <#--<tr >-->
                                    <#--<td scope="row">-->
                                        <#--<div class="form-check">-->
                                            <#--<input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="${row.seq}" aria-label="...">-->
                                        <#--</div>-->
                                    <#--</td>-->
                                    <#--<td style="cursor: pointer" onclick="abbyyLicenseDetail((${row.seq})">${row.seq}</td>-->
                                    <#--<td style="cursor: pointer" onclick="abbyyLicenseDetail(${row.seq})"><#if row.comName??>${row.comName}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="abbyyLicenseDetail(${row.seq})"><#if row.createDatetime??>${row.createDatetime?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="abbyyLicenseDetail(${row.seq})"><#if row.startDate??>${row.startDate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td style="cursor: pointer" onclick="abbyyLicenseDetail(${row.seq})"><#if row.endDate??>${row.endDate?string["yyyy-MM-dd"]}</#if></td>-->
                                    <#--<td>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm newWindowView" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="새로운창 띄우기">-->
                                            <#--<i class="icon-newpage"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-secondary btn-sm urlCopy" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="URL 복사">-->
                                            <#--<i class="icon-urlcopy"></i>-->
                                        <#--</button>-->
                                        <#--&lt;#&ndash;<#if row.downloadCount &lt;= 0>&ndash;&gt;-->
                                        <#--<button type="button" class="btn btn-info btn-sm abbyyLicenseModify" data-seq="${row.seq}" title="수정">-->
                                            <#--<i class="icon-modify"></i>-->
                                        <#--</button>-->
                                        <#--<button type="button" class="btn btn-danger btn-sm abbyyLicenseDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                                            <#--<i class="icon-delete"></i>-->
                                        <#--</button>-->
                                        <#--&lt;#&ndash;</#if>&ndash;&gt;-->
                                    <#--</td>-->
                                <#--</tr>-->
                                <#--</#list>-->
                            <#--<#else>-->
                                <#--<tr>-->
                                    <#--<td colspan="9" align="center">발급된 ABBYY 라이선스가 없습니다.</td>-->
                                <#--</tr>-->
                            <#--</#if>-->
                        </tbody>
                    </table>
                </form>
                <nav id="paging" class="d-flex justify-content-center">

                </nav>
            </div>
        </div>
    </div>
</div>

<table id="abbyyListByExeclTable" style="display:none;">
    <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">회사명</th>
            <th scope="col">등록일</th>
            <th scope="col">시작일</th>
            <th scope="col">종료일</th>
        </tr>
    </thead>
    <tbody id="abbyyListByExeclBody"></tbody>
</table>

<#include "/layout/base_script.ftl">
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/abbyy/abbyyList.js"></script>
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">