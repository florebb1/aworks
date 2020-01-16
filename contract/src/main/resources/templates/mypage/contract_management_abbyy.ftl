<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<#import "../pagination.ftl" as pagination />

<style>
body {
  position: relative;
}
</style>

<div class="sub-title-bg background-base-code background-h4">
    계약관리
</div>

<#--  <section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1>계약관리</h1>
    <div>나의 계약사항을 확인할 수 있습니다.</div>
</section>  -->

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>ABBYY관리</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>계약관리<i class="icon-cheveron-right"></i>ABBYY관리</h5>
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
                <a href="/mypage/contract_management_abbyy" class="cs-menu active">ABBYY관리</a>
                <#--<a href="/mypage/contract_management_download" class="cs-menu">다운로드</a>-->
            </div>
            <div class="col-12">
                <div class="card minh-640 mt-4">

                    <div class="row justify-content-center">



                        <div class="col-10 mt-5 mb-5">

                            <form id="searchForm">
                                <input type="hidden" id="row" name="row" value="${row}">
                                <div class="form-row mb-3">
                                    <div class="col-4">
                                        <div class="form-row">
                                            <div class="col">
                                                <input type="text" id="datestart" name="startDate" class="form-control" placeholder="시작일 선택" value="${RequestParameters.startDate!}" autocomplete="off" readonly>
                                            </div>
                                            <div class="col-auto">~</div>
                                            <div class="col">
                                                <input type="text" id="dateend" name="endDate" class="form-control" placeholder="종료일 선택" value="${RequestParameters.endDate!}" autocomplete="off" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <select class="custom-select">
                                            <option value="" <#if !searchType??>selected</#if>>통합</option>
                                            <option value="comName" <#if searchType?? && searchType="comName">selected</#if>>회사명</option>
                                        </select>
                                    </div>

                                    <div class="col-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search">
                                            <div class="input-group-append">
                                                <button class="btn btn-info d-flex align-items-center" type="submit" id="button-search">
                                                    <i class="icon-magnifying-glass"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <#--  <div class="col-2">
                                        <button class="btn btn-light btn-block" data-toggle="modal" data-target="#exampleModal">사용자 등록</button>
                                        <a href="#" class="btn btn-info btn-block" data-toggle="modal" data-target="#abbyy-input">신 청</a>
                                    </div>  -->
                                </div>
                            </form>

                            <hr>

                            <form>
                                <div class="form-row mb-3">
                                    <div class="col d-flex justify-content-start">
                                        <button type="button" class="btn btn-secondary ml-1" onclick="excelDownload()">선택 엑셀 다운로드</button>
                                    </div>
                                    <div class="col d-flex justify-content-end">
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <button id="row10" type="button" class="btn btn-info btn-row">10개</button>
                                            <button id="row20" type="button" class="btn btn-outline-secondary btn-row">20개</button>
                                            <button id="row30" type="button" class="btn btn-outline-secondary btn-row">30개</button>
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
                                            <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">
                                        </div>
                                    </th>
                                    <th scope="col">No</th>
                                    <#--<th scope="col">등록일</th>-->
                                    <th scope="col">시작일</th>
                                    <th scope="col">종료일</th>
                                    <th scope="col">라이선스키</th>
                                </tr>
                                </thead>
                                <tbody id="abbyyList">
                                <#--<#if results?size gt 0>-->
                                    <#--<#list results as row>-->
                                        <#--<tr>-->
                                            <#--<th scope="row">-->
                                                <#--<div class="form-check">-->
                                                    <#--<input class="listCheck form-check-input position-static" type="checkbox" value="${row.seq!}" aria-label="...">-->
                                                <#--</div>-->
                                            <#--</th>-->
                                            <#--<a href="/mypage/contract_management_abbyyView?abbyySeq=${row.seq}">-->
                                                <#--<th>${row.seq!}</th>-->
                                                <#--<td>${row.comName}</td>-->
                                                <#--<td>${row.createDatetime?string["yyyy-MM-dd"]}</td>-->
                                                <#--<td>${row.startDate?string["yyyy-MM-dd"]}</td>-->
                                                <#--<td>${row.endDate?string["yyyy-MM-dd"]}</td>-->
                                            <#--</a>-->
                                        <#--</tr>-->
                                    <#--</#list>-->
                                <#--<#else>-->
                                    <#--<tr>-->
                                        <#--<th colspan="6" class="text-center">등록된 ABBYY 목록이 존재하지 않습니다.</th>-->
                                    <#--</tr>-->
                                <#--</#if>-->

                                </tbody>
                            </table>

                            <nav id="paging" class="d-flex justify-content-center">

                            </nav>

                        </div>



                    </div>

                </div>
            </div>
        </div>
        <!-- 계약회원일경우 끝 -->

    </div>
    <table id="abbyyListByExeclTable" style="display:none;">
        <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">시작일</th>
            <th scope="col">종료일</th>
            <th scope="col">라이선스키</th>
        </tr>
        </thead>
        <tbody id="abbyyListByExeclBody"></tbody>
    </table>
</section>
<div class="modal fade" id="abbyyDetail" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">Abbyy 상세</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">


                <#--<div class="form-row pb-4">-->
                    <#--<div class="col d-flex justify-content-start align-items-center">-->
                        <#--<div class="pl-2 pb-3 text-right">등록일</div>-->
                    <#--</div>-->
                    <#--<div class="col-6" id="abbyyCreate">-->

                    <#--</div>-->
                    <#--<div class="col">-->

                    <#--</div>-->
                <#--</div>-->
                <div class="form-row pb-4">
                    <div class="col d-flex justify-content-start align-items-center">
                        <div class="pl-2 pb-3 text-right">시작일</div>
                    </div>
                    <div class="col-6" id="abbyyStart">

                    </div>
                    <div class="col">

                    </div>
                </div>
                <div class="form-row pb-4">
                    <div class="col d-flex justify-content-start align-items-center">
                        <div class="pl-2 pb-3 text-right">종료일</div>
                    </div>
                    <div class="col-6" id="abbyyEnd">

                    </div>
                    <div class="col">

                    </div>
                </div>
                <div class="form-row pb-4">
                    <div class="col d-flex justify-content-start align-items-center">
                        <div class="pl-2 pb-3 text-right">라이선스키</div>
                    </div>
                    <div class="col-6" id="abbyyLicense">

                    </div>
                    <div class="col">

                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-center align-items-center">
                <button type="button" class="btn btn btn-outline-secondary" data-dismiss="modal">닫 기</button>
            </div>
        </div>
    </div>
</div>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(function(){
        getList(0,true);
        $("#abbyyDetail").on("show.bs.modal",function(event){
            var button = $(event.relatedTarget);
            var seq = button.data("seq");
            console.log(seq);
            $.ajax({
                url: "/mypage/abbyy_detail",
                type: 'GET',
                dataType: 'JSON',
                data: "seq=" + seq,
                success: function (response) {
                    // $("#abbyyCreate").html(moment(response.result.createDatetime).format("YYYY-MM-DD"));
                    $("#abbyyStart").html(moment(response.result.startDate).format("YYYY-MM-DD"));
                    $("#abbyyEnd").html(moment(response.result.endDate).format("YYYY-MM-DD"));
                    $("#abbyyLicense").html(response.result.abbyyLicenseKey);
                }
            });
        })
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

        $(".btn-row").click(function(){
            $("#row").val($(this).data("row"));
            $(".btn-row").removeClass("btn-info").removeClass("btn-outline-secondary").addClass("btn-outline-secondary");

            $(this).removeClass("btn-outline-secondary").addClass("btn-info");
            getList(0,true);
            // $("#searchForm").submit();
        });

        $("#allCheck").click(function(){
            if($(this).is(":checked")){
                $(".listCheck").prop("checked",true);
            }else{
                $(".listCheck").prop("checked",false);
            }
        });
        $("body").on("click",".btn-checkdelete", function () {
            var deleteArray = [];
            $(".listCheck").each(function () {
                if($(this).is(":checked")) deleteArray.push($(this).val());
            });

            fnAbbyyLicenseDelete(deleteArray);
        });
    });
    function excelDownload(){
        $("#abbyyListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("ABBYY 라이선스를 1개 이상 선택해야합니다.");
        } else {
            var datas = { chkValueArr : chkValueArr.join("|") };
            $.ajax({
                url: "/api/execlDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
                var abbyyList = response.execlDownList;
                var html = '';
                for(var i=0;i<abbyyList.length;i++) {
                    var comName = abbyyList[i].comName;
                    if(comName == null || comName == "") comName = "";

                    var createDatetime = getFormatDate(abbyyList[i].createDatetime);

                    var startDate = getFormatDate(abbyyList[i].startDate);

                    var endDate = getFormatDate(abbyyList[i].endDate);

                    html =
                        '<tr>' +
                        '<td>'+abbyyList[i].seq+'</td>'+
                        '<td>'+startDate+'</td>'+
                        '<td>'+endDate+'</td>'+
                        '<td>'+abbyyList[i].abbyyLicenseKey+'</td>'+
                        '</tr>';
                    $("#abbyyListByExeclBody").append(html);
                }

                var filename = "abbyyLicenseList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('abbyyListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
    function fnAbbyyLicenseDelete(deleteArray) {
        var datas = {
            deleteArray : deleteArray.join("|")
        };

        if(confirm("선택한 ABBYY 라이센스를 삭제하시겠습니까?\n(삭제 시 조회목록에서 제외됩니다.)")) {
            $.ajax({
                url: "/mypage/abbyyDelete",
                type: 'POST',
                dataType: 'JSON',
                data: datas,
                success: function (response) {
                    if(response.result){
                        alert("삭제 되었습니다.");
                        location.reload();
                    }else{
                        alert("삭제 실패!\n지속될 경우 사이트 관리자에게 문의하세요.");
                    }
                }
            });
        }
    }
    function getFormatDate(date){
        date = new Date(date);
        var year = date.getFullYear();              //yyyy
        var month = (1 + date.getMonth());          //M
        month = month >= 10 ? month : '0' + month;  // month 두자리로 저장
        var day = date.getDate();                   //d
        day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
        return  year + '-' + month + '-' + day;
    }

    function getList(num,refresh){
        var datas = $("#searchForm").serialize()+"&page="+num;
        $.ajax({
            url: "/mypage/ajax_abbyy",
            type: 'GET',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                console.log(response);
                var html = "";

                for(var i =0 ; i< response.list.length;i++){


                    html += '<tr>\
                                <th scope="row">\
                                    <div class="form-check">\
                                        <input class="listCheck form-check-input position-static" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                    </div>\
                                </th>\
                                <th data-target="#abbyyDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'">'+response.list[i].seq+'</th>\
                                <td data-target="#abbyyDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'">'+moment(response.list[i].startDate).format("YYYY-MM-DD")+'</td>\
                                <td data-target="#abbyyDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'">'+moment(response.list[i].endDate).format("YYYY-MM-DD")+'</td>\
                                <td data-target="#abbyyDetail" data-toggle="modal" data-seq="'+response.list[i].seq+'">'+response.list[i].abbyyLicenseKey+'</td>\
                            </tr>';


                }
                if(html == ""){
                    html += '<tr><td colspan="6" align=center>등록된 ABBYY 목록이 존재하지 않습니다.</td></tr>';
                }
                $("#abbyyList").html(html);
                if(refresh) {
                    if(response.total > 0) {
                        $('#paging').bootpag({
                            total: Math.ceil(response.total / parseInt($("#row").val())),
                            page: 1,
                            maxVisible: 5
                        }).on("page", function (event, num) {
                            getList(num - 1, false);

                        });
                    }
                }
            }
        });
    }
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">