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
                                    <li class="breadcrumb-item"><a href="/company/list">회사 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">회사 상세</li>
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

                        <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">
                            <div class="view-wireframe ml-3 mr-3">
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">회사명</div>
                                    </div>
                                    <div class="col-10">

                                        ${company.comName!'-'}
                                    </div>

                                </div>

                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">회사 연락처</div>
                                    </div>
                                    <div class="col-10">

                                        ${company.comPhone!'-'}
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-2">
                                        <div class="text-right font-w600">회사 대표이메일</div>
                                    </div>
                                    <div class="col-10">

                                        ${company.comEmail!'-'}
                                    </div>
                                </div>

                            </div>
                        </div>
                    </form>
                </div>
                <div class="mt-5">
                    <p>계약 목록</p>
                    <table class="table">
                        <colgroup>

                            <col>
                        </colgroup>
                        <thead>
                        <tr>


                            <th scope="col">
                                <span>계약번호</span>

                            </th>
                            <th scope="col">
                                <span>계약명</span>
                            </th>
                            <th scope="col">
                                <span>계약시작일</span>

                            </th>
                            <th scope="col">
                                <span>계약종료일</span>

                            </th>
                            <th scope="col">
                                <span>계약담당자</span>
                            </th>
                            <th scope="col">
                                <span>담당자 E-mail</span>
                            </th>
                            <th scope="col">
                                <span>담당자 연락처</span>
                            </th>
                            <th scope="col">
                                <span>상태</span>
                            </th>
                            <th scope="col">
                                <span>ICT 계약담당자</span>
                            </th>

                        </tr>
                        </thead>
                        <tbody>
                            <#list comContract as row>
                                <tr>

                                    <td>${row.contractNumber}</td>
                                    <td>${row.contractName}</td>
                                    <td>${row.contractStart?string["yyyy년 MM월 dd일"]}</td>
                                    <td><#if row.contractEnd??>${row.contractEnd?string["yyyy년 MM월 dd일"]}</#if></td>
                                    <td>${row.contractChargerName}</td>
                                    <td>${row.contractChargerEmail}</td>
                                    <td>${row.contractChargerPhone}</td>
                                    <td class="currentStatus" data-start="${row.contractStart?string["yyyy-MM-dd"]}" data-end="${row.contractEnd?string["yyyy-MM-dd"]}">

                                    </td>
                                    <td>${row.contractIctName}</td>

                                </tr>
                            </#list>
                        </tbody>
                    </table>
                </div>

                <div class="text-center">
                    <button class="btn btn-info min-width120" type="button" onclick="document.location.href='/company/list'">목록</button>
                </div>

            </div>
        </div>
    </div>
</div>


<#include "/layout/base_script.ftl">
<script src="/assets/js/page/company/companyView.js"></script>

<#include "/layout/footer.ftl">