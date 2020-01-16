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
                                        <li class="breadcrumb-item"><a href="#">파트너 관리</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">파트너 상세</li>
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
                        <form id="writeForm" action="/user/save" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="seq" id="seq" value="<#if user??>${user.seq}</#if>">

                            <div id="contentMain" class="pt-5 pb-5 pl-3 pr-3">

                                <div class="form-row mb-4">
                                    <div class="col-3 text-right">
                                        <div class="miw100 text-right">로고</div>
                                    </div>
                                    <div class="col-3">
                                        <#if partner?? && partner.logo??>
                                            <div id="imageView" style="">
                                                <#--  <div></div>  -->
                                                <img id="imagePreview" class="view-user-img" src="${partner.logo}" alt="">
                                            </div>
                                        </#if>
                                    </div>
                                </div>
                                <div class="form-row mb-4">
                                    <div class="col-3 text-right">
                                        <div class="miw100 text-right">회사명</div>
                                    </div>
                                    <div class="col-3">
                                        <#--  <input type="text" class="form-control input-form mxw250" value="${partner.name}" readonly>  -->
                                        ${partner.name}
                                    </div>
                                </div>
                                <div class="form-row mb-4">
                                    <div class="col-3 text-right">
                                        <div class="miw100 text-right">대표전화</div>
                                    </div>
                                    <div class="col-3">
                                        <#--  <div class="miw300">${user.phone!}</div>  -->
                                        <#--  <input type="text" class="form-control input-form mxw250" value="${partner.tel!}" readonly>  -->
                                        ${partner.tel!}
                                    </div>
                                </div>
                                <div class="form-row mb-4">
                                    <div class="col-3 text-right">
                                        <div class="miw100 text-right">주소</div>
                                    </div>
                                    <div class="col-3">
                                        <#--  <div class="mxw300">${user.comName!}</div>  -->
                                        <#--  <input type="text" class="form-control input-form mxw300" value="${partner.address!}" readonly>  -->
                                        ${partner.address!}
                                    </div>
                                </div>
                                <div class="form-row mb-4">
                                    <div class="col-3 text-right">
                                        <div class="miw100 text-right">사업자번호</div>
                                    </div>
                                    <div class="col-3">
                                        <#--  <div class="miw300">${user.position!}</div>  -->
                                        <#--  <input type="text" class="form-control input-form mxw250" readonly
                                               value="<#if partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber?substring(0,3)}</#if>" >
                                        <input type="text" class="form-control input-form mxw250" readonly
                                               value="<#if partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber?substring(4,6)}</#if>" >
                                        <input type="text" class="form-control input-form mxw250" readonly
                                               value="<#if partner.businessNumber?? && partner.businessNumber != "">${partner.businessNumber?substring(7)}</#if>" >  -->
                                        ${partner.businessNumber!}
                                    </div>
                                </div>
                                <div class="form-row mb-4">
                                    <div class="col-3 text-right">
                                        <div class="miw100 text-right">메모</div>
                                    </div>
                                    <div class="col-3">
                                        <#--  <div class="mxw300">${user.comName!}</div>  -->
                                        <#--  <textarea class="form-control">${partner.memo!}</textarea>  -->
                                        ${partner.memo!}
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div>
                        <button class="btn btn-info" type="button" onclick="document.location.href='/partner/list'">목록</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


<#include "/layout/base_script.ftl">

<script type="text/javascript">
    $(function(){

    });
</script>

<#include "/layout/footer.ftl">