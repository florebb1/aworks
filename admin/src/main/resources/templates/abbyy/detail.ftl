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
                                    <li class="breadcrumb-item"><a href="#">ABBYY 라이선스 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">ABBYY 라이선스 상세보기</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <hr>

                <div class="card pt-5 pb-5 mb-5">
                    <form id="addForm">
                        <input type="hidden" name="seq" id="seq" value="${abbyy.seq}">
                        <input type="hidden" name="comUUid" id="comUUid" value="${abbyy.comUUid!''}">
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">계약회원사 정보</div>
                            </div>
                            <div class="col-9">
                                    <input type="hidden" name="comSeq" id="comSeq" value="<#if abbyy.comSeq??>${abbyy.comSeq}</#if>">
                                    <#if abbyy.comName??>${abbyy.comName}</#if>
                            </div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-3">
                                <div class="text-right font-w600">ABBYY 라이선스 Key</div>
                            </div>
                            <div class="col-9">
                                    ${abbyy.abbyyLicenseKey!}
                            </div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-3 text-right">
                                <div class="text-right font-w600">라이선스 이용일</div>
                            </div>
                            <div class="col-9">
                                    <#if abbyy.startDate?exists>${abbyy.startDate?string["yyyy-MM-dd"]}<#else></#if>
                                    ~
                                    <#if abbyy.endDate?exists>${abbyy.endDate?string["yyyy-MM-dd"]}<#else></#if>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="text-center">
                    <button class="btn btn-info min-width120" type="button" onclick="document.location.href='/abbyy/list'">목록</button>
                </div>
            </div>
        </div>
    </div>
</div>

<#include "/layout/base_script.ftl">
<script type="text/javascript" src="/assets/js/FileSaver.min.js"></script>
<!-- custom script 위치 -->
<script>
    $(function(){


    });
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">