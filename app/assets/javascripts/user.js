$(".users.show").ready(function() {

  $(document).on("change", "#author-dropdown", function() { 
    var author_id = $("#author-dropdown").val();
    var url = '/users/'+ author_id;
    window.location.href = url;
  });

});