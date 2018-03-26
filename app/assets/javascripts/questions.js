document.addEventListener("turbolinks:load", function() {

  //Sort functionality on Evaluations show page
  $("#questions").sortable({
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });

  //Allows only one correct checkbox to be checked on Questions edit page
  $('.correctCheck').on('change', function() {
    $('.correctCheck').not(this).prop('checked', false);  
  });

});