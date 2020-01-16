<#include "/layout/base.ftl">
<#include "/layout/market_header.ftl">

<section class="sub-hero d-flex flex-column justify-content-center align-items-center">
    <h1><@spring.message "market.text1"/></h1>
    <div><@spring.message "market.text2"/></div>
</section>

<section class="place-wrap">
    <div class="container">
        <div class="row sub-top-area mb-3">
            <div class="col-auto text-left">
                <span id="totalCount">0</span><@spring.message "market.text3"/>
            </div>
            <div class="col text-right">
                <select id="criteria" name="criteria" class="form-control solt-select">
                    <option value="0"><@spring.message "market.text4"/></option>
                    <option value="1"><@spring.message "market.text5"/></option>
                    <option value="2"><@spring.message "market.text6"/></option>
                    <option value="3"><@spring.message "market.text7"/></option>
<#--                    <option value="4">리뷰순</option>-->
                    <option value="5"><@spring.message "market.text8"/></option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-auto text-left">
                <form class="min-width200">
                    <input type="hidden" id="componentArr" name="componentArr">
                    <input type="hidden" id="bussinessArr" name="bussinessArr">
                    <input type="hidden" id="applicationArr" name="applicationArr">
                    <input type="hidden" id="page" name="page" value="0">
                    <div class="input-group">
                        <input type="text" class="form-control" id="search" name="search" aria-describedby="search" placeholder="<@spring.message "market.text9"/>">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-info" id="searchBtn">
                                <i class="icon-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-group-title">
                        <h6 class="row">
                            <div class="col"><@spring.message "market.text10"/></div>
                            <div class="col d-flex justify-content-end align-items-center">
                                <button type="button" id="componentCencel" class="chkbox-reset-btn pointer"><i class="icon-reload font18"></i></button>
                            </div>
                        </h6>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Process" name="component" value="0">
                        <label class="form-check-label" for="Process"><@spring.message "market.text11"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Task" name="component" value="1">
                        <label class="form-check-label" for="Task"><@spring.message "market.text12"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Item" name="component" value="2">
                        <label class="form-check-label" for="Item"><@spring.message "market.text13"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Connector" name="component" value="3">
                        <label class="form-check-label" for="Connector"><@spring.message "market.text14"/></label>
                    </div>

                    <div class="form-group-title">
                        <h6 class="row">
                            <div class="col-8"><@spring.message "market.text15"/></div>
                            <div class="col d-flex justify-content-end align-items-center">
                                <button type="button" id="BICencel" class="chkbox-reset-btn pointer"><i class="icon-reload font18"></i></button>
                            </div>
                        </h6>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Finance" name="bussiness" value="0">
                        <label class="form-check-label" for="Finance"><@spring.message "market.text16"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="HR" name="bussiness" value="1">
                        <label class="form-check-label" for="HR"><@spring.message "market.text17"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Sales" name="bussiness" value="2">
                        <label class="form-check-label" for="Sales"><@spring.message "market.text18"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Others" name="bussiness" value="3">
                        <label class="form-check-label" for="Others"><@spring.message "market.text19"/></label>
                    </div>

                    <div class="form-group-title">
                        <h6 class="row">
                            <div class="col"><@spring.message "market.text20"/></div>
                            <div class="col d-flex justify-content-end align-items-center">
                                <button type="button" id="appCencel" class="chkbox-reset-btn pointer"><i id="appCencel" class="icon-reload font18"></i></button>
                            </div>
                        </h6>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Adobe" name="application" value="0">
                        <label class="form-check-label" for="Adobe"><@spring.message "market.text21"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Microsoft" name="application" value="1">
                        <label class="form-check-label" for="Microsoft"><@spring.message "market.text22"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="Oracle" name="application" value="2">
                        <label class="form-check-label" for="Oracle"><@spring.message "market.text23"/></label>
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="SAP" name="application" value="3">
                        <label class="form-check-label" for="SAP"><@spring.message "market.text24"/></label>
                    </div>

                    <button type="button" id="chkReset" class="btn btn-info btn-block mt-5"><@spring.message "market.text25"/></button>
                </form>
            </div>
            <div class="col text-right">
                <div id="appList" class="form-row"></div>
            </div>
        </div>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script type="text/javascript" src="/assets/js/market/list.js"></script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">