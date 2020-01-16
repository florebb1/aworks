/* ### Main Top Nav fixed Animation  ### */

$(window).on("scroll", function() {
    if($(window).scrollTop() > 0) {
		$(".header").addClass("active");
    } else {
		$(".header").removeClass("active");
    }
});

/* ### Sub Top Nav fixed Animation  ### */

$(window).on("scroll", function() {
    if($(window).scrollTop() > 0) {
        $(".sub-header").addClass("active");
    } else {
        $(".sub-header").removeClass("active");
    }
});


/* ### Tooltip  ### */

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})


/* ### page-section dotted navigation  ### */

$(document).ready(function() {
    $('a[href*=\\#]').bind('click', function(e) {
        e.preventDefault();
        var target = $(this).attr("href");
        $('html, body').stop().animate({
                scrollTop: $(target).offset().top
        }, 100, function() {
                location.hash = target;
        });
        return false;
    });
});

$(window).scroll(function() {
    var scrollDistance = $(window).scrollTop();
    $('.page-section').each(function(i) {
        if ($(this).position().top <= scrollDistance) {
            $('.navigation a.active').removeClass('active');
            $('.navigation a').eq(i).addClass('active');
        }
    });
}).scroll();


/* ### datepicker  ### */

$('#datestart').datepicker({
    uiLibrary: 'bootstrap4',
    format: 'yyyy-mm-dd',
    footer: false,
    showOtherMonths: true,
    icons: {
        rightIcon: '<i class="icon-process_03"></i>'
    }
});
$('#dateend').datepicker({
    uiLibrary: 'bootstrap4',
    format: 'yyyy-mm-dd',
    footer: false,
    showOtherMonths: true,
    icons: {
        rightIcon: '<i class="icon-process_03"></i>'
    }
});