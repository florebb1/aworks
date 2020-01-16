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

/* ### Middle Recommend item Carousel  ### */

$('#recipeCarousel').carousel({
  interval: 10000
})

$('.carousel .carousel-item').each(function(){
    var next = $(this).next();
    if (!next.length) {
    next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));
    
    if (next.next().length>0) {
    next.next().children(':first-child').clone().appendTo($(this));
    }
    else {
      $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
    }
});

/* ### Tooltip  ### */

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})