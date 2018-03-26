$(".courses.take_evaluation").ready(function() {

  //Clears answers when evaluation is submitted (stops user from seeing previous answers by pressing the back button) and shows calculating score overlay
  $(document).on("click", "#evaluation-submit-button", function(){
    event.preventDefault();
    $(".overlay").show()
    setTimeout(function() {
      $('#evaluation-form').submit();
      $(":radio").prop('checked', false);
    }, 2000);
    
  });

  //Disables submit button on take_evaluation page unless an answer is chosen for every question
  var noBlanks = function () {
    var button = $('#evaluation-submit-button').prop('disabled', true);
    var radios = $('input[type="radio"]');
    var arr    = $.map(radios, function(el) { 
                      return el.name; 
                 });

    var groups = $.grep(arr, function(v, k){
                     return $.inArray(v ,arr) === k;
                 }).length;

    radios.on('change', function () {
        button.prop('disabled', radios.filter(':checked').length < groups);
    });
  };
  $(document).on('turbolinks:load', noBlanks );

});