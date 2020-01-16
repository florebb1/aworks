$(document).ready(function(){
    var marketId = getParameter("marketId");
    // if(isEmpty(loginId)){
    //     $.ajax({
    //         url: "/market/loginInfo",
    //         type: 'GET',
    //         data: {
    //             marketId: marketId,
    //             loginId: loginId
    //         },
    //         dataType: 'JSON',
    //         success: function (response) {
    //             if(response.likeCount > 0) {
    //                 $('#likeIcon').addClass("span-thumup-color");
    //                 $('#ratingIcon').addClass("span-active-color");
    //                 if(response.rating == 0.5) {
    //                     $("#starhalf").prop("checked", true)
    //                 }else if(response.rating == 1) {
    //                     $("#star1").prop("checked", true)
    //                 }else if(response.rating == 1.5) {
    //                     $("#star1half").prop("checked", true)
    //                 }else if(response.rating == 2) {
    //                     $("#star2").prop("checked", true)
    //                 }else if(response.rating == 2.5) {
    //                     $("#star2half").prop("checked", true)
    //                 }else if(response.rating == 3) {
    //                     $("#star3").prop("checked", true)
    //                 }else if(response.rating == 3.5) {
    //                     $("#star3half").prop("checked", true)
    //                 }else if(response.rating == 4) {
    //                     $("#star4").prop("checked", true)
    //                 }else if(response.rating == 4.5) {
    //                     $("#star4half").prop("checked", true)
    //                 }else if(response.rating == 5) {
    //                     $("#star5").prop("checked", true)
    //                 }
    //             }else {
    //                 $('#likeIcon').removeClass("span-thumup-color");
    //                 $('#ratingIcon').addClass("span-active-color");
    //             }
    //         }
    //     });
    // }

    //평가버튼 클릭시 이벤트
    $('#ratingBtn').click(function(){
        var downCount = $('#downCtn').val();
        //비로그인시 로그인 모달 오픈
        if(!isEmpty(loginId)) {
            $('#login-md').modal('show');
            return false;
        }else if(downCount == 0) {
            alert("해당 앱을 평가하시려면 다운로드를 하셔야합니다.");
            return false;
        }
    });

    //평가하기 점수 변경시 이벤트
    $('input:radio[name=rating]').click(function(){
        var appRating = $(this).val();
        $.ajax({
            url: "/market/rating",
            type: 'GET',
            data: {
                marketId: marketId,
                loginId: loginId,
                appRating: appRating
            },
            dataType: 'JSON',
            success: function (response) {
                if(response.result == "add" || response.result == "edit") {
                    window.location.reload);
                }else {
                    alert("알 수 없는 오류가 발생하였습니다. 상태가 계속될 경우 관리자에게 문의해주세요.")
                }
            }
        });
    });
    // 입력창 포커싱일때 로그인 확인
    $('#reviewInput').focusin(function(){
        if(!isEmpty(loginId)) {
            $('#login-md').modal('show');
            return false;
        }
    });
    $('#reviewBtn').click(function(){
        var review = $('#reviewInput').val();
        if(isEmpty(review)){
            $.ajax({
                url: "/market/reviewWrite",
                type: 'GET',
                data: {
                    marketId: marketId,
                    loginId: loginId,
                    review: review
                },
                dataType: 'JSON',
                success: function (response) {
                    if(response.result == true) {
                        window.location.reload();
                    }else {
                        alert("알 수 없는 오류가 발생하였습니다. 상태가 계속될 경우 관리자에게 문의해주세요.")
                    }
                }
            });
        }else {
            alert("내용을 입력해 주세요.");
            $("#reviewInput").focus();
        }
    })
});