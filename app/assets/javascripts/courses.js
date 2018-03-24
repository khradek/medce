$(".courses.take_evaluation").ready(function() {

  $(document).on("click", "#evaluation-submit-button", function(){
    event.preventDefault();
    $('#evaluation-form').submit();
    $(":radio").prop('checked', false);
  });

});