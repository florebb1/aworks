<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<div class="sub-title-bg background-base-code background-h4">
    계약관리
</div>

<section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>계약관리</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>계약관리<i class="icon-cheveron-right"></i>대시보드</h5>
            </div>
        </div>
        <hr class="mt-1 mb-5">
    </div>
</section>

<section class="place-wrap-top-none">
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
                <#--  <a href="/mypage/contract_management" class="cs-menu active">대시보드</a>  -->
                <a href="/mypage/contract_management_info" class="cs-menu">계약정보관리</a>
                <a href="/mypage/contract_management_license" class="cs-menu">라이선스관리</a>
                <a href="/mypage/contract_management_abbyy" class="cs-menu">ABBYY관리</a>
                <#--<a href="/mypage/contract_management_download" class="cs-menu">다운로드</a>-->
            </div>
            <div class="col-12">
                <div class="card minh-640 mt-4">

                    <div class="row justify-content-center">



                        <div class="col-10 mt-5">
                            <h4>정보</h4>
                        </div>
                        <div class="col-10">
                            <div class="card-group text-center">
                                <div class="card">
                                    <img src="..." class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <h5 class="card-title">Cloud User</h5>
                                        <p class="card-text">최초 계약일 2018년 12월 04일</p>
                                    </div>
                                </div>
                                <div class="card">
                                    <img src="..." class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <h5 class="card-title">Card title</h5>
                                        <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
                                        <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="col-10 mt-5">
                            <h4>라이선스</h4>
                        </div>
                        <div class="col-10">
                            <div class="card-group text-center">
                                <div class="card">
                                    <img src="..." class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <h5 class="card-title">라이선스 현황</h5>
                                        <p class="card-text">Total : 1EA</p>
                                        <p class="card-text">
                                            <small class="text-muted">2018년 12월 18일 ~ 2019년 12월 17일</small><br>
                                            <small class="text-muted">2018년 12월 18일 ~ 2019년 12월 17일</small><br>
                                            <small class="text-muted">2018년 12월 18일 ~ 2019년 12월 17일</small>
                                        </p>
                                    </div>
                                </div>
                                <div class="card">
                                    <img src="..." class="card-img-top" alt="...">
                                    <div class="card-body">
                                        <h5 class="card-title">ABBYY 현황</h5>
                                        <p class="card-text">Total : 1EA</p>
                                        <p class="card-text">
                                            <small class="text-muted">2018년 12월 18일 ~ 2019년 12월 17일</small><br>
                                            <small class="text-muted">2018년 12월 18일 ~ 2019년 12월 17일</small><br>
                                            <small class="text-muted">2018년 12월 18일 ~ 2019년 12월 17일</small>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>

                </div>
            </div>
        </div>
        <!-- 계약회원일경우 끝 -->

    </div>
</section>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">