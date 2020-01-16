<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">
<div class="sub-title-bg background-base-code background-h4">
    계약관리
</div>

<#--  <section class="place-wrap-none page-breadcrumb">
    <div class="container">
        <div class="row">
            <div class="col d-flex justify-content-start align-items-end">
                <h4>계약정보관리</h4>
            </div>
            <div class="col d-flex justify-content-end align-items-end">
                <h5><i class="icon-home"></i>HOME<i class="icon-cheveron-right"></i>마이페이지<i class="icon-cheveron-right"></i>계약관리<i class="icon-cheveron-right"></i>계약정보관리</h5>
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
                <a href="/mypage/contract_management_info" class="cs-menu active">계약정보관리</a>
                <a href="/mypage/contract_management_license" class="cs-menu">라이선스관리</a>
                <#--  <a href="/mypage/contract_management_abbyy" class="cs-menu">ABBYY관리</a>  -->
                <a href="/mypage/contract_management_download" class="cs-menu">다운로드</a>
            </div>

                        <div class="col-12 card mt-5 p-5 minh-480">

                            <form id="searchForm">
                                <input type="hidden" id="row" name="row" value="10">
                                <input type="hidden" id="sort" name="sort" value="create_datetime">
                                <input type="hidden" id="order" name="order" value="1">
                                <div class="form-row mb-3">
                                    <div class="col-4">
                                        <div class="form-row">
                                            <div class="col">
                                                <input type="text" name="startDate" id="datestart" class="form-control" style="background:#fff" placeholder="시작일선택" readonly autocomplete="off" value="<#if RequestParameters.startDate?? >${RequestParameters.startDate}<#else></#if>">
                                            </div>
                                            <div class="col-auto">~</div>
                                            <div class="col">
                                                <input type="text" name="endDate" id="dateend" class="form-control" style="background:#fff" placeholder="종료일선택" readonly autocomplete="off" value="<#if RequestParameters.endDate?? >${RequestParameters.endDate}<#else></#if>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <select class="custom-select" name="contractStatus" id="contractStatus">
                                            <option value="">전체</option>
                                            <option value="1" <#if RequestParameters.contractStatus?? ><#if RequestParameters.contractStatus = "1" >selected</#if></#if> >대기</option>
                                            <option value="2" <#if RequestParameters.contractStatus?? ><#if RequestParameters.contractStatus = "2" >selected</#if></#if>>사용</option>
                                            <option value="3" <#if RequestParameters.contractStatus?? ><#if RequestParameters.contractStatus = "3" >selected</#if></#if>>종료</option>
                                        </select>
                                    </div>
                                    <div class="col-2">

                                        <select class="custom-select" name="searchType" id="searchType">
                                            <option value="">전체</option>
                                            <option value="contractNumber" <#if RequestParameters.searchType?? ><#if RequestParameters.searchType = "contractNumber" >selected</#if></#if>>계약번호</option>
                                            <#--<option value="comName">회사명</option>-->
                                            <option value="contractName" <#if RequestParameters.searchType?? ><#if RequestParameters.searchType = "contractName" >selected</#if></#if>>계약명</option>
                                            <#--<option value="contractStart">시작일</option>-->
                                            <#--<option value="contractEnd">종료일</option>-->
                                            <#--<option value="contractStatus">상태</option>-->
                                            <option value="contractIctName" <#if RequestParameters.searchType?? ><#if RequestParameters.searchType = "contractIctName" >selected</#if></#if>>ICT 계약담당자</option>
                                        </select>
                                    </div>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="searchWord" id="searchWord" placeholder="검색어를 입력해주세요" aria-label="검색어를 입력해주세요" aria-describedby="button-search" value="<#if RequestParameters.searchWord?? >${RequestParameters.searchWord}<#else></#if>">
                                            <div class="input-group-append">
                                                <button class="btn btn-info d-flex align-items-center" type="submit" id="button-search">
                                                    <i class="icon-magnifying-glass"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
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
                                    <col width="160px">
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
                                        <th scope="col">
                                            <div class="d-flex">
                                                <span>계약번호</span>
                                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_number" data-orderby="1">
                                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                                </button>
                                            </div>
                                        </th>
                                        <#--<th scope="col">-->
                                            <#--<span>회사</span>-->
                                            <#--<button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="" data-orderby="1">-->
                                                <#--<i class="icon-sort-arrows-couple-pointing-up-and-down"></i>-->
                                            <#--</button>-->
                                        <#--</th>-->
                                        <th scope="col">
                                            <div class="d-flex">
                                                <span>계약명</span>
                                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_name" data-orderby="1">
                                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                                </button>
                                            </div>
                                        </th>
                                        <th scope="col">
                                            <div class="d-flex">
                                                <span>시작일</span>
                                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_start" data-orderby="1">
                                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                                </button>
                                            </div>
                                        </th>
                                        <th scope="col">
                                            <div class="d-flex">
                                                <span>종료일</span>
                                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_end" data-orderby="1">
                                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                                </button>
                                            </div>
                                        </th>
                                        <th scope="col">
                                            <div class="d-flex">
                                                <span>상태</span>
                                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_status" data-orderby="1">
                                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                                </button>
                                            </div>
                                        </th>
                                        <th scope="col">
                                            <div class="d-flex">
                                                <span>ICT 계약담당자</span>
                                                <button type="button" class="btn btn-link border-0 p-0 ml-2 sorting" data-sort="contract_ict_name" data-orderby="1">
                                                    <i class="icon-sort-arrows-couple-pointing-up-and-down"></i>
                                                </button>
                                            </div>
                                        </th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="contractList">

                                </tbody>
                            </table>
                            <nav id="paging" class="d-flex justify-content-center">

                            </nav>
                        </div>








<#--                        <div class="col-11 mt-5 mb-5">-->
<#--                            <table class="table">-->
<#--                                <colgroup>-->
<#--                                    <col width="30px">-->
<#--                                    <col>-->
<#--                                </colgroup>-->
<#--                                <thead>-->
<#--                                <tr>-->
<#--                                    <th scope="col">-->
<#--                                        <div class="form-check">-->
<#--                                            <input class="form-check-input position-static" type="checkbox" id="allCheck" value="" aria-label="...">-->
<#--                                        </div>-->
<#--                                    </th>-->
<#--                                    <th scope="col">계약번호</th>-->
<#--                                    <th scope="col">계약 시작일</th>-->
<#--                                    <th scope="col">계약 과금 정책</th>-->
<#--                                    <th scope="col">UnAttended 금액</th>-->
<#--                                    <th scope="col">Attended 금액</th>-->
<#--                                    <th scope="col">Develop 금액</th>-->
<#--                                </tr>-->
<#--                                </thead>-->
<#--                                <tbody id="licenseList">-->
<#--                                    <#list comContract as row>-->
<#--                                        <tr>-->
<#--                                            <td><input type="checkbox"></td>-->
<#--                                            <td>${row.comContractCode}</td>-->
<#--                                            <td>${row.contractStart?string["yyyy-MM-dd"]}</td>-->
<#--                                            <td>-->
<#--                                                <#if row.subscribeType?number = 0>-->
<#--                                                    Hour-->
<#--                                                <#elseif row.subscribeType?number = 1>-->
<#--                                                    Month-->
<#--                                                <#else>-->
<#--                                                    Annual-->
<#--                                                </#if>-->
<#--                                            </td>-->
<#--                                            <td>${row.priceUnattended!}</td>-->
<#--                                            <td>${row.priceAttended!}</td>-->
<#--                                            <td>${row.priceDeveloper!}</td>-->
<#--                                        </tr>-->
<#--                                    </#list>-->
<#--                                </tbody>-->
<#--                            </table>-->
<#--                        </div>-->

        </div>
        <!-- 계약회원일경우 끝 -->

    </div>
</section>
<table id="comContractListByExeclTable" style="display:none;">
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
        <th scope="col">상태</th>
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
        <th scope="col">등록일</th>
    </tr>
    </thead>
    <tbody id="comContractListByExeclBody"></tbody>
</table>
<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(document).ready(function() {
        getList(0,true);
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

        $("body").on("click",".newWindowView", function () {
            var comSeq = $(this).data("seq");
            window.open('/mypage/contract_management_info_detail?seq='+comSeq, '_blank');
        });

        $("body").on("click",".urlCopy", function () {
            var comSeq = $(this).data("seq");
            copyToClipboard(location.host + '/mypage/contract_management_info_detail?seq='+comSeq);
            alert("URL이 복사되었습니다.");
        });
        $(".btn-row").click(function(){
            $("#row").val($(this).data("row"));
            $(".btn-row").removeClass("btn-info").removeClass("btn-outline-secondary").addClass("btn-outline-secondary");

            $(this).removeClass("btn-outline-secondary").addClass("btn-info");
            getList(0,true);
            // $("#searchForm").submit();
        });
        $(".sorting").on("click", function(){
            // var fullStringClassName = $(this).attr("class");
            // var className = fullStringClassName.substring(45);
            var sortName = $(this).data("sort");
            var orderby = $(this).data("orderby");
            $(".sorting").children("i").removeClass("icon-caret-down").removeClass("icon-caret-up").addClass("icon-sort-arrows-couple-pointing-up-and-down");
            $(".sorting").each(function(){
                $(this).data("orderby","1");
            })
            if(orderby == "1"){
                $(this).data("orderby","0");
            }else{
                $(this).data("orderby","1");
            }
            $("#sort").val(sortName);
            $("#order").val(orderby);

            if($(this).data("orderby") == "0"){
                $(this).children("i").removeClass("icon-sort-arrows-couple-pointing-up-and-down").removeClass("icon-caret-up").addClass("icon-caret-down");
            }else{
                $(this).children("i").removeClass("icon-sort-arrows-couple-pointing-up-and-down").removeClass("icon-caret-down").addClass("icon-caret-up");
            }
            getList(0,true);
        });

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
        $("#searchType").val('${RequestParameters.searchType!}');
        $("#contractStatus").val('${RequestParameters.contractStatus!}')
        $("#startDate").val('${RequestParameters.startDate!}')
        $("#endDate").val('${RequestParameters.endDate!}')
        $("#searchWord").val('${RequestParameters.searchWord!}')
       $('#contractBtn').click(function(){
          var comName = $('#companyName').val();
          var serviceName = $('#serviceName').val();
          var servicePhone = $('#servicePhone').val();
          var serviceEmail = $('#serviceEmail').val();
          var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
          var phoneRegExp = /^\d{3}\d{3,4}\d{4}$/;
          if(!isEmpty(comName)) {
              alert('회사명 또는 단체, 개인명을 입력해 주세요.');
              return false
          }else if(!isEmpty(serviceName)) {
              alert('정산 담당자명이 존재하지 않습니다.');
              return false
          }else if(!isEmpty(servicePhone)) {
              alert('정산 담당자의 연락처가 존재하지 않습니다.');
              return false
          }else if(!phoneRegExp.test(servicePhone)) {
              alert('정산 담당자 연락처 형식이 옯바르지 않습니다.');
              return false
          }else if(!isEmpty(serviceEmail)) {
              alert('정산 담당자의 이메일이 존재하지 않습니다.');
              return false
          }else if(!emailRegExp.test(serviceEmail)) {
              alert('정산 담당자 이메일 형식이 옳바르지 않습니다.');
              return false
          }
           var datas = $("#contractForm").serialize();
           $.ajax({
               url: "/api/contractEdit",
               type: 'GET',
               dataType: 'JSON',
               data: datas,
               success: function (response) {
                   if(response.result == true) {
                       alert("계약정보가 저장되었습니다.");
                       location.reload();
                   }else {
                        alert("계약정보 저장중 에러가 발생하였습니다. 관리자에게 문의하세요.");
                   }
               }
           });
       });
    });

    function excelDownload(){
        $("#comContractListByExeclBody").html("");

        var chkValueArr = [];
        $(".listCheck").each(function () {
            if($(this).is(":checked")) chkValueArr.push($(this).val());
        });
        if(chkValueArr <= 0) {
            alert("계약을 1개 이상 선택해야합니다.");
        } else {
            var datas = { checkSeq : chkValueArr.join("|"), "sort":$("#sort").val(),"order":$("#order").val() };
            $.ajax({
                url: "/api/contractExeclDownList",
                type: 'POST',
                dataType: 'JSON',
                data: datas
            }).done(function (response) {
                console.log(response);
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
                var companyList = response.list;
                var html = '';
                for(var i=0;i<companyList.length;i++) {
                    var startdate = moment(companyList[i].contractStart).format("YYYY-MM-DD");
                    var enddate = moment(companyList[i].contractEnd).format("YYYY-MM-DD");
                    var today = moment(new Date()).format("YYYY-MM-DD");
                    // console.log(today);
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
                    html = '<tr><td >'+(i+1)+'</td>\
                        <td >'+companyList[i].contractNumber+'</td>\
                        <td >'+companyList[i].contractName+'</td>\
                        <td >'+moment(companyList[i].contractStart).format("YYYY-MM-DD")+'</td>\
                        <td >'+moment(companyList[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                        <td >'+status+'</td>\
                        <td >'+companyList[i].contractIctName+'</td>\
                        <td >'+contractType+'</td>\
                        <td >'+licenseType+'</td>\
                        <td >'+subscribeType+'</td>\
                        <td >'+(companyList[i].unattendedLicensePrice === null ? 0:companyList[i].unattendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].unattendedLicenseListPrice === null ? 0:companyList[i].unattendedLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countUnattended === null ? 0:companyList[i].countUnattended)+'</td>\
                        <td >'+(companyList[i].attendedLicensePrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].attendedLicenseListPrice === null ? 0:companyList[i].attendedLicensePrice)+'</td>\
                        <td >'+(companyList[i].countAttended === null ? 0:companyList[i].countAttended)+'</td>\
                        <td >'+(companyList[i].studioLicensePrice === null ? 0:companyList[i].studioLicensePrice)+'</td>\
                        <td >'+(companyList[i].studioLicenseListPrice === null ? 0:companyList[i].studioLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countStudio === null ? 0:companyList[i].countStudio)+'</td>\
                        <td >'+(companyList[i].workcenterLicensePrice === null ? 0:companyList[i].workcenterLicensePrice)+'</td>\
                        <td >'+(companyList[i].workcenterLicenseListPrice === null ? 0:companyList[i].workcenterLicenseListPrice)+'</td>\
                        <td >'+(companyList[i].countWorkcenter === null ? 0:companyList[i].countWorkcenter)+'</td>\
                        <td >'+moment(companyList[i].createDatetime).format("YYYY-MM-DD")+'</td></tr>';

                    $("#comContractListByExeclBody").append(html);
                }

                var filename = "contractList.xlsx";
                /* create new workbook */
                var workbook = XLSX.utils.book_new();

                /* convert table 'table1' to worksheet named "Sheet1" */
                var ws1 = XLSX.utils.table_to_sheet(document.getElementById('comContractListByExeclTable'));
                XLSX.utils.book_append_sheet(workbook, ws1, "Sheet1");

                XLSX.writeFile(workbook, filename);
            });
        }
    }
    function copyToClipboard(val) {
        var t = document.createElement("textarea");
        document.body.appendChild(t);
        t.value = val;
        t.select();
        document.execCommand('copy');
        document.body.removeChild(t);
    }
    function getList(num,refresh){
        $("input:checkbox[id='allCheck']").prop("checked", false);
        var datas = $("#searchForm").serialize()+"&page="+num;
        $.ajax({
            url: "/mypage/ajax_list",
            type: 'GET',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                console.log(response);
                var html = "";
                for(var i =0 ; i< response.list.length;i++){
                    var no = response.total-(num*$("#row").val()+i);
                    if(response.list[i].subscribeType == "1"){
                        var subscribeType = "Hour";
                    }else if(response.list[i].subscribeType == "2"){
                        var subscribeType = "Month";
                    }else{
                        var subscribeType = "Annual";
                    }
                    var startdate = moment(response.list[i].contractStart).format("YYYY-MM-DD");
                    var enddate = moment(response.list[i].contractEnd).format("YYYY-MM-DD");
                    var today = moment(new Date()).format("YYYY-MM-DD");
                    // console.log(today);
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

                html += '<tr>\
                            <th scope="col" >\
                                <div class="form-check">\
                                <input class="listCheck form-check-input position-static" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                                </div>\
                                </th>\
                                <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+no+'</td>\
                                <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+response.list[i].contractNumber+'</td>\
                                <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+response.list[i].contractName+'</td>\
                                <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+moment(response.list[i].contractStart).format("YYYY-MM-DD")+'</td>\
                                <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+moment(response.list[i].contractEnd).format("YYYY-MM-DD")+'</td>\
                                <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+status+'\
                            </td>\
                            <td scope="col" style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+response.list[i].contractIctName+'</td>\
                                <td scope="col">\
                                <div class="more-action-dropdown">\
                                <button class="more-action-btn" type="button">\
                                <i class="icon-navigation-more font12 mr-2"></i>\
                                <i class="icon-caret-down font11"></i>\
                                </button>\
                                <div class="more-action-dropdown-content">\
                                <button type="button" class="more-action-item newWindowView" data-seq="'+response.list[i].seq+'">\
                                <i class="icon-window-new mr-2" style="color:#000"></i>새로운창 띄우기\
                                </button>\
                                <button type="button" class="more-action-item urlCopy" data-seq="'+response.list[i].seq+'">\
                                <i class="icon-layers mr-2" style="color:#000"></i>URL 복사\
                                </button>\
                                </div>\
                                </div>\
                                </td>\
                                </tr>';


                    // html += '<tr>\
                    //             <td scope="row">\
                    //                 <div class="form-check">\
                    //                     <input class="form-check-input position-static listCheck" name="seqs" type="checkbox" value="'+response.list[i].seq+'" aria-label="...">\
                    //                 </div>\
                    //             </td>\
                    //             <td style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+no+'</td>\
                    //             <td style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+response.list[i].comContractCode+'</td>\
                    //             <td style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+moment(response.list[i].startDate).format("YYYY-MM-DD")+'</td>\
                    //             <td style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+(response.list[i].userName != "" ? response.list[i].userName:response.list[i].loginId)+'</td>\
                    //             <td>'+subscribeType+'</td>\
                    //             <td>Attended : '+response.list[i].priceAttended+'<br>UnAttended : '+response.list[i].priceUnattended+'<br>Studio : '+response.list[i].priceDeveloper+'\
                    //             </td>\
                    //             <td>총 <a href="/license/new_list?contractSeq='+response.list[i].seq+'" style="text-decoration: underline">'+response.list[i].countLicense+'건</a></td>\
                    //             <td style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+status+'</td>\
                    //             <td style="cursor: pointer" onclick="contractViewDetail('+response.list[i].seq+')">'+moment(response.list[i].createDatetime).format("YYYY-MM-DD")+'</td>\
                    //             <td>\
                    //                 <div class="more-action-dropdown">\
                    //                     <button class="more-action-btn" type="button"><i class="icon-navigation-more font12 mr-2"></i><i class="icon-caret-down font11"></i></button>\
                    //                     <div class="more-action-dropdown-content">\
                    //                         <button type="button" class="more-action-item newWindowView" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-window-new mr-2"></i>새로운창 띄우기\
                    //                         </button>\
                    //                         <button type="button" class="more-action-item urlCopy" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-layers mr-2"></i>URL 복사\
                    //                         </button>\
                    //                         <div class="dropdown-divider"></div>\
                    //                         <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#comLicenseModal" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-key1 mr-2"></i>계약회사 라이센스 목록\
                    //                         </button>\
                    //                         <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#ccpInfoModal" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-credit-card mr-2"></i>결제내역 조회\
                    //                         </button>\
                    //                         <button type="button" class="more-action-item" data-toggle="modal" data-backdrop="static" data-target="#ccapInfoModal" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-hand-stop mr-2"></i>미수금 내역 조회\
                    //                         </button>\
                    //                         <div class="dropdown-divider"></div>\
                    //                         <button type="button" class="more-action-item" onclick="document.location.href=\'/contract/new_update?comContractSeq='+response.list[i].seq+'\'" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-compose mr-2"></i>수정\
                    //                         </button>\
                    //                         <button type="button" class="more-action-item contractDelete" data-seq="'+response.list[i].seq+'">\
                    //                             <i class="icon-trash1 mr-2"></i>삭제\
                    //                         </button>\
                    //                     </div>\
                    //                 </div>\
                    //             </td>\
                    //         </tr>';

                    // <tr>
                    //     <td colspan="11" align="center">사용자가 없습니다.</td>
                    //     </tr>

                }
                if(html == ""){
                    html += '<tr><td colspan="9" align=center>등록된 계약 목록이 존재하지 않습니다.</td></tr>';
                }
                $("#contractList").html(html);
                // $("#totalCnt").html(response.total);
                if(response.total > 0) {
                    if(refresh) {
                        $('#paging').bootpag({
                            total: Math.ceil(response.total/parseInt($("#row").val())),
                            page : 1,
                            maxVisible : 5,
                            firstLastUse: true,
                            first: '<<',
                            last: '>>',
                            next: '>',
                            prev: '<'
                        }).on("page", function (event, num) {
                            getList(num-1, false);
                        });
                    }
                }else {
                    if(refresh) {
                        $('#paging').bootpag({
                            total: 1,
                            page : 1,
                            maxVisible : 5,
                            firstLastUse: true,
                            first: '<<',
                            last: '>>',
                            next: '>',
                            prev: '<'
                        }).on("page", function (event, num) {
                            getList(num-1, false);
                        });
                    }
                }
            }
        });
    }

    function contractViewDetail(seq){
        document.location.href='/mypage/contract_management_info_detail?seq='+seq
    }
</script>

<!-- custom script 끝 -->
<#include "/layout/footer.ftl">