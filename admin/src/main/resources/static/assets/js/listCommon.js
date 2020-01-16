$(function(){
    // checkbox all check
    $("#allCheck").click(function(){
        if($(this).is(":checked")){
            $(".listCheck").prop("checked",true);
        }else{
            $(".listCheck").prop("checked",false);
        }
    });

    // checkbox 예외처리
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

    /*
    action 버튼 새창보기
    */

    $("body").on("click",".newWindowView", function () {
        var url = $(this).data("url");
        // /abbyy/detail?seq=
        window.open(url, '_blank');
    });
    /* action url 카피 */
    $("body").on("click",".urlCopy", function () {
        var url = $(this).data("url");
        copyToClipboard(location.host + url);
        alert("URL이 복사되었습니다.");
    });

    // view count 버튼 클릭 이벤트
    $(".btn-row").click(function(){
        $("#row").val($(this).data("row"));
        $(".btn-row").removeClass("btn-primary").removeClass("btn-light").addClass("btn-light");

        $(this).removeClass("btn-light").addClass("btn-primary");
        getList(0,true);
        // $("#searchForm").submit();
    });

    // sort icon 클릭 이벤트
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

    $("body").on("click",".listUrlModify", function () {
        var url = $(this).data("url");
        document.location.href = url;
    });

})
