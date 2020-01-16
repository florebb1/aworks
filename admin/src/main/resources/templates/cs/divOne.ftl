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
                                    <li class="breadcrumb-item"><a href="#">CS 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">1:1 문의 분류관리</li>
                                </ol>
                            </nav>
                        </div>
                        <#--<div class="col d-flex align-items-center justify-content-end">-->
                            <#--<p>전체 글 <span id="totalCnt">${total}</span>개</p>-->
                        <#--</div>-->
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-backdrop="static" data-target="#divOneModal" data-modify="0">분류 등록</button>
                        </div>
                    </div>
                </div>

                <hr>

                <form id="listForm">
                    <table class="table">
                        <colgroup>
                            <col width="70px">
                            <col width="">
                            <col width="200px">
                            <col width="210px">
                            <col width="210px">
                            <col width="210px">
                            <col width="200px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>No</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.seq" data-orderby="1">-->
                                    <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>분류명</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.title" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>담당자명</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="userName" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>담당자부서</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.create_datetime" data-orderby="0">-->
                                        <#--<i class="icon-caret-down "></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>담당자직함</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.create_datetime" data-orderby="0">-->
                                        <#--<i class="icon-caret-down "></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <div class="d-flex">
                                    <span>담당자 이메일</span>
                                    <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="bo.answer_content" data-orderby="1">-->
                                        <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                    <#--</button>-->
                                </div>
                            </th>
                            <th scope="col">
                                <span>Action</span>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="bugList">

                        <#if list?size gt 0>
                            <#list list as row>
                        <tr >
                            <td >${row?index+1}</td>
                            <td >${row.divName}</td>
                            <td >${row.chargerName!''}</td>
                            <td >${row.chargerPart!''}</td>
                            <td >${row.chargerPosition!''}</td>
                            <td >${row.chargerEmail!''}</td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#divOneModal" data-modify="1" data-seq="${row.seq}" data-divname="${row.divName}" data-chargername="${row.chargerName!''}" data-chargerpart="${row.chargerPart!''}" data-chargerposition="${row.chargerPosition!''}" data-chargeremail="${row.chargerEmail!''}" title="수정">
                                <i class="icon-modify"></i>
                                </button>
                                <#--<button type="button" class="btn btn-danger btn-sm bugDelete" data-seq="${row.seq}" data-toggle="tooltip" data-placement="top" title="삭제">-->
                                <#--<i class="icon-delete"></i>-->
                                <#--</button>-->
                            </td>
                        </tr>
                        </#list>
                        <#else>
                        <tr>
                            <td colspan="7" align="center">분류 내역이 없습니다.</td>
                        </tr>
                        </#if>
                        </tbody>
                    </table>
                </form>

                <nav id="paging" class="d-flex justify-content-center">

                </nav>

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="divOneModal" tabindex="-1" role="dialog" aria-labelledby="divOneModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="divOneModalTitle">분류 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="icon-cancel"></i></span>
                </button>
            </div>

            <div class="modal-body pa-0">
                <form id="writeForm" action="/cs/onetooneSave" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="seq" id="seq">
                    <div id="contentMain" class="input-display p-5">

                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">분류명</div>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control input-form" name="divName" id="divName" placeholder=""
                                       value="">
                            </div>
                        </div>

                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">담당자명</div>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control input-form" name="chargerName" id="chargerName" placeholder=""
                                       value="">
                            </div>
                        </div>

                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">담당자 부서</div>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control input-form" name="chargerPart" id="chargerPart" placeholder=""
                                       value="">
                            </div>
                        </div>

                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">담당자 직책</div>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control input-form" name="chargerPosition" id="chargerPosition" placeholder=""
                                       value="">
                            </div>
                        </div>
                        <div class="form-row mb-3">
                            <div class="col-12">
                                <div class="mb-3">담당자 이메일</div>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control input-form" name="chargerEmail" id="chargerEmail" placeholder=""
                                       value="">
                            </div>
                        </div>


                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-center align-items-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
                <button type="button" class="btn btn-primary btn-save">등록</button>
            </div>
        </div>
    </div>
</div>

<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script type="text/javascript">
    $(function(){
        $("#divOneModal").on("show.bs.modal", function(event){
            var button = $(event.relatedTarget)
            if(button.data("modify") == "0") {
                $("#divOneModalTitle").html("분류 등록");
                $(".btn-save").text("등록");
                $("#seq").val("");
                $("#divName").val("");
                $("#chargerName").val("");
                $("#chargerPart").val("");
                $("#chargerPosition").val("");
                $("#chargerEmail").val("");
            }else{
                $("#divOneModalTitle").html("분류 수정");
                $(".btn-save").text("수정");
                $("#seq").val(button.data("seq"));
                $("#divName").val(button.data("divname"));
                $("#chargerName").val(button.data("chargername"));
                $("#chargerPart").val(button.data("chargerpart"));
                $("#chargerPosition").val(button.data("chargerposition"));
                $("#chargerEmail").val(button.data("chargeremail"));
            }

        })
        $(".btn-save").click(function(){
            if($("#divName").val() == ""){
                alert("분류명을 입력하세요");
                return false;
            }
            if($("#seq").val() == "") { //등록
                var confirmMsg = "분류를 등록 하시겠습니까?";
                var alertMsg = "등록 되었습니다.";
            }else{ //수정
                var confirmMsg = "분류를 수정 하시겠습니까?";
                var alertMsg = "수정 되었습니다.";
            }
            if(confirm(confirmMsg)){
                $.ajax({
                    url: "/cs/div_save",
                    type: 'POST',
                    dataType: 'JSON',
                    data: $("#writeForm").serialize(),
                    success: function (response) {
                        if(response.result){
                            alert(alertMsg);
                            document.location.reload();
                            // $("#file_del_"+seq).remove();
                            // location.reload();
                        }else{
                            alert("서버오류!\n지속될 경우 사이트 관리자에게 문의하세요.");
                        }
                    }
                });
            }

        })
    });
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">