<#include "/layout/base.ftl">
<div class="content">
    <div class="container"  style="min-width:1020px;">
        <div class="row">
            <div class="col">


                <div class="breadcrumb-wrap mb-1">
                    <div class="form-row">
                        <div class="col">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="#">메인</a></li>
                                    <li class="breadcrumb-item"><a href="#">사용자 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">사용자 목록</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="col text-right">
                            <p>전체사용자 1283명</p>
                        </div>
                    </div>
                </div>

                <form>
                    <div class="form-row mb-3">
                        <div class="col-4">
                            <div class="form-row">
                                <div class="col">
                                    <input type="text" id="datestart" class="form-control" placeholder="날짜선택">
                                </div>
                                <div class="col-auto">~</div>
                                <div class="col">
                                    <input type="text" id="dateend" class="form-control" placeholder="날짜선택">
                                </div>
                            </div>
                        </div>

                        <div class="col-2">
                            <select class="custom-select">
                                <option selected>Dropdown</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </div>

                        <div class="col-3">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search">
                                <div class="input-group-append">
                                    <button class="btn btn-light d-flex align-items-center" type="button" id="button-search">
                                        <i class="icon-xs icon-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-1">

                        </div>
                        <div class="col-2">
                            <!-- <button class="btn btn-light btn-block" data-toggle="modal" data-target="#exampleModal">사용자 등록</button> -->
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#exampleModalCenter">사용자 등록</button>
                        </div>
                    </div>
                </form>

                <hr>

                <form>
                    <div class="form-row mb-3">
                        <div class="col d-flex justify-content-start">
                            <button type="button" class="btn btn-light">선택삭제</button>
                            <button type="button" class="btn btn-light ml-1">선택 엑셀 다운로드</button>
                        </div>
                        <div class="col d-flex justify-content-end">
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-primary">10개</button>
                                <button type="button" class="btn btn-light">20개</button>
                                <button type="button" class="btn btn-light">30개</button>
                            </div>
                        </div>
                    </div>
                </form>

                <table class="table">
                    <colgroup>
                        <col width="30px">
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th scope="col">No</th>
                        <th scope="col">아이디</th>
                        <th scope="col">이름</th>
                        <th scope="col">연락처</th>
                        <th scope="col">회사명</th>
                        <th scope="col">회사타입</th>
                        <th scope="col">직함</th>
                        <th scope="col">레벨</th>
                        <th scope="col">등록일</th>
                        <th scope="col">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <div class="form-check">
                                <input class="form-check-input position-static" type="checkbox" id="" value="" aria-label="...">
                            </div>
                        </th>
                        <th>{no}</th>
                        <td>(id))</td>
                        <td>{name}}</td>
                        <td>{phone}</td>
                        <td>{com_name}</td>
                        <td>{com_type}</td>
                        <td>{position}</td>
                        <td>{level}</td>
                        <td>{created_date_time}</td>
                        <td>{button}</td>
                    </tr>
                    </tbody>
                </table>

                <nav aria-label="Page navigation">
                    <ul class="pagination d-flex justify-content-center">
                        <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">Next</a></li>
                    </ul>
                </nav>

            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">사용자 등록 <span class="sub-title pl-3">사용자의 정보를 수정할 수 있습니다.</span></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>
            <div class="modal-body pa-0">

                <a href="javascript:void(0)" class="openbtn d-flex align-items-center" onclick="openNav()">
                    <span>log<br><br><i class="icon icon-arrow-left-round"></i></span>
                </a>

                <div id="contentMain" class="input-display pt-5 pb-5 pl-3 pr-3">
                    <div class="container">
                        <div class="row mb-3">
                            <div class="col-auto">
                                <div class="miw100 text-right">아이디 (이메일)</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <input type="text" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <#--  <small id="" class="form-text text-danger">* 이메일형식(예: abc123@abc123.com)에 맞춰 입력해 주세요.</small>  -->
                                        <!--  <small id="" class="form-text text-danger">* 아이디(이메일)을 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <button type="button" class="btn btn-light">이메일 인증</button>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">비밀번호</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <input type="password" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <#--  <small id="" class="form-text text-danger">* 비밀번호 규칙에 맞지 않습니다. 다시 입력해 주세요.</small>  -->
                                        <!--  <small id="" class="form-text text-danger">* 비밀번호를 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                            <div class="col d-flex align-items-center">
                                <div class="d-flex flex-row align-items-center bd-highlight text-info-padding">
                                    <div class="bd-highlight d-flex align-items-center"><i class="icon icon-info gray-color"></i>  </div>
                                    <div class="bd-highlight d-flex align-items-centers pl-2 text-information">6~20자의 영문, 숫자, 특수문자 중 2개 이상을 조합하여 입력하세요.<br>안전한 이용을 위하여 아이디와 다르게 설정하시기 바랍니다.</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">비밀번호 확인</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <input type="password" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <small id="" class="form-text text-danger">* 비밀번호가 동일하지 않습니다. 동일한 비밀번호를 입력해 주세요.</small>
                                        <!--  <small id="" class="form-text text-danger">* 비밀번호를 다시 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                            <div class="col d-flex align-items-center">
                                <div class="d-flex flex-row align-items-center bd-highlight text-info-padding">
                                    <div class="bd-highlight d-flex align-items-center"><i class="icon icon-info gray-color"></i>  </div>
                                    <div class="bd-highlight d-flex align-items-center pl-2 text-information">비밀번호 확인을 위하여 동일한 비밀번호를 다시 입력해 주세요.</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">프로필 이미지</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="validatedCustomFile" required>
                                        <label class="custom-file-label" for="validatedCustomFile">이미지 파일을 첨부해 주세요.</label>
                                        <div class="text-info-mih">
                                            <#--  <small id="" class="form-text text-danger">* 해당파일을 첨부 할 수 없습니다. 파일 형식을 확인해 주세요.</small>  -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col d-flex align-items-center">
                                <div class="d-flex flex-row align-items-center bd-highlight text-info-padding">
                                    <div class="bd-highlight d-flex align-items-center"><i class="icon icon-info gray-color"></i></div>
                                    <div class="bd-highlight d-flex align-items-center pl-2 text-information">파일은 가로200px 세로200px이하 jpg, png, gif형식의 파일을 업로드해 주세요.<br>파일 업로드 최대 사이즈는 2M입니다.</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">이 름</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <input type="test" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <#--  <small id="" class="form-text text-danger">* 특수문자는 사용 할 수 없습니다. 한글또는 영문을 입력해 주세요.</small>  -->
                                        <!--  <small id="" class="form-text text-danger">* 이름을 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                            <div class="col d-flex align-items-center">
                                <div class="d-flex flex-row align-items-center bd-highlight text-info-padding">
                                    <div class="bd-highlight d-flex align-items-center"><i class="icon icon-info gray-color"></i>  </div>
                                    <div class="bd-highlight d-flex align-items-center pl-2 text-information">Repository 및 CloudRPA에 사용할 이름을 입력해 주세요.</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">연락처</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <input type="test" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <#--  <small id="" class="form-text text-danger">* 특수문자는 사용 할 수 없습니다. 숫자또는 '+'만 허용됩니다.</small>  -->
                                        <!--  <small id="" class="form-text text-danger">* 연락처를 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                            <div class="col d-flex align-items-center">
                                <div class="d-flex flex-row align-items-center bd-highlight text-info-padding">
                                    <div class="bd-highlight d-flex align-items-center"><i class="icon icon-info gray-color"></i>  </div>
                                    <div class="bd-highlight d-flex align-items-center pl-2 text-information">연락처를 ‘-’를 제외한 나머지 번호만 입력해 주세요.<br>예) '01012345678' or '+821012345678'</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">화사명</div>
                            </div>
                            <div class="col">
                                <div class="mxw300">
                                    <input type="test" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <#--  <small id="" class="form-text text-danger">* 회사명을 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">화사타입</div>
                            </div>
                            <div class="col">
                                <select class="custom-select mxw200" id="">
                                    <option selected>회사타입을 선택해주세요.</option>
                                    <option value="1">One</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                                </select>
                                <div class="text-info-mih">
                                    <#--  <small id="" class="form-text text-danger">* 회사타입을 선택하지 않았습니다. 항목을 선택해 주세요.</small>  -->
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">레 벨</div>
                            </div>
                            <div class="col">
                                <select class="custom-select mxw200" id="">
                                    <option selected>레벨을 선택해 주세요.</option>
                                    <option value="1">Admin</option>
                                    <option value="2">User</option>
                                    <option value="3">Trial User</option>
                                </select>
                                <div class="text-info-mih">
                                    <#--  <small id="" class="form-text text-danger">* 레벨을 선택하지 않았습니다. 항목을 선택해 주세요.</small>  -->
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto text-right">
                                <div class="miw100 text-right">직 함</div>
                            </div>
                            <div class="col-auto">
                                <div class="miw300">
                                    <input type="test" class="form-control" placeholder="" required="">
                                    <div class="text-info-mih">
                                        <#--  <small id="" class="form-text text-danger">* 직함을 입력해 주세요.</small>  -->
                                    </div>
                                </div>
                            </div>
                            <div class="col d-flex align-items-center">
                                <div class="d-flex flex-row align-items-center bd-highlight text-info-padding">
                                    <div class="bd-highlight d-flex align-items-center"><i class="icon icon-info gray-color"></i>  </div>
                                    <div class="bd-highlight d-flex align-items-center pl-2 text-information">예) 사원, 과장 / 팀장, 파트장</div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

                <div id="contentCmd" class="cmd-display btn-zin">
                    <div class="cmd-display-in">
                        <div class="cmd-close-wrap">

                            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                        </div>
                        <div class="alert-display">
                            <p>오류 : 특수문자는 사용 할 수 없습니다. 1<a class="badge badge-info">수 정</a></p>
                            <#--  <p class="text-primary">
                                text-primary
                                <a class="badge badge-primary">Primary</a>
                                <a class="badge badge-secondary">Secondary</a>
                                <a class="badge badge-success">Success</a>
                                <a class="badge badge-danger">Danger</a>
                                <a class="badge badge-warning">Warning</a>
                                <a class="badge badge-info">Info</a>
                                <a class="badge badge-dark">Dark</a>
                            </p> -->
                            <p class="text-secondary">text-secondary</p>
                            <p class="text-success">text-success</p>
                            <p class="text-danger">text-danger</p>
                            <p class="text-warning">text-warning</p>
                            <p class="text-info">text-info</p>
                            <p class="text-muted">text-muted</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p class="text-primary">text-primary</p>
                            <p class="text-secondary">text-secondary<a class="badge badge-success">Success</a></p>
                            <p class="text-success">text-success</p>
                            <p class="text-danger">text-danger</p>
                            <p class="text-warning">text-warning</p>
                            <p class="text-info">text-info</p>
                            <p class="text-muted">text-muted</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p class="text-primary">text-primary</p>
                            <p class="text-secondary">text-secondary</p>
                            <p class="text-success">text-success</p>
                            <p class="text-danger">text-danger<a class="badge badge-danger">Danger</a></p>
                            <p class="text-warning">text-warning</p>
                            <p class="text-info">text-info</p>
                            <p class="text-muted">text-muted</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p class="text-primary">text-primary</p>
                            <p class="text-secondary">text-secondary</p>
                            <p class="text-success">text-success</p>
                            <p class="text-danger">text-danger</p>
                            <p class="text-warning">text-warning</p>
                            <p class="text-info">text-info</p>
                            <p class="text-muted">text-muted</p>
                            <p>basic text</p>
                            <p>basic text</p>
                            <p>basic text</p>
                        </div>
                    </div>
                </div>

            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
                <button type="button" onClick="makeProgress()" class="btn btn-primary">확 인</button>
            </div>

        </div>
    </div>
</div>


<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    function openNav() {
        document.getElementById("contentCmd").style.width = "300px";
        document.getElementById("contentMain").style.marginRight = "0";
        document.getElementById("contentCmd").classList.add('btn-zin');
    }
    function closeNav() {
        document.getElementById("contentCmd").style.width = "0";
        document.getElementById("contentMain").style.marginRight= "0";
        document.getElementById("contentCmd").classList.remove('btn-zin');
    }
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">