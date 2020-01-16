

<script>
var modalFunction = function(option, callFunction, fromModal) {
    $('body').removeClass('modal-open');
    if (!fromModal) {
        $('.modal-backdrop').remove();
    }
    var defaultOption = {
        size : "modal-sm",
        title : "알림",
        content : "성공했습니다."
    }
    var modal = $(".alert-modal")
    var modalSize = option.size || defaultOption.size; // 모달 창 사이즈
    var modalTitle = option.title || defaultOption.title; // 모달 타이틀
    var modalContent = option.content || defaultOption.content; // 모달 내용
    var modalCloseBtn = false; // true or false 모달 취소 버튼
    switch(option.type){
        case "alert":
            modalCloseBtn = false;
            break;
        case "confirm":
            modalCloseBtn = true;
            break;
        default :
            modalCloseBtn = false;
    }

    // 모달 셋팅
    modal.find(".modal-title").html(modalTitle); // 모달 제목
    modal.find(".modal-dialog").addClass(modalSize); // 모달 사이즈
    modal.find(".modal-body").html(modalContent); // 모달 컨텐츠
    if(modalCloseBtn){
        modal.find(".modal-cancel").show();
    }else{
        modal.find(".modal-cancel").hide();
    }
    modal.modal("show");

    modal.find(".modal-success").bind("click",function(){
        modal.modal("hide");
        // $('body').removeClass('modal-open');
        if (!fromModal) {
            $('.modal-backdrop').remove();
        }

        modal.find(".modal-success").unbind("click");
        if(typeof callFunction === "function"){
            callFunction();
        } else{
            modal.modal("hide");
        }
        return false;


    })
    modal.find(".modal-cancel").bind("click",function(){
        modal.find(".modal-cancel").unbind("click");
        modal.find(".modal-success").unbind("click");
    });
}
</script>

<div class="modal fade alert-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" style="display: none;" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="mySmallModalLabel"></h4> </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default waves-effect modal-cancel" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger waves-effect waves-light modal-success">확인</button>
            </div>
        </div>
    </div>
</div>

