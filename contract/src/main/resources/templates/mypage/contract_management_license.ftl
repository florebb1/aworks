<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<#import "../pagination.ftl" as pagination />

<style>
body {
  position: relative;
}


/* Tooltip container */
.tooltip {
    position: relative;
    /*display: inline-block;*/
    /*border-bottom: 1px dotted black; !* If you want dots under the hoverable text *!*/
}
.tooltipa {
    position:relative
}
/* Tooltip text */
.tooltiptext {
    visibility: hidden;
    position: absolute;
    width: 120px;
    background-color: #555;
    color: #fff;
    text-align: center;
    padding: 5px 0;
    border-radius: 6px;
    z-index: 1;

}

.tooltiptext::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

.tooltiptext {
    width: 120px;
    bottom: 125%;
    left: 50%;
    margin-left: -60px; /* Use half of the width (120/2 = 60), to center the tooltip */
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltipa:hover .tooltiptext {
    visibility: visible;
}

</style>


<div class="sub-title-bg background-base-code background-h4">
    계약관리
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>라이선스관리</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>계약관리<i class="icon-cheveron-right"></i>라이선스관리</h5>
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
                <a href="/mypage/contract_management_license" class="cs-menu active">라이선스관리</a>
                <#--  <a href="/mypage/contract_management_abbyy" class="cs-menu">ABBYY관리</a>  -->
                <a href="/mypage/contract_management_download" class="cs-menu">다운로드</a>
            </div>


                        <#--<div class="col-10 mt-5">-->
                            <#--<h2>라이선스 발급 현황</h2>-->
                            <#--<div class="row">-->
                                <#--<div class="col-4">-->
                                    <#--<div class=" card">-->
                                        <#--&lt;#&ndash;<img src="..." class="card-img-top" alt="...">&ndash;&gt;-->
                                        <#--<div class="card-body">-->
                                            <#--<h5 class="card-title">Work Center</h5>-->
                                            <#--<p class="card-text">-->
                                                <#--Attended : 0EA / 1EA<br>-->
                                                <#--UnAttended : 0EA / 1EA<br>-->
                                                <#--Develop : 0EA / 1EA-->
                                            <#--</p>-->
                                            <#--&lt;#&ndash;<a href="#" class="btn btn-block btn-outline-info" data-toggle="modal" data-target="#lincense-input">신 청</a>&ndash;&gt;-->
                                        <#--</div>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="col-4">-->
                                    <#--<div class="card">-->
                                        <#--&lt;#&ndash;<img src="..." class="card-img-top" alt="...">&ndash;&gt;-->
                                        <#--<div class="card-body">-->
                                            <#--<h5 class="card-title">Mini</h5>-->
                                            <#--<p class="card-text">-->
                                                <#--Attended : 0EA / 1EA<br>-->
                                                <#--UnAttended : 0EA / 1EA<br><Br>-->
                                            <#--</p>-->
                                            <#--&lt;#&ndash;<a href="#" class="btn btn-block btn-outline-info" data-toggle="modal" data-target="#mini-input">신 청</a>&ndash;&gt;-->
                                        <#--</div>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="col-4">-->
                                    <#--<div class="card">-->
                                        <#--&lt;#&ndash;<img src="..." class="card-img-top" alt="...">&ndash;&gt;-->
                                        <#--<div class="card-body">-->
                                            <#--<h5 class="card-title">Studio</h5>-->
                                            <#--<p class="card-text">-->
                                                <#--Attended : 0EA / 1EA<br>-->
                                                <#--UnAttended : 0EA / 1EA<br><br>-->
                                            <#--</p>-->
                                            <#--&lt;#&ndash;<a href="#" class="btn btn-block btn-outline-info" data-toggle="modal" data-target="#studio-input">신 청</a>&ndash;&gt;-->
                                        <#--</div>-->
                                    <#--</div>-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</div>-->

                        <div class="col-12 card mt-5 p-5 minh-480">

                            <form id="searchForm">
                                <input type="hidden" id="row" name="row" value="${row}">
                                <div class="form-row mb-3">
                                    <div class="col-4">
                                        <div class="form-row">
                                            <div class="col">
                                                <input type="text" id="datestart" name="startDate" style="background:#fff" class="form-control" placeholder="날짜선택" readonly autocomplete="off">
                                            </div>
                                            <div class="col-auto">~</div>
                                            <div class="col">
                                                <input type="text" id="dateend" name="endDate" style="background:#fff" class="form-control" placeholder="날짜선택" readonly autocomplete="off">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-4">
                                        <select class="custom-select" name="licenseType" id="licenseType">
                                            <option value="">라이선스 종류 선택</option>
                                            <option value="1">PC형</option>
                                            <option value="2">Cloud 형</option>
                                            <option value="3">On-Premise 형</option>
                                        </select>
                                    </div>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="searchWord" id="searchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search">
                                            <div class="input-group-append">
                                                <button class="btn btn-info d-flex align-items-center" type="submit" id="button-search">
                                                    <i class="icon-magnifying-glass"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <#-- <div class="col-2">
                                        <button class="btn btn-light btn-block" data-toggle="modal" data-target="#exampleModal">사용자 등록</button>
                                        <a href="#" class="btn btn-info btn-block" data-toggle="modal" data-target="#lincense-input">신 청</a>
                                    </div> -->
                                </div>
                            </form>

                            <hr>

                            <form>
                                <div class="form-row mb-3">
                                    <div class="col d-flex justify-content-start">
                                        <#--<button type="button" class="btn btn-secondary">선택삭제</button>-->
                                        <button type="button" class="btn btn-secondary ml-1" onclick="excelDownload()">엑셀 다운로드</button>
                                    </div>
                                    <div class="col d-flex justify-content-end">
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <button type="button" class="btn btn-info btn-row" data-row="10">10개</button>
                                            <button type="button" class="btn btn-outline-secondary btn-row" data-row="20">20개</button>
                                            <button type="button" class="btn btn-outline-secondary btn-row" data-row="30">30개</button>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <table class="table">
                                <colgroup>
                                    <col width="40px">
                                    <col width="80px">
                                    <col width="140px">
                                    <col width="">
                                    <col width="">
                                    <col width="120px">
                                    <col width="120px">
                                    <col width="120px">
                                    <col width="160px">
                                    <col width="100px">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">
                                        <div class="form-check">
                                            <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                        </div>
                                    </th>
                                    <th scope="col">No</th>
                                    <#--<th scope="col">등록일</th>-->
                                    <th scope="col">계약번호</th>
                                    <th scope="col">라이선스 종류</th>
                                    <th scope="col">기간</th>
                                    <th scope="col">UnAttended</th>
                                    <th scope="col">Attended</th>
                                    <th scope="col">Studio</th>
                                    <th scope="col">WorkCenter Count</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody id="licenseList">

                                </tbody>
                            </table>


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
        <!-- 계약회원일경우 끝 -->

    </div>
    <table id="licenseListByExeclTable" style="display:none;">
        <thead>
        <#--<tr>-->
            <#--<th scope="col">No</th>-->
            <#--<th scope="col">계약방식</th>-->
            <#--<th scope="col">라이선스 종류</th>-->
            <#--<th scope="col">시작일</th>-->
            <#--<th scope="col">종료일</th>-->
            <#--<th scope="col">UnAttended</th>-->
            <#--<th scope="col">Attended</th>-->
            <#--<th scope="col">Studio</th>-->
        <#--</tr>-->
        <tr>
            <th scope="col">No</th>
            <th scope="col">계약번호</th>
            <th scope="col">계약명</th>
            <th scope="col">시작일</th>
            <th scope="col">종료일</th>
            <th scope="col">계약상태</th>
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
            <th scope="col">라이선스 상태</th>
            <th scope="col">등록일</th>
        </tr>
        </thead>
        <tbody id="licenseListByExeclBody"></tbody>
    </table>
</section>
<div class="modal fade" id="license-input" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">라이선스 사용 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form class="pl-3 pr-3 pt-4 pb-4" id="addForm">
                    <input type="hidden" name="licenseSeq" id="wlicenseSeq">
                    <input type="hidden" name="comUuid" id="comUuid">
                    <input type="hidden" id="limit1">
                    <input type="hidden" id="limit2">
                    <input type="hidden" id="limit3">
                    <input type="hidden" id="limit4">
                    <input type="hidden" id="checkLicenseType">
                    <input type="hidden" id="checkSubscribeType">
                    <div class="form-row pb-4">
                        <div class="col-4 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">License Name</div>
                        </div>
                        <div class="col-6">
                            <input type="text" class="form-control" name="licenseName" id="licenseName" aria-describedby="" placeholder="License 이름을 입력하세요" maxlength="20">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col-4 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">Organization</div>
                        </div>
                        <div class="col-6">
                            <div class="form-group mb-0" id="modalFile"></div>
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col-4 d-flex justify-content-end align-items-center">
                            <div class="pl-2text-right">UnAttended Bot Count</div>
                        </div>
                        <div class="col-6">
                            <input type="text" class="form-control" id="countUnattended" name="countUnattended" aria-describedby="" placeholder=""  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('1')" maxlength="10">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col-4 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">Attended Bot Count</div>
                        </div>
                        <div class="col-6">
                            <input type="text" class="form-control" id="countAttended" name="countAttended" aria-describedby="" placeholder="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('2')"  maxlength="10">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col-4 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">Studio Count</div>
                        </div>
                        <div class="col-6">
                            <input type="text" class="form-control" id="countDeveloper" name="countDeveloper" aria-describedby="" placeholder="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('3')" maxlength="10">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col-4 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">Work Center Count</div>
                        </div>
                        <div class="col-6">
                            <input type="text" class="form-control" id="countWorkcenter" name="countWorkcenter" aria-describedby="" placeholder="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');checkLimit('4')" maxlength="10">
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer justify-content-center align-items-center">
                <button type="button" class="btn btn btn-outline-secondary" data-dismiss="modal">취 소</button>
                <button type="button" class="btn btn-info btn-wc-apply">신 청</button>
                <button type="button" class="btn btn-info btn-wc-apply_old">V1.0.1 신 청</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="mini-input" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">라이선스 사용 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form class="pl-3 pr-3 pt-4 " id="miniForm">
                    <input type="hidden" name="licenseType" value="1">
                    <input type="hidden" name="botType" value="1">
                    <input type="hidden" name="licenseSeq" id="mlicenseSeq">
                    <input type="hidden" id="mlimit1">
                    <input type="hidden" id="mlimit2">
                    <input type="hidden" id="mlimit3">
                    <div class="form-row pb-4">
                        <div class="col-3 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">License Name</div>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control" name="licenseName" id="mlicenseName" aria-describedby="" placeholder="License 이름을 입력하세요" maxlength="20">
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col-3 d-flex justify-content-end align-items-center">
                            <div class="pl-2 text-right">Mac Address</div>
                        </div>

                        <div class="col-7">
                            <input type="text" class="form-control" name="macAddress" id="minimac" aria-describedby="" placeholder="aa:bb:cc:dd:ee:ff" maxlength="17">
                        </div>
                    </div>
                    <#--<div style="padding-left:8px">Mac 정보를 잘 못 입력한 경우 A.WORKS홈페이지 > 고객지원 > Contact Us > 1:1문의를 이용해 주세요</div>-->

                    <#--<div class="form-row pn-4">-->
                        <#--<div class="col d-flex justify-content-start align-items-center">-->
                            <#--<div class="pl-2 pb-3 text-right">Bot Type</div>-->
                        <#--</div>-->
                        <#--<div class="col-6">-->
                            <#--<select class="form-control" name="botType">-->
                                <#--<option value="0">Unattended</option>-->
                                <#--<option value="1">Attended</option>-->
                            <#--</select>-->

                        <#--</div>-->
                        <#--<div class="col d-flex justify-content-start align-items-center">-->

                        <#--</div>-->
                    <#--</div>-->
                </form>

            </div>

            <div class="privacy-text text-center pt-3 mb-3" style="border-top:1px solid #e9ecef">
                Mac 정보를 잘 못 입력한 경우 A.WORKS홈페이지 > 고객지원 > 1:1문의를 이용해 주세요
            </div>
            <div class="modal-footer justify-content-center align-items-center">

                <div style="display:block">
                    <button type="button" class="btn btn btn-outline-secondary" data-dismiss="modal">취 소</button>
                    <button type="button" class="btn btn-info btn-mini-apply">신 청</button>
                </div>

            </div>
        </div>
    </div>
</div>
<#--<div class="modal fade" id="studio-input" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">-->
    <#--<div class="modal-dialog modal-lg modal-dialog-centered" role="document">-->
        <#--<div class="modal-content">-->
            <#--<div class="modal-header">-->
                <#--<h5 class="modal-title" id="exampleModalCenterTitle">라이선스 사용 등록</h5>-->
                <#--<button type="button" class="close" data-dismiss="modal" aria-label="Close">-->
                    <#--<span aria-hidden="true">&times;</span>-->
                <#--</button>-->
            <#--</div>-->
            <#--<div class="modal-body">-->

                <#--<form class="pl-3 pr-3 pt-4 pb-4" id="studioForm">-->
                    <#--<input type="hidden" name="licenseType" value="2">-->
                    <#--<input type="hidden" name="botType" value="1">-->
                    <#--<input type="hidden" name="licenseSeq" id="slicenseSeq">-->
                    <#--<input type="hidden" id="slimit1">-->
                    <#--<input type="hidden" id="slimit2">-->
                    <#--<input type="hidden" id="slimit3">-->
                    <#--<div class="form-row pb-4">-->
                        <#--<div class="col-3 d-flex justify-content-end align-items-center">-->
                            <#--<div class="pl-2 text-right">License Name</div>-->
                        <#--</div>-->
                        <#--<div class="col-6">-->
                            <#--<input type="text" class="form-control" name="licenseName" id="slicenseName" aria-describedby="" placeholder="License 이름을 입력하세요" maxlength="20">-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--<div class="form-row pb-4">-->
                        <#--<div class="col-3 d-flex justify-content-end align-items-center">-->
                            <#--<div class="pl-2 text-right">Mac Address</div>-->
                        <#--</div>-->
                        <#--<div class="col-6">-->
                            <#--<input type="text" class="form-control" name="macAddress" id="studiomac" aria-describedby="" placeholder="aa:bb:cc:dd:ee:ff" maxlength="17">-->
                        <#--</div>-->
                    <#--</div>-->
                    <#--&lt;#&ndash;<div >Mac 정보를 잘 못 입력한 경우 A.WORKS홈페이지 > 고객지원 > Contact Us > 1:1문의를 이용해 주세요</div>&ndash;&gt;-->

                    <#--&lt;#&ndash;<div class="form-row pn-4">&ndash;&gt;-->
                        <#--&lt;#&ndash;<div class="col d-flex justify-content-start align-items-center">&ndash;&gt;-->
                            <#--&lt;#&ndash;<div class="pl-2 pb-3 text-right">Bot Type</div>&ndash;&gt;-->
                        <#--&lt;#&ndash;</div>&ndash;&gt;-->
                        <#--&lt;#&ndash;<div class="col-6">&ndash;&gt;-->
                            <#--&lt;#&ndash;<select class="form-control" name="botType">&ndash;&gt;-->
                                <#--&lt;#&ndash;<option value="0">Unattended</option>&ndash;&gt;-->
                                <#--&lt;#&ndash;<option value="1">Attended</option>&ndash;&gt;-->
                            <#--&lt;#&ndash;</select>&ndash;&gt;-->

                        <#--&lt;#&ndash;</div>&ndash;&gt;-->
                        <#--&lt;#&ndash;<div class="col d-flex justify-content-start align-items-center">&ndash;&gt;-->

                        <#--&lt;#&ndash;</div>&ndash;&gt;-->
                    <#--&lt;#&ndash;</div>&ndash;&gt;-->

                <#--</form>-->

            <#--</div>-->
            <#--<div class="privacy-text text-center pt-2 mb-3">-->
                <#--Mac 정보를 잘 못 입력한 경우 A.WORKS홈페이지 > 고객지원 > Contact Us > 1:1문의를 이용해 주세요-->
            <#--</div>-->
            <#--<div class="modal-footer justify-content-center align-items-center">-->

                <#--<div style="display:block">-->
                    <#--<button type="button" class="btn btn btn-outline-secondary" data-dismiss="modal">취 소</button>-->
                    <#--<button type="button" class="btn btn-info btn-studio-apply">신 청</button>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->
<div class="modal fade" id="licenseDetail" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document" style="max-width:900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">라이선스 사용 목록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" >
                <div style="min-height:330px">
                    <table class="table-modal" id="tableInfo">

                    </table>
                </div>
                <nav id="pagingModal" class="d-flex justify-content-center">

                </nav>
            </div>
            <div class="modal-footer justify-content-center align-items-center">
                <button type="button" class="btn btn btn-outline-secondary" data-dismiss="modal">닫 기</button>

            </div>
        </div>
    </div>
</div>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<script type="text/javascript" src="/assets/js/fileSaver.min.js"></script>
<!-- custom script 위치 -->
<script>
    $(function(){
        getList(0,true);
        $("#allCheck").click(function(){
            if($(this).is(":checked")){
                $(".listCheck").prop("checked",true);
            }else{
                $(".listCheck").prop("checked",false);
            }
        });
        $("body").on("click",".listCheck", function(){
            // alert(1)
            var class_length = $(".listCheck").length;
            var checked_length = 0;
            $(".listCheck").each(function(){
                if($(this).is(":checked")) checked_length++;
            });

            if($(this).is(":checked")) {
                if(class_length <= checked_length) $("#allCheck").prop("checked", true);
            } else {
                $("#allCheck").prop("checked", false);
            }
        });
        $("#searchForm").submit(function(){
            if($("#datestart").val() != "" && $("#dateend").val() == ""){
                alert("검색 날짜를 입력하시기 바랍니다.");
                return false;
            }
            if($("#datestart").val() == "" && $("#dateend").val() != ""){
                alert("검색 날짜를 입력하시기 바랍니다.");
                return false;
            }
            if($("#datestart").val() != "" && $("#dateend").val() != ""){
                if($("#datestart").val() > $("#dateend").val()){
                    alert("검색 날짜를 다시 설정하시기 바랍니다.");
                    return false;
                }

            }
            getList(0,true);
            return false;
        })

        $("body").on("change","#comUuidFile",function(){
            var inputFiles = this.files;
            if(inputFiles == undefined || inputFiles.length == 0) return;


            var file = inputFiles[0];
            //console.log(file);

            // 섬네일 생성
            var reader = new FileReader();
            reader.onload = function (event) {
                var contents = event.target.result;

                // console.log(contents);
                $("#comUuid").val(contents);
            };
            reader.readAsText(inputFiles[0]);
        })
        $(".btn-row").click(function(){
            $("#row").val($(this).data("row"));
            $(".btn-row").removeClass("btn-info").removeClass("btn-outline-secondary").addClass("btn-outline-secondary");

            $(this).removeClass("btn-outline-secondary").addClass("btn-info");
            getList(0,true);
            // $("#searchForm").submit();
        });

        $('#mini-input').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget)
            var licenseSeq = button.data("licenseseq");
            var limit1 = button.data("limit1");
            var limit2 = button.data("limit2");
            var limit3 = button.data("limit3");
            // if(limit2 == 0){
            //     alert("신청 갯수를 초과 했습니다.");
            //     return;
            // }
            console.log(licenseSeq);
            $("#mlicenseSeq").val(licenseSeq);
            $("#mlimit1").val(limit1);
            $("#mlimit2").val(limit2);
            $("#mlimit3").val(limit3);
        });

        $('#studio-input').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget)
            var licenseSeq = button.data("licenseseq");
            console.log(licenseSeq);
            var limit1 = button.data("limit1");
            var limit2 = button.data("limit2");
            var limit3 = button.data("limit3");
            // if(limit2 == 0){
            //     alert("신청 갯수를 초과 했습니다.");
            //     return false;
            // }
            $("#slicenseSeq").val(licenseSeq);
            $("#slimit1").val(limit1);
            $("#slimit2").val(limit2);
            $("#slimit3").val(limit3);
        });

        $('#license-input').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget)
            var licenseSeq = button.data("licenseseq");
            console.log(licenseSeq);
            var limit1 = button.data("limit1");
            var limit2 = button.data("limit2");
            var limit3 = button.data("limit3");
            var limit4 = button.data("limit4");
            $("#wlicenseSeq").val(licenseSeq);
            $("#limit1").val(limit1);
            $("#limit2").val(limit2);
            $("#limit3").val(limit3);
            $("#limit4").val(limit4);
            $("#modalFile").html("");
            $("#checkLicenseType").val(button.data("licensetype"));
            $("#checkSubscribeType").val(button.data("subscribetype"));

            console.log(button.data("licensetype")+"::"+button.data("subscribetype"));
            if(button.data("licensetype") == "2" && button.data("subscribetype") == "1"){
                $("#countAttended").attr("readonly","readonly");
                $("#countDeveloper").attr("readonly","readonly");
                $("#countWorkcenter").attr("readonly","readonly");

            }else if(button.data("licensetype") == "2" && button.data("subscribetype") == "3"){
                $("#countWorkcenter").attr("readonly", "readonly");
            }else{
                $("#countAttended").attr("readonly",false);
                $("#countDeveloper").attr("readonly",false);
                $("#countWorkcenter").attr("readonly",false);
            }
            var html = '<div class="form-row">\n' +
                '                                    <div class="col-12">\n' +
                '                                        <div class="custom-file">\n' +
                '                                            <input type="file" class="custom-file-input border-radius-none" id="comUuidFile">\n' +
                '                                            <label class="custom-file-label border-radius-none" for="comUuid">파일을 첨부해 주세요.</label>\n' +
                '                                            <div class="invalid-feedback border-radius-none">Example invalid custom file feedback</div>\n' +
                '                                        </div>\n' +
                '\n' +
                '                                    </div>\n' +
                '\n' +
                '                                </div>';
            $("#modalFile").html(html);
        });

        $(".btn-wc-apply").click(function(){
            if($("#licenseName").val() == ""){
                alert("License Name을 입력하시기 바랍니다.");
                return false;
            }
            if($("#comUuid").val() == ""){
                alert("Organization 파일을 업로드 해주시기 바랍니다.");
                return false;
            }
            if($("#checkLicenseType").val() == "2" && $("#checkSubscribeType").val() == "1"){
                if($("#countUnattended").val() == ""){
                    alert("Unattended Bot Count를 1개 이상 입력하시기 바랍니다.");
                    return false;
                }
                if($("#countUnattended").val() == 0){
                    alert("Unattended Bot Count를 1개 이상 입력하시기 바랍니다.");
                    return false;
                }
            }else{
                if($("#countUnattended").val() == "" && $("#countAttended").val() == "" && $("#countDeveloper").val() == "" && $("#countWorkcenter").val() == ""){
                    alert("1개 이상의 라이선스를 입력하시기 바랍니다.");
                    return false;
                }

                if($("#countUnattended").val() == 0 && $("#countAttended").val() == 0 && $("#countDeveloper").val() == 0 && $("#countWorkcenter").val() == 0){
                    alert("신청개수는 1개 이상이어야 합니다.");
                    return false;
                }

                if($("#countDeveloper").val() == 0 || $("#countDeveloper").val() == ""){
                    if($("#countWorkcenter").val() > 0){
                        alert("Studio 신청개수를 입력하시기 바랍니다.(Work Center는 단독으로 신청이 불가능합니다. Studio와 함께 신청해주세요");
                        return false;
                    }
                }
            }

            if($("#countDeveloper").val() == 0 || $("#countDeveloper").val() == ""){
                if($("#countWorkcenter").val() > 0){
                    alert("Studio 신청개수를 입력하시기 바랍니다.(Work Center는 단독으로 신청이 불가능합니다. Studio와 함께 신청해주세요");
                    return false;
                }
            }

            if(confirm("라이선스를 신청하시겠습니까?")){
                var datas = $("#addForm").serialize();
                $.ajax({
                    url: "/mypage/license_apply",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("신청 되었습니다.");
                            var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license_"+$("#licenseName").val()+".license");
                            setTimeout(function () {
                                location.reload();
                            }, 500);
                        }else{

                            if(response.over === undefined){
                                if(response.code == "-1"){
                                    alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                    return false;
                                }else{
                                    alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                                }
                            }else{
                                var resultmsg = [];
                                for(var i = 0; i < response.over.length;i++){
                                    if(response.over[i] != ""){
                                        resultmsg.push(response.over[i]);
                                    }
                                }
                                alert(resultmsg.join(",")+" 할당량을 초과 하였습니다. 다시 확인해주시기 바랍니다.");
                            }

                        }
                    }
                });
            }
        })

        $(".btn-wc-apply_old").click(function(){
            if($("#licenseName").val() == ""){
                alert("License Name을 입력하시기 바랍니다.");
                return false;
            }
            if($("#countUnattended").val() == "" && $("#countAttended").val() == "" && $("#countDeveloper").val() == ""){
                alert("신청개수를 입력하시기 바랍니다.");
                return false;
            }
            if(confirm("라이선스를 신청하시겠습니까?")){
                var datas = $("#addForm").serialize();
                $.ajax({
                    url: "/mypage/license_apply_old",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("신청 되었습니다.");
                            var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license.txt");
                            setTimeout(function () {
                                location.reload();
                            }, 500);
                        }else{
                            if(response.over === undefined){
                                if(response.code == "-1"){
                                    alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                    return false;
                                }else{
                                    alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                                }

                            }else{
                                var resultmsg = [];
                                for(var i = 0; i < response.over.length;i++){
                                    if(response.over[i] != ""){
                                        resultmsg.push(response.over[i]);
                                    }
                                }
                                alert(resultmsg.join(",")+" 할당량을 초과 하였습니다. 다시 확인해주시기 바랍니다.");
                            }

                        }
                    }
                });
            }
        })

        $(".btn-mini-apply").click(function(){
            if($("#mlimit2").val() == 0){
                alert("신청 개수를 초과 하셨습니다. 신청이 불가능합니다.");
                return false;
            }
            if($("#mlicenseName").val() == ""){
                alert("License Name을 입력하시기 바랍니다.");
                return false;
            }
            if($("#minimac").val() == ""){
                alert("Mac Address를 입력하시기 바랍니다.");
                return false;
            }

            var regex = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/;
            if(!regex.test($("#minimac").val())) {
                alert("Mac주소 형식에 알맞게 입력하세요\n(예 : aa-bb-cc-dd-ee-ff 또는 11:22:33:44:55:66)");
                return false;
            }
            if(confirm("라이선스를 신청하시겠습니까?")){
                var datas = $("#miniForm").serialize();
                $.ajax({
                    url: "/mypage/license_serial_make",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("신청 되었습니다.");
                            var blob = new Blob([response.data], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license_"+$("#mlicenseName").val()+".license");
                            setTimeout(function () {
                                location.reload();
                            }, 500);
                        }else{
                            if(response.msg !== undefined){
                                alert("이미 등록된 Mac Address입니다.");
                            }else{
                                if(response.code == "-1"){
                                    alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                    return false;
                                }else{
                                    alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                                }
                            }
                        }
                    }
                });
            }
        })

        $(".btn-studio-apply").click(function(){
            if($("#slimit2").val() == 0){
                alert("신청 개수를 초과 하셨습니다. 신청이 불가능합니다.");
                return false;
            }
            if($("#slicenseName").val() == ""){
                alert("License Name을 입력하시기 바랍니다.");
                return false;
            }
            if($("#studiomac").val() == ""){
                alert("Mac Address를 입력하시기 바랍니다.");
                return false;
            }
            var regex = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/;
            if(!regex.test($("#studiomac").val())) {
                alert("Mac주소 형식에 알맞게 입력하세요\n(예 : aa-bb-cc-dd-ee-ff 또는 11:22:33:44:55:66)");
                return false;
            }

            if(confirm("라이선스를 신청하시겠습니까?")){
                var datas = $("#studioForm").serialize();
                $.ajax({
                    url: "/mypage/license_serial_make",
                    type: 'POST',
                    dataType: 'JSON',
                    data: datas,
                    success: function (response) {
                        console.log(response);
                        if(response.result){
                            alert("신청 되었습니다.");
                            var blob = new Blob([response.license], {type: "text/plain;charset=utf-8"});
                            saveAs(blob, "license.license");
                            setTimeout(function () {
                                location.reload();
                            }, 500);
                        }else{
                            if(response.msg !== undefined){
                                alert("이미 등록된 Mac Address입니다.");
                            }else{
                                if(response.errorCode == "-1"){
                                    alert("같은 조직 내 동일한 라이선스 이름이 있습니다. 다른이름으로 등록해주세요");
                                    return false;
                                }else{
                                    alert("신청 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                                }
                            }

                        }
                    }
                });
            }
        })

        $("#licenseDetail").on("show.bs.modal",function(event){
            var button = $(event.relatedTarget);
            var seq = button.data("seq");
            var licenseType = button.data("licensetype")
            var useyn = button.data("useyn");
            getLicenseList(seq,licenseType,0,useyn);

        })
//<button class="btn btn-info reDownloadOld" type="button" data-seq="'+response.list[i].seq+'">V1.0.1 다운로드</button>
        $("body").on("click",".reDownload", function(){
            if(confirm("라이선스 파일을 다운로드 하시겠습니까?")) {
                var seq = $(this).data("seq");
                // alert(seq);
                $.ajax({
                    url: "/mypage/re_download",
                    type: 'GET',
                    data: "seq=" + seq,
                    dataType: 'JSON',
                    success: function (response) {
                        // alert(response);
                        var blob = new Blob([response.data.license], {type: "text/plain;charset=utf-8"});
                        saveAs(blob, "license_"+response.data.licenseName+".license");
                        // setTimeout(function () {
                        //     location.reload();
                        // }, 500);
                        // location.reload();
                    }
                });
            }
        })

        $("body").on("click",".reDownloadOld", function(){
            if(confirm("V1.0.1 라이선스 파일을 다운로드 하시겠습니까?")) {
                var seq = $(this).data("seq");
                $.ajax({
                    url: "/mypage/re_download_old",
                    type: 'GET',
                    data: "seq=" + seq,
                    dataType: 'JSON',
                    success: function (response) {
                        var blob = new Blob([response.data.license], {type: "text/plain;charset=utf-8"});
                        saveAs(blob, "license.txt");
                        // setTimeout(function () {
                        //     location.reload();
                        // }, 500);
                        // location.reload();
                    }
                });
            }
        })

        $("body").on("click",".reEmailsend", function(){
            if(confirm("라이선스 파일을 메일로 발송 하시겠습니까?\n${s_user.s_loginId}으로 메일이 발송됩니다.")) {
                var seq = $(this).data("seq");
                $.ajax({
                    url: "/mypage/re_emailsend",
                    type: 'GET',
                    data: "seq=" + seq + "&email=${s_user.s_loginId}",
                    dataType: 'JSON',
                    success: function (response) {
                        alert("발송되었습니다");
                    }
                });
            }
        })
    })
    function getList(num,refresh){
        var datas = $("#searchForm").serialize()+"&page="+num;
        $.ajax({
            url: "/mypage/ajax_license",
            type: 'GET',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                console.log(response);
                var html = "";
                var totalUseUnAttended = 0;
                var totalUseAttended = 0;
                var totalUseStudio = 0;
                var totalUseWorkcenter = 0;
                var totalUnAttended = 0;
                var totalAttended = 0;
                var totalStudio = 0;
                var totalWorkcenter = 0;

                for(var i =0 ; i< response.list.length;i++){
                    var licenseUse = true;
                    var startdate = moment(response.list[i].contractStart).format("YYYY-MM-DD");
                    var enddate = moment(response.list[i].contractEnd).format("YYYY-MM-DD");
                    var today = moment(new Date()).format("YYYY-MM-DD");
                    var left1 = response.list[i].countUnattended - response.list[i].countUnAttendedUse;
                    var left2 = response.list[i].countAttended - response.list[i].countAttendedUse;
                    var left3 = response.list[i].countStudio - response.list[i].countStudioUse;
                    var left4 = response.list[i].countWorkcenter - response.list[i].countWorkcenterUse;
                    var errorMsg;



                    if(left1 == 0 && left2 == 0 && left3 == 0 && left4 == 0){
                        licenseUse = false
                        errorMsg = "발급개수 부족"
                    }

                    if(enddate != "" && enddate < today){
                        licenseUse = false
                        errorMsg = "계약기간 만료"
                    }

                    if(response.list[i].licenseStatus == 1 ) {

                        licenseUse = false
                        errorMsg = "관리자 사용불가 처리";
                    }
                    var no = response.total-(num*$("#row").val()+i);
                    if(response.list[i].licenseType == "1"){
                        var licenseType = 'PC형';
                    }else if(response.list[i].licenseType == "2"){
                        var licenseType = 'Cloud형';
                    }else{
                        var licenseType = 'on-Premise형';
                    }
                    html += '<tr>\
                                <th scope="row">\
                                <div class="form-check">\
                                    <input class="listCheck form-check-input position-static" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                                </th>\
                                <th data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+no+'</th>\
                                <td data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+response.list[i].contractNumber+'</td>\
                                <td data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>';
                                if(response.list[i].contractType == "1"){
                                    html += 'Pilot';
                                }else if(response.list[i].contractType == "2"){
                                    html += 'PoC';
                                }else{
                                    html += '본사업';
                                }
                            html += '<br>'+licenseType+'</td>\
                                <td style="cursor: pointer" data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+moment(response.list[i].contractStart).format("YYYY-MM-DD")+'<br>'+moment(response.list[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                                <td data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+$.number(response.list[i].countUnAttendedUse)+'/'+$.number(response.list[i].countUnattended)+'</td>\
                                <td data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+$.number(response.list[i].countAttendedUse)+'/'+$.number(response.list[i].countAttended)+'</td>\
                                <td data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+$.number(response.list[i].countStudioUse)+'/'+$.number(response.list[i].countStudio)+'</td>\
                                <td data-target="#licenseDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'" data-licensetype="'+response.list[i].licenseType+'" data-useyn='+licenseUse+'>'+$.number(response.list[i].countWorkcenterUse)+'/'+$.number(response.list[i].countWorkcenter)+'</td>';
                            if(licenseUse) {
                                if (response.list[i].licenseType == 1) {
                                    html += '<td><button class="btn btn-sm btn-info" type="button" data-toggle="modal" data-target="#mini-input" data-licenseseq="' + response.list[i].seq + '" data-limit1="' + (response.list[i].countUnattended - response.list[i].countUnAttendedUse) + '" data-limit2="' + (response.list[i].countAttended - response.list[i].countAttendedUse) + '" data-limit3="' + (response.list[i].countStudio - response.list[i].countStudioUse) + '">발급</button></td>'
                                } else if (response.list[i].licenseType == 2) {
                                    html += '<td><button class="btn btn-sm btn-info" type="button" data-toggle="modal" data-target="#license-input" data-licensetype="' + response.list[i].licenseType + '" data-subscribetype="' + response.list[i].subscribeType + '" data-licenseseq="' + response.list[i].seq + '" data-limit1="' + (response.list[i].countUnattended - response.list[i].countUnAttendedUse) + '" data-limit2="' + (response.list[i].countAttended - response.list[i].countAttendedUse) + '" data-limit3="' + (response.list[i].countStudio - response.list[i].countStudioUse) + '" data-limit4="' + (response.list[i].countWorkcenter - response.list[i].countWorkcenterUse) + '">발급</button></td>';
                                } else {
                                    html += '<td><button class="btn btn-sm btn-info" type="button" data-toggle="modal" data-target="#license-input" data-licensetype="' + response.list[i].licenseType + '" data-subscribetype="' + response.list[i].subscribeType + '" data-licenseseq="' + response.list[i].seq + '" data-limit1="' + (response.list[i].countUnattended - response.list[i].countUnAttendedUse) + '" data-limit2="' + (response.list[i].countAttended - response.list[i].countAttendedUse) + '" data-limit3="' + (response.list[i].countStudio - response.list[i].countStudioUse) + '" data-limit4="' + (response.list[i].countWorkcenter - response.list[i].countWorkcenterUse) + '">발급</button></td>';
                                }
                            }else{
                                html += '<td class=""><a class="btn btn-sm btn-info tooltipa" style="color:#fff;background:#ccc;border:1px solid #ccc" title="'+errorMsg+'" alt="'+errorMsg+'" disabled>발급<span class="tooltiptext">'+errorMsg+'</span></a></td>'
                            }
                    totalUseUnAttended = totalUseUnAttended+response.list[i].countUnAttendedUse;
                    totalUseAttended = totalUseAttended+response.list[i].countAttendedUse;
                    totalUseStudio = totalUseStudio+response.list[i].countStudioUse;
                    totalUseWorkcenter = totalUseWorkcenter+response.list[i].countWorkcenterUse;
                    totalUnAttended = totalUnAttended+response.list[i].countUnattended;
                    totalAttended = totalAttended+response.list[i].countAttended;
                    totalStudio = totalStudio+response.list[i].countStudio;
                    totalWorkcenter = totalWorkcenter+response.list[i].countWorkcenter;

                    html += '</tr>';

                    // <tr>
                    //     <td colspan="11" align="center">사용자가 없습니다.</td>
                    //     </tr>

                }
                html += '<tr>\
                            <td colspan="5">합계 : </td>\
                            <td>'+$.number(totalUseUnAttended)+' / '+$.number(totalUnAttended)+'</td>\
                            <td>'+$.number(totalUseAttended)+' / '+$.number(totalAttended)+'</td>\
                            <td>'+$.number(totalUseStudio)+' / '+$.number(totalStudio)+'</td>\
                            <td>'+$.number(totalUseWorkcenter)+' / '+$.number(totalWorkcenter)+'</td>\
                            <td></td>\
                         </tr>';
                if(html == ""){
                    html += '<tr><td colspan="8" align=center>등록된 License 목록이 존재하지 않습니다.</td></tr>';
                }
                $("#licenseList").html(html);
                // $(".tooltipMsg").tooltip();
                if(refresh) {
                    if(response.total > 0) {
                        $('#paging').bootpag({
                            total: Math.ceil(response.total / parseInt($("#row").val())),
                            page: 1,
                            maxVisible: 5,
                            firstLastUse: true,
                            first: '<<',
                            last: '>>',
                            next: '>',
                            prev: '<'
                        }).on("page", function (event, num) {
                            getList(num - 1, false);

                        });
                    }
                }
            }
        });
    }

    function excelDownload(){
        $("#licenseListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("라이선스를 1개 이상 선택해야합니다.");
        } else {
            var datas = { checkSeq : chkValueArr.join("|") };
            $.ajax({
                url: "/api/licenseExeclDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                // console.log(response);
                // var licenseList = response.execlDownList;
                // var html = '';
                // for(var i=0;i<licenseList.length;i++) {
                //     html = '<tr>\
                //                 <td >계약번호</td>\
                //                 <td>라이선스종류</td>\
                //                 <td >기간</td>\
                //                 <td >Unattended 수량</td>\
                //                 <td >Attended 수량</td>\
                //                 <td >Studio 수량</td>\
                //                 <td >Workcenter 수량</td>\
                //                 <td >상태</td>\
                //             </tr>';
                //
                //
                //     $("#licenseListByExeclBody").append(html);
                // }
                var companyList = response.execlDownList;
                var html = '';
                for(var i=0;i<companyList.length;i++) {
                    var startdate = moment(companyList[i].contractStart).format("YYYY-MM-DD");
                    var enddate = moment(companyList[i].contractEnd).format("YYYY-MM-DD");
                    var today = moment(new Date()).format("YYYY-MM-DD");

                    if(enddate != "" && enddate < today){
                        var status = "종료";
                        // $("#contractStatus").val(3)
                    }else if(startdate != "" && startdate > today){
                        var status = "대기";
                        // $("#contractStatus").val(1);
                    }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
                        // $("#contractStatus").val(2);
                        var status = "사용";
                    }else{
                        // $("#contractStatus").val(1);
                        var status = "대기";
                    }

                    if(companyList[i].contractType == 1){
                        var contractType = "Pilot";
                    }else if(companyList[i].contractType == 2){
                        var contractType = "PoC";
                    }else{
                        var contractType = "본사업";
                    }
                    if(companyList[i].licenseType == 1){
                        var licenseType = "PC형";
                    }else if(companyList[i].licenseType == 2){
                        var licenseType = "Cloud형";
                    }else{
                        var licenseType = "On-premise형";
                    }

                    if(companyList[i].subscribeType == 1){
                        var subscribeType = "Hour";
                    }else if(companyList[i].subscribeType == 2){
                        var subscribeType = "Month";
                    }else{
                        var subscribeType = "Annual";
                    }
                    var left1 = companyList[i].countUnattended - companyList[i].countUnAttendedUse;
                    var left2 = companyList[i].countAttended - companyList[i].countAttendedUse;
                    var left3 = companyList[i].countStudio - companyList[i].countStudioUse;
                    var left4 = companyList[i].countWorkcenter - companyList[i].countWorkcenterUse;
                    var errorMsg = "사용가능";



                    if(left1 == 0 && left2 == 0 && left3 == 0 && left4 == 0){
                        licenseUse = false
                        errorMsg = "발급개수 부족"
                    }

                    if(enddate != "" && enddate < today){
                        licenseUse = false
                        errorMsg = "계약기간 만료"
                    }

                    if(companyList[i].licenseStatus == 1 ) {

                        licenseUse = false
                        errorMsg = "관리자 사용불가 처리";
                    }
                    html = '<tr><td >'+(i+1)+'</td>\
                        <td >'+companyList[i].comContract.contractNumber+'</td>\
                        <td >'+companyList[i].comContract.contractName+'</td>\
                        <td >'+moment(companyList[i].comContract.contractStart).format("YYYY-MM-DD")+'</td>\
                        <td >'+moment(companyList[i].comContract.contractEnd).format("YYYY-MM-DD")+'</td>\
                        <td >'+status+'</td>\
                        <td >'+companyList[i].comContract.contractIctName+'</td>\
                        <td >'+contractType+'</td>\
                        <td >'+licenseType+'</td>\
                        <td >'+subscribeType+'</td>\
                        <td >'+companyList[i].unattendedLicensePrice+'</td>\
                        <td >'+companyList[i].unattendedLicenseListPrice+'</td>\
                        <td >'+companyList[i].countUnattended+'</td>\
                        <td >'+companyList[i].attendedLicensePrice+'</td>\
                        <td >'+companyList[i].attendedLicenseListPrice+'</td>\
                        <td >'+companyList[i].countAttended+'</td>\
                        <td >'+companyList[i].studioLicensePrice+'</td>\
                        <td >'+companyList[i].studioLicenseListPrice+'</td>\
                        <td >'+companyList[i].countStudio+'</td>\
                        <td >'+companyList[i].workcenterLicensePrice+'</td>\
                        <td >'+companyList[i].workcenterLicenseListPrice+'</td>\
                        <td >'+companyList[i].countWorkcenter+'</td>\
                        <td>'+errorMsg+'</td>\
                        <td >'+moment(companyList[i].comContract.createDatetime).format("YYYY-MM-DD")+'</td></tr>';

                    $("#licenseListByExeclBody").append(html);
                }

                var filename = "licenseList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('licenseListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }

    function checkLimit(limit){
        // unattended
        if(limit == "1"){

            if(parseInt($("#limit1").val()) < parseInt($("#countUnattended").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit1").val()+"개 신청 가능합니다.");
                $("#countUnattended").val($("#limit1").val());
            }
        }

        if(limit == "2"){

            if(parseInt($("#limit2").val()) < parseInt($("#countAttended").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit2").val()+"개 신청 가능합니다.");
                $("#countAttended").val($("#limit2").val());
            }
        }
        if(limit == "3"){

            if(parseInt($("#limit3").val()) < parseInt($("#countDeveloper").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit3").val()+"개 신청 가능합니다.");
                $("#countDeveloper").val($("#limit3").val());
            }
        }

        if(limit == "4"){
            console.log($("#limit4").val()+"::"+$("#countWorkcenter").val());
            if(parseInt($("#limit4").val()) < parseInt($("#countWorkcenter").val())){
                alert("신청 가능한 개수를 초과 하였습니다. 최대 "+$("#limit4").val()+"개 신청 가능합니다.");
                $("#countWorkcenter").val($("#limit4").val());
            }
        }
    }

    function getLicenseList(seq,licenseType,page,useyn){
        console.log(useyn);
        $.ajax({
            url: "/mypage/license_detail",
            type: 'GET',
            dataType: 'JSON',
            data: "seq="+seq+"&page="+page,
            success: function (response) {
                console.log(response);
                var html = "";
                if(response.list.length > 0){
                    if(licenseType == 1){
                        html += '<thead>\
                                <tr>\
                                    <td>등록일</td>\
                                    <td>라이선스이름</td>\
                                    <td>MacAddress</td>\
                                    <td style="width:155px;">Action</td>\
                                </tr>\
                                </thead>';
                        for(var i =0;i<response.list.length;i++){
                            html += '<tbody>\
                                           <tr>\
                                            <td>'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                                            <td><div class="word-ba" title="'+response.list[i].licenseName+'">'+response.list[i].licenseName+'</div></td>\
                                            <td>'+response.list[i].macAddress+'</td>\
                                            <td><button class="btn btn-info btn-sm reDownload" type="button" data-seq="'+response.list[i].seq+'" '+(useyn == false ? "disabled style=\"color:#fff;background:#ccc;border:1px solid #ccc\"":"")+' >다운로드</button> <button class="btn btn-info btn-sm reEmailsend" type="button" data-seq="'+response.list[i].seq+'" '+(useyn == false ? "disabled style=\"color:#fff;background:#ccc;border:1px solid #ccc\"":"")+' >메일발송</button></td>\
                                            </tr>\
                                         </tbody>';
                        }
                    }else{
                        html += '<thead>\
                                <tr>\
                                    <td>등록일</td>\
                                    <td>라이선스이름</td>\
                                    <td>UnAttended</td>\
                                    <td>Attended</td>\
                                    <td>Studio</td>\
                                    <td>WorkCenter</td>\
                                    <td style="width:255px;">Action</td>\
                                </tr>\
                                </thead>';
                        for(var i =0;i<response.list.length;i++){
                            html += '<tbody>\
                                           <tr>\
                                            <td>'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                                            <td><div class="word-ba" title="'+response.list[i].licenseName+'">'+response.list[i].licenseName+'</div></td>\
                                            <td>'+(response.list[i].countUnattended === null ? 0:response.list[i].countUnattended)+'</td>\
                                            <td>'+(response.list[i].countAttended === null ? 0:response.list[i].countAttended)+'</td>\
                                            <td>'+(response.list[i].countDeveloper == null ? 0:response.list[i].countDeveloper)+'</td>\
                                            <td>'+(response.list[i].countWorkcenter === null ? 0:response.list[i].countWorkcenter)+'</td>\
                                            <td><button class="btn btn-info btn-sm reDownload" type="button" data-seq="'+response.list[i].seq+'" '+(useyn == false ? "disabled style=\"color:#fff;background:#ccc;border:1px solid #ccc\"":"")+' >다운로드</button> <button class="btn btn-info btn-sm reDownloadOld" type="button" data-seq="'+response.list[i].seq+'" '+(useyn == false ? "disabled style=\"color:#fff;background:#ccc;border:1px solid #ccc\"":"")+' >V1.0.1 다운로드</button> <button class="btn btn-info btn-sm reEmailsend" type="button" data-seq="'+response.list[i].seq+'" '+(useyn == false ? "disabled style=\"color:#fff;background:#ccc;border:1px solid #ccc\"":"")+' >메일발송</button></td>\
                                            </tr>\
                                         </tbody>';
                        }
                    }
                    $("#tableInfo").html(html);
                    $('#pagingModal').bootpag({
                        total: Math.ceil(response.total / 5),
                        page: (page+1),
                        maxVisible: 5,
                        firstLastUse: true,
                        first: '<<',
                        last: '>>',
                        next: '>',
                        prev: '<'
                    }).on("page", function (event, num) {
                        getLicenseList(seq,licenseType,num - 1,useyn);

                    });
                }else{
                    $('#pagingModal').html("");
                    if(licenseType == 1) {
                        html += '<thead>\
                                <tr>\
                                    <td>등록일</td>\
                                    <td>라이선스이름</td>\
                                    <td>MacAddress</td>\
                                    <td>Action</td>\
                                </tr>\
                                </thead>';
                    }else{
                        html += '<thead>\
                                <tr>\
                                    <td>등록일</td>\
                                    <td>라이선스이름</td>\
                                    <td>UnAttended</td>\
                                    <td>Attended</td>\
                                    <td>Studio</td>\
                                    <td>Action</td>\
                                </tr>\
                                </thead>';
                    }
                    html += "<tbody><tr><td colspan=6 align=center>사용처리된 라이선스가 없습니다.</td></tr></tbody>";
                    $("#tableInfo").html(html);
                }
            }
        });
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">