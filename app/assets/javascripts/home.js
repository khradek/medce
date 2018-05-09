document.addEventListener("turbolinks:load", function() {
 
  $(document).on("scroll", onScroll);
  
  //Adds active class to navbar links
  function onScroll(event){

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