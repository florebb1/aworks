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
                    <h4>관리자 관리 <small class="font-size-base opacity-50">추가관리자 ID를 등록 및 관리할 수 있습니다. 관리자는 추가관리자의 권한을 설정할 수 있습니다.</small></h4>
                </div>
            </div>
            <!-- /page header content -->
            <div class="card">

                <div class="card-header header-elements-inline">
                    <h5 class="card-title">관리자 정보</h5>
                    <div class="header-elements">
                        <div class="list-icons">
                            <a class="list-icons-item" data-action="collapse"></a>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <fieldset class="mb-3">
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">아이디 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <input type="text" class="form-control" data-popup="tooltip" data-trigger="focus" placeholder="아이디" maxlength="50">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">관리자명 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <input type="text" class="form-control" data-popup="tooltip" placeholder="관리자명" maxlength="50">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">이메일 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <input type="text" class="form-control" data-popup="tooltip" placeholder="이메일" maxlength="50">
                                            </div>
                                            <div class="col-md-1 d-flex align-items-center">
                                                <i class="icon-mention"></i>
                                            </div>
                                            <div class="col-md-5">
                                                <select class="form-control select" data-fouc>
                                                    <optgroup label="선택하세요.">
                                                        <option>naver.com</option>
                                                        <option>daum.net</option>
                                                        <option>gamil.com</option>
                                                        <option>직접입력</option>
                                                    </optgroup>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <button type="button" class="btn btn-light w-100">중복확인</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">홈페이지</label>
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <select class="form-control select" data-fouc>
                                                    <optgroup label="선택하세요.">
                                                        <option>http://</option>
                                                        <option>https://</option>
                                                    </optgroup>
                                                </select>
                                            </div>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" data-popup="tooltip" placeholder="홈페이지">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">비밀번호 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <input type="text" class="form-control" data-popup="tooltip" placeholder="비밀번호">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">전화번호 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <input type="tel" class="form-control" data-popup="tooltip" placeholder="전화번호">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">주소 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" data-popup="tooltip" placeholder="주소">
                                            </div>
                                            <div class="col-md-3">
                                                <button type="button" class="btn btn-light w-100">주소검색</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group col-lg-4">
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">비밀번호 확인 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <input type="text" class="form-control" data-popup="tooltip" placeholder="비밀번호 확인">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">팩스</label>
                                    <div class="col-lg-12">
                                        <input type="tel" class="form-control" data-popup="tooltip" placeholder="팩스">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label col-lg-12">사업등록번호 <span class="text-primary-blue">*</span></label>
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" data-popup="tooltip">
                                            </div>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" data-popup="tooltip">
                                            </div>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" data-popup="tooltip">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                    <div class="d-flex justify-content-center align-items-center pt-2">
                        <button type="button" class="modify px-3">취소 <i class="icon-reload-alt ml-1"></i></button>
                        <button type="modify" class="btn btn-primary ml-3 px-3">수정 <i class="icon-pencil5 ml-1"></i></button>
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
</body>

</html>
