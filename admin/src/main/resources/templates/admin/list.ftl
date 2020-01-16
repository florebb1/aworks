<#include "/layout/base.ftl">
<!-- Main content -->
<div class="page-content">
    <div class="content-wrapper">
        <!-- Page header -->

        <!-- Content area -->
        <div class="content">
            <!-- Page header content -->
            <div class="header-elements-md-inline">
                <div class="page-title d-flex">
                    <h4>관리자 관리 <small class="font-size-base opacity-50">관리자 ID를 등록 및 관리할 수 있습니다.</small></h4>
                </div>
            </div>
            <!-- /page header content -->
            <div class="card">
                <div class="card-body">
                    <ul class="nav nav-tabs nav-tabs-bottom">
                        <li class="nav-item"><a href="#bottom-tab1" class="nav-link active" data-toggle="tab"><h5 class="card-title">관리자 목록</h5></a></li>
                        <li class="nav-item"><a href="#bottom-tab2" class="nav-link" data-toggle="tab"><h5 class="card-title">관리자 등록</h5></a></li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="bottom-tab1">
                            <div class="table-responsive">
                                <table class="table datatable-basic table-hover">
                                    <thead>
                                    <tr>
                                        <th class="tableCheckBox"><input id="all_check_btn" type="checkbox"></th>
                                        <th>아이디</th>
                                        <th>부서</th>
                                        <th>담당자</th>
                                        <th>전화번호</th>
                                        <th>이메일</th>
                                        <th>권한설정</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#if results?size gt 0>
                                    <#list results as row>
                                    <tr>
                                        <td><input type="checkbox" name="tableCheckbox" class="tableCheckbox setCheck" value="8"></td>
                                        <td class="">${row.loginId}</td>
                                        <td class="">${row.team!}</td>
                                        <td class="">${row.name!}</td>
                                        <td class="">${row.phone!}</td>
                                        <td class="">${row.email!}</td>
                                        <td class=""><span class="badge badge-light">파트너 관리</span> <span class="badge badge-light">월렛회원 관리</span> <span class="badge badge-light">거래내역 관리</span></td>
                                    </tr>
                                    </#list>
                                    <#else>
                                    <tr>
                                        <td colspan="7" align="center">관리자가 없습니다.</td>
                                    </tr>
                                    </#if>
                                    </tbody>
                                </table>
                                <div class="d-flex justify-content-center align-items-center pt-2">
                                    <button type="delete" class="btn btn-primary-line px-3" id="reset">삭제 <i class="mi-delete ml-1"></i></button>
                                    <button type="modify" class="btn btn-primary ml-3 px-3" data-toggle="modal" data-target="#modal_form_vertical">수정 <i class="icon-pencil5 ml-1"></i></button>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="bottom-tab2">
                            <form name="addForm" id="addForm" method="post" action="/admin/save">
                            <input type="hidden" name="isSystem" value="0">
                            <fieldset class="mb-3">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="col-form-label col-lg-12">아이디 <span class="text-primary-blue">*</span></label>
                                            <div class="col-lg-12">
                                                <input type="text" class="form-control" name="loginId" id="loginId"  placeholder="아이디" tabindex="1">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-form-label col-lg-12">담당자 <span class="text-primary-blue">*</span></label>
                                            <div class="col-lg-12">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <select name="team" id="team" class="form-control" tabindex="4">
                                                            <option value="">담당자를 선택해주세요</option>
                                                            <option value="영업팀">영업팀</option>
                                                            <option value="기술지원팀">기술지원팀</option>
                                                            <option value="경영지원팀">경영지원팀</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <input type="text" class="form-control" name="name" id="name" placeholder="담당자명" tabindex="5">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label class="col-form-label col-lg-12">비밀번호 <span class="text-primary-blue">*</span></label>
                                            <div class="col-lg-12">
                                                <input type="password" name="pw" id="pw" class="form-control" data-popup="tooltip" placeholder="비밀번호" tabindex="2">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-form-label col-lg-12">전화번호 <span class="text-primary-blue">*</span></label>
                                            <div class="col-lg-12">
                                                <input type="tel" name="phone" id="phone" class="form-control" data-popup="tooltip" placeholder="전화번호" tabindex="6">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group col-lg-4">
                                        <div class="form-group">
                                            <label class="col-form-label col-lg-12">비밀번호 확인 <span class="text-primary-blue">*</span></label>
                                            <div class="col-lg-12">
                                                <input type="password" name="re_pw" id="re_pw" class="form-control" data-popup="tooltip" placeholder="비밀번호 확인" tabindex="3">
                                            </div>
                                        </div>
                                        <div clasㅋ="form-group">
                                            <label class="col-form-label col-lg-12">이메일 <span class="text-primary-blue">*</span></label>
                                            <div class="col-lg-12">
                                                <div class="row">
                                                    <div class="col-md-9">
                                                        <input type="text" name="email" id="email" class="form-control" data-popup="tooltip" placeholder="이메일" tabindex="7">
                                                    </div>
                                                    <#--<div class="col-md-1 d-flex align-items-center">-->
                                                        <#--<i class="icon-mention"></i>-->
                                                    <#--</div>-->
                                                    <#--<div class="col-md-5">-->
                                                        <#--<select class="form-control select" name="email2" id="email2">-->
                                                            <#--<optgroup label="선택하세요.">-->
                                                                <#--<option>naver.com</option>-->
                                                                <#--<option>daum.net</option>-->
                                                                <#--<option>gamil.com</option>-->
                                                                <#--<option>직접입력</option>-->
                                                            <#--</optgroup>-->
                                                        <#--</select>-->
                                                    <#--</div>-->
                                                    <div class="col-md-3">
                                                        <button type="button" class="btn btn-light w-100">중복확인</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="col-form-label col-lg-12">권한설정</label>
                                            <div class="btn-group btn-group-toggle col-lg-12" data-toggle="buttons">
                                                <ul class="nav nav-pills nav-pills-bordered">
                                                    <li class="nav-item"><a href="#bordered-pill1" class="nav-link active" data-toggle="tab">전체</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">파트너 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">월렛회원 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">거래내역 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">정산관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">기술매뉴얼 및 다운로드</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">계약서 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">공지사항 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">FAQ 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">1:1문의 관리</a></li>
                                                    <li class="nav-item"><a href="#bordered-pill2" class="nav-link" data-toggle="tab">파트너 매뉴얼 관리</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <div class="d-flex justify-content-center align-items-center pt-2">
                                <button type="button" class="btn btn-primary ml-3 px-3 btn-register">등록 <i class="icon-plus3 ml-1"></i></button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content area -->
    </div>
</div>
<#include "/layout/footer.ftl">
<#include "/layout/base_script.ftl">
<script type="text/javascript" src="/assets/js/plugins/forms/styling/uniform.min.js"></script>
<script src="/assets/js/plugins/ui/fullcalendar/fullcalendar.min.js"></script>
<script src="/assets/js/charts/echarts/echarts.min.js"></script>
<script src="/assets/js/listCommon.js"></script>
<script src="/assets/js/page/admin/list.js"></script>
</body>

</html>
