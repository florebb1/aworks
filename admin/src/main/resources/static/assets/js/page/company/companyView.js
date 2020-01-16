$(function(){

    /* DatePicker Script */
    $('#contractStart_m').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        footer: true,
        showOtherMonths: true
    });
    $('#contractEnd_m').datepicker({
        uiLibrary: 'bootstrap4',
        format: 'yyyy-mm-dd',
        footer: true,
        showOtherMonths: true
    });

    var today = moment(new Date()).format("YYYY-MM-DD");
    $(".currentStatus").each(function(){
        var startdate = $(this).data("start");
        var enddate = $(this).data("end");

        // console.log(today);
        if(enddate != "" && enddate < today){
            $(this).html("종료");
            // $("#contractStatus").val(3)
        }else if(startdate != "" && startdate > today){
            $(this).html("대기");
            // $("#contractStatus").val(1);
        }else if(enddate != "" && enddate >= today && startdate != "" && startdate <= today){
            // $("#contractStatus").val(2);
            $(this).html("사용");
        }else{
            // $("#contractStatus").val(1);
            $(this).html("대기");
        }
    })
});