<#include "/layout/base.ftl">
<#include "/layout/sub_header.ftl">

<div class="sub-title-bg background-base-code background-h3">
    News
</div>

<section class="place-wrap pb-5">
    <div class="container px-5">
        <div class="row mb-2">
            <div class="col-12">
                전체 게시물 : <span id="totalCount"></span>
            </div>
            <#--  <div class="col-3">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="Search" aria-label="" aria-describedby="">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" id="button-addon2"><i class="icon icon-search"></i></button>
                    </div>
                </div>

            </div>  -->
        </div>
        <div class="row">
            <div class="col-12" id="newsroomList">

                <div class="minh-640 d-flex flex-column justify-content-center align-items-center border-top">
                    <i class="icon-exclamation-outline font4rem span-gray-color"></i>
                    <div class="text-center mt-5">죄송합니다.<br>등록된 게시물이 없습니다.</div>
                </div>

                <#--<div class="d-flex border-top py-3">-->
                    <#--<div class="w-25">-->
                        <#--<img src="https://www.poscoict.com/filedata/board_some/201904021015303650_cont.JPG" class="card-img-top" alt="...">-->
                    <#--</div>-->
                    <#--<div class="w-75">-->
                        <#--<div class="d-flex align-items-start flex-column ml-5" style="height: 164px;">-->
                            <#--<div><h4 class="card-title news-link mb-3"><a href="/news_view">포스코ICT, 국내 최대 규모 스마트팩토리 전시회 참가</a></h4></div>-->
                            <#--<div><p class="card-text">포스코ICT(대표 손건재)가 저소득층 청소년들을 위한 스크래치 코딩 프로그램 ‘코딩 꿈나무 교실’을 열었다.</p></div>-->
                            <#--<div class="mt-auto"><p class="text-muted">2019.05.29</p></div>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->

                <#--<div class="d-flex border-top py-3">-->
                    <#--<div class="w-25">-->
                        <#--<img src="https://www.poscoict.com/filedata/board_some/201904021015303650_cont.JPG" class="card-img-top" alt="...">-->
                    <#--</div>-->
                    <#--<div class="w-75">-->
                        <#--<div class="d-flex align-items-start flex-column ml-5" style="height: 164px;">-->
                            <#--<div><h4 class="card-title news-link mb-3"><a href="/news_view">포스코ICT, 국내 최대 규모 스마트팩토리 전시회 참가</a></h4></div>-->
                            <#--<div><p class="card-text">포스코ICT(대표 손건재)가 저소득층 청소년들을 위한 스크래치 코딩 프로그램 ‘코딩 꿈나무 교실’을 열었다.</p></div>-->
                            <#--<div class="mt-auto"><p class="text-muted">2019.05.29</p></div>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->

                <#--<div class="d-flex border-top py-3">-->
                    <#--<div class="w-25">-->
                        <#--<img src="https://www.poscoict.com/filedata/board_some/201904021015303650_cont.JPG" class="card-img-top" alt="...">-->
                    <#--</div>-->
                    <#--<div class="w-75">-->
                        <#--<div class="d-flex align-items-start flex-column ml-5" style="height: 164px;">-->
                            <#--<div><h4 class="card-title news-link mb-3"><a href="/news_view">포스코ICT, 국내 최대 규모 스마트팩토리 전시회 참가</a></h4></div>-->
                            <#--<div><p class="card-text">포스코ICT(대표 손건재)가 저소득층 청소년들을 위한 스크래치 코딩 프로그램 ‘코딩 꿈나무 교실’을 열었다.</p></div>-->
                            <#--<div class="mt-auto"><p class="text-muted">2019.05.29</p></div>-->
                        <#--</div>-->
                    <#--</div>-->
                <#--</div>-->

            </div>

            <div class="col-12">

                <div class="border-top">
                    <#--<nav aria-label="Page navigation">-->
                        <#--<ul class="pagination justify-content-center">-->
                            <#--<li class="page-item disabled">-->
                                <#--<a class="page-link" href="#" tabindex="-1" aria-disabled="true"><</a>-->
                            <#--</li>-->
                            <#--<li class="page-item"><a class="page-link" href="#">1</a></li>-->
                            <#--<li class="page-item"><a class="page-link" href="#">2</a></li>-->
                            <#--<li class="page-item"><a class="page-link" href="#">3</a></li>-->
                            <#--<li class="page-item">-->
                                <#--<a class="page-link" href="#">></a>-->
                            <#--</li>-->
                        <#--</ul>-->
                    <#--</nav>-->
                    <nav id="paging" class="d-flex justify-content-center">

                    </nav>
                </div>

            </div>

        </div>
    </div>
</section>

<#include "/layout/modal.ftl">
<#include "/layout/base_script.ftl">
<!-- custom script 위치 -->
<script>
    $(function(){
        getList(0,true);
    })
    function getList(num,refresh){
        var datas = $("#searchForm").serialize()+"&page="+num;
        $.ajax({
            url: "/newsroom/ajax_list",
            type: 'GET',
            dataType: 'JSON',
            data: datas,
            success: function (response) {
                console.log(response);
                var html = "";
                for(var i =0 ; i < response.list.length;i++){
                    html += '<div class="d-flex border-top py-3">\
                            <div class="w-25">\
                                <div class="newslist-left-img" style="background-image:url('+response.list[i].listFile+')"></div>\
                            </div>\
                            <div class="w-75">\
                                <div class="d-flex align-items-start flex-column ml-5" style="height:183px;">\
                                    <div><h4 class="card-title news-link mb-3"><a href="/news_view?newsroomId='+response.list[i].seq+'">'+response.list[i].title+'</a></h4></div>\
                                    <div><p class="card-text word-space-kll">'+response.list[i].subTitle+'</p></div>\
                                    <div class="mt-auto"><p class="text-muted mb-0">'+moment(response.list[i].viewDatetime).format("YYYY-MM-DD")+'</p></div>\
                                </div>\
                            </div>\
                            </div>';
                }
                $("#newsroomList").html(html);
                $("#totalCount").html(response.total);
                if(refresh) {
                    if(response.total > 0) {
                        $('#paging').bootpag({
                            total: Math.ceil(response.total / 10),
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
</script>
<!-- custom script 끝 -->
<#include "/layout/footer.ftl">