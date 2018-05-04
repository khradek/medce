document.addEventListener("turbolinks:load", function() {
 
  $(document).on("scroll", onScroll);
  
  //smoothscroll
  $('a[href^="#"]').on('click', function (e) {
    e.preventDefault();
    $(document).off("scroll");
    
    $('a').each(function () {
      $(this).removeClass('h-active');
    })
    $(this).addClass('h-active');
  
    var target = this.hash,
    menu = target;
    $target = $(target);
    $('html, body').stop().animate({
      'scrollTop': $target.offset().top
    }, 800, 'swing', function () {
      window.location.hash = target;
      $(document).on("scroll", onScroll);
    });
  });

  //Adds active class to navbar links
  function onScroll(event){
    var scrollPos = $(document).scrollTop() + 100;
    $('#bs-example-navbar-collapse-1 a').each(function () {
      var currLink = $(this);
      var refElement = $(currLink.attr("href"));
 
      if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
          $('#bs-example-navbar-collapse-1 ul li a').removeClass("h-active");
          currLink.addClass("h-active");
        }
        else{
          currLink.removeClass("h-active");
        }
    });
  }

  //Fixes navbar to top of screen
  $(window).scroll(function () { 
    var height = $('.nav-home').height();
    if ($(window).scrollTop() > height) {
      $('.nav-home').addClass('h-navbar-fixed');
      $('#main-image-container').addClass('adjust-height')
    }
    if ($(window).scrollTop() < height) {
      $('.nav-home').removeClass('h-navbar-fixed');
      $('#main-image-container').removeClass('adjust-height')
    }
  });  

});