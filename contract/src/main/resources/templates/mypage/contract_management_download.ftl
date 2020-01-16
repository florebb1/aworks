<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">


<div class="sub-title-bg background-base-code background-h4">
    계약관리
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>다운로드</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>계약관리<i class="icon-cheveron-right"></i>다운로드</h5>
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
                <a href="/mypage/contract_management_info" class="cs-menu">계약정보관리</a>
                <a href="/mypage/contract_management_license" class="cs-menu">라이선스관리</a>
                <#--<a href="/mypage/contract_management_abbyy" class="cs-menu">ABBYY관리</a>-->
                <a href="/mypage/contract_management_download" class="cs-menu active">다운로드</a>
            </div>
            <div class="col-12">
                <div class="card minh-640 mt-4 pb-5">


                    <div class="row justify-content-center">
                        <div class="privacy-text text-center pt-3 ">
                            이전 버전은 1:1문의를 통해 요청 주시기 바랍니다.
                        </div>
                        <div class="col-11 mt-3 mb-5">
                            <table class="table hover-none">
                                <colgroup>
                                    <col>
                                </colgroup>
                                <thead>
                                    <tr>

                                        <th scope="col">환경</th>

                                        <th scope="col">Product Type</th>
                                        <th scope="col">Version</th>
                                        <th scope="col">Archive</th>
                                        <#--<th scope="col">Release Note</th>-->
                                        <th scope="col">Date</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <tr>

                                        <td rowspan="2">Windows7-32bit</td>

                                        <td>Studio</td>
                                        <th><#if studio32??>V ${studio32.versionNumber!'-'}<#else>-</#if></th>
                                        <td>
                                            <a href=#"" data-path="<#if studio32??>${studio32.filePath!}</#if>" class="download"><#if studio32??>${studio32.filePathStr!'-'}<#else></#if></a>

                                        </td>
                                        <#--<td></td>-->
                                        <td><#if studio32??>${studio32.updateDatetime?string["yyyy-MM-dd"]}<#else>-</#if></td>
                                    </tr>
                                    <tr>
                                        <td>Mini</td>
                                        <th><#if mini32??>V ${mini32.versionNumber!'-'}<#else>-</#if></th>
                                        <td>
                                            <a href=#"" data-path="<#if mini32??>${mini32.filePath!}</#if>" class="download"><#if mini32??>${mini32.filePathStr!'-'}<#else></#if></a>

                                        </td>
                                        <#--<td>Initial release Version</td>-->
                                        <td><#if mini32??>${mini32.updateDatetime?string["yyyy-MM-dd"]}<#else></#if></td>
                                    </tr>

                                    <tr>
                                        <td rowspan="2">Windows10-64bit</td>
                                        <td>Studio</td>
                                        <th><#if studio64??>V ${studio64.versionNumber!'-'}<#else>-</#if></th>
                                        <td>

                                            <a href=#"" data-path="<#if studio64??>${studio64.filePath!}</#if>" class="download"><#if studio64??>${studio64.filePathStr!'-'}</#if></a>
                                        </td>
                                        <#--<td>Initial release Version</td>-->
                                        <td><#if studio64??>${studio64.updateDatetime?string["yyyy-MM-dd"]}<#else>-</#if></td>
                                    </tr>
                                    <tr>
                                        <td>Mini</td>
                                        <th><#if mini64??>V ${mini64.versionNumber!'-'}<#else>-</#if></th>
                                        <td>

                                            <a href=#"" data-path="<#if mini64??>${mini64.filePath!}</#if>" class="download"><#if mini64??>${mini64.filePathStr!'-'}</#if></a>
                                        </td>
                                        <#--<td>Initial release Version</td>-->
                                        <td><#if mini64??>${mini64.updateDatetime?string["yyyy-MM-dd"]}<#else>-</#if></td>
                                    </tr>
                                </tbody>
                            </table>
                            <#--<div class="text-center mt-3">-->
                                <#---->
                            <#--</div>-->

                    


                </div>
            </div>
        </div>
        <!-- 계약회원일경우 끝 -->

    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script src="/assets/js/jquery.filedownload.min.js"></script>
<script>
    $(function(){
        $(".download").click(function(){
            var path = $(this).data("path");
            $.fileDownload(path);
        })
    })
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">