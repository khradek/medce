document.addEventListener("turbolinks:load", function() {

  //Scrolls back down to Web Articles section when pagination is used
  $('#web-article-scroll').on('click', function() {
    setTimeout(function(){
      $('.focus')[0].focus();
    }, 200);
  });

});