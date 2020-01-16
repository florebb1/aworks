<!-- Login Modal -->
<div class="modal fade" id="login-md" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content border-radius-none">
            <div class="modal-body"  style="height:482px;">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h2 class="pt-5 pb-4 text-center">로그인</h2>
                <form id="loginFrm" class="pl-3 pr-3 pb-5">
                    <div class="form-group">
                        <label for="loginId">이메일</label>
                        <input type="text" class="form-control border-radius-none" id="loginId" name="loginId" aria-describedby="emailHelp" placeholder="이메일 주소를 입력해 주세요.">
                        <small id="loginEmailHelp" class="form-text text-danger minh-18"></small>
                    </div>
                    <div class="form-group">
                        <label for="loginPw">비밀번호</label>
                        <input type="password" class="form-control border-radius-none" id="loginPw" name="loginPw" aria-describedby="passwordHelp" placeholder="비밀번호를 입력해 주세요.">
                        <small id="loginPasswordHelp" class="form-text text-danger minh-18"></small>
                    </div>

                    <div class="row">
                        <div class="col">
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="loginSave">
                                <label class="form-check-label" for="loginSave">이메일 저장</label>
                            </div>
                        </div>
                        <div class="col text-right">
                            <a href="#" data-dismiss="modal" data-toggle="modal" data-backdrop="static" data-target="#find-pw-md">비밀번호찾기</a>
                        </div>
                    </div>

                    <button type="button" id="loginBtn" class="btn btn-info btn-block border-radius-none" >로그인</button>
                    <div class="text-center pt-3">
                        아직 회원이 아니신가요? <a href="#" data-dismiss="modal" data-backdrop="static" data-toggle="modal" data-target="#join-md">회원가입</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Join Modal -->
<div class="modal fade" id="join-md" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered" role="document">
        <div class="modal-content border-radius-none">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">회원가입</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form id="signFrm" class="pl-3 pr-3 pt-4 pb-4" autocomplete="new-password">
                    <div style="position: absolute;left:-9999px; display:none;">
                        <input type="text" id="tricId" name="tricId" placeholder="입력하세요.">
                        <input type="password" id="tricPwd" name="tricPwd" placeholder="입력하세요.">
                    </div>

                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">이메일</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="signId" name="signId" placeholder="이메일 주소를 입력해 주세요." autocomplete="off" maxlength="30">
                            <input type="hidden" id="signId2" name="signId2">
                            <small id="signEmailHelp" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col">
                            <button type="button" id="signIdChk" class="btn btn-info border-radius-none">중복확인</button>
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">비밀번호</span>
                        </div>
                        <div class="col-7">
                            <input type="password" class="form-control border-radius-none" id="signPw" name="signPw" aria-describedby="passwordHelp" placeholder="비밀번호를 입력해 주세요." autocomplete="new-password">
                            <small id="signPasswordHelp" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col d-flex justify-content-start align-items-start">
<#--                            <i class="icon-description mt-2-5"></i>-->
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">비밀번호확인</span>
                        </div>
                        <div class="col-7">
                            <input type="password" class="form-control border-radius-none" id="signPw2" name="signPw2" aria-describedby="passwordHelp" placeholder="비밀번호를 다시 입력해 주세요." autocomplete="new-password">
                            <small id="signPasswordHelp2" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col d-flex justify-content-start align-items-start">
<#--                            <i class="icon-description mt-2-5"></i>-->
                        </div>
                    </div>
                    <div class="form-row pb-4">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">이름</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="name" name="name" placeholder="이름을 입력해 주세요." autocomplete="off" maxlength="10">
                            <small id="signNameHelp" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col d-flex justify-content-start align-items-start">
                            <#--                            <i class="icon-description mt-2-5"></i>-->
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col d-flex justify-content-start align-items-start">
                            <span class="pl-2 pt-2">연락처</span>
                        </div>
                        <div class="col-7">
                            <input type="text" class="form-control border-radius-none" id="phone" name="phone" placeholder="연락처를 입력해 주세요." autocomplete="off" oninput="fn_maxLengthCheck(this)" onkeypress="return onlyNumInput(event);" onkeyup="fn_press_han(this)">
                            <small id="signPhoneHelp" class="form-text text-danger minh-18 input-small-plus"></small>
                        </div>
                        <div class="col d-flex justify-content-start align-items-start">
                            <#--                            <i class="icon-description mt-2-5"></i>-->
                        </div>
                    </div>
                </form>
                <hr class="mt-0 mb-4">
                <div class="privacy-text text-center pt-2 mb-3">
                    <input type="checkbox" id="agree"> A.WORKS의 <a href="/terms" target="_blank">이용약관</a>, <a href="/privacy" target="_blank">개인정보처리방침</a>에 모두 동의합니다.
                </div>

            </div>
            <div class="modal-footer justify-content-center align-items-center">
                <button type="button" class="btn btn btn-secondary border-radius-none" data-dismiss="modal">취소</button>
                <button type="button" id="signBtn" class="btn btn-info border-radius-none">회원가입</button>
            </div>
        </div>
    </div>
</div>

<!-- Find PW Modal -->
<div class="modal fade" id="find-pw-md" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content border-radius-none">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h2 class="p-5 text-center">비밀번호 찾기</h2>
                <form id="findPwFrm" class="pl-3 pr-3 pb-5">
                    <div class="form-group">
                        <label for="findPwEmail">이메일</label>
                        <input type="email" class="form-control border-radius-none" id="findPwEmail" name="findPwEmail" aria-describedby="emailHelp" placeholder="이메일 주소를 입력해 주세요.">
                        <small id="findPwEmailHelp" class="form-text text-danger minh-18"></small>
                    </div>
                    <button type="button" id="findPwBtn" class="btn btn-info btn-block border-radius-none mt-5">임시 비밀번호 발송</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Change PW Modal -->
<div class="modal fade" id="change-pw-md" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered" role="document">
        <div class="modal-content border-radius-none">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">비밀번호 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form id="changePwForm" class="pl-3 pr-3 pt-4 pb-4">

                    <div class="row pb-3">
                        <div class="col-3 d-flex justify-content-end align-items-center">
                            <span class="pl-2 pb-4">기존 비밀번호</span>
                        </div>
                        <div class="col-9">
                            <input type="hidden" id="changePwId" name="changePwId">
                            <input type="password" class="form-control border-radius-none" id="originPw" name="originPw" aria-describedby="passwordHelp" placeholder="기존 비밀번호를 입력해 주세요.">
                            <small id="originPasswordHelp" class="form-text text-danger minh-18"></small>
                        </div>
                    </div>
                    <div class="row pb-3">
                        <div class="col-3 d-flex justify-content-end align-items-center">
                            <span class="pl-2 pb-4">새로운 비밀번호</span>
                        </div>
                        <div class="col-9">
                            <input type="password" class="form-control border-radius-none" id="newPw" name="newPw" aria-describedby="passwordHelp" placeholder="비밀번호를 입력해 주세요.">
                            <small id="newPasswordHelp" class="form-text text-danger minh-18"></small>
                        </div>
                    </div>
                    <div class="row pb-3">
                        <div class="col-3 d-flex justify-content-end align-items-center">
                            <span class="pl-2 pb-4">비밀번호확인</span>
                        </div>
                        <div class="col-9">
                            <input type="password" class="form-control border-radius-none" id="newPw2" name="newPw2" aria-describedby="passwordHelp" placeholder="비밀번호를 다시 입력해 주세요.">
                            <small id="newPasswordHelp2" class="form-text text-danger minh-18"></small>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer justify-content-center align-items-center">
                <button type="button" id="changeCancel" class="btn btn btn-secondary border-radius-none" data-dismiss="modal">취소</button>
                <button type="button" id="changPwBtn" class="btn btn-info border-radius-none">변경완료</button>
            </div>
        </div>
    </div>
</div>
