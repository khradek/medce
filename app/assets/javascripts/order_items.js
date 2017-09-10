$.rails.allowAction = function(element){
    if( undefined === element.attr('data-confirm') ){
        return true;
    }

    $.rails.showConfirmDialog(element);
    return false;
};

$.rails.confirmed = function(element){
    element.removeAttr('data-confirm');
    element.trigger('click.rails');
};

$.rails.showConfirmDialog = function(element){
    var msg = element.data('confirm');
    alertify.confirm(msg, function(e){
        if(e){
            $.rails.confirmed(element);
        }
    })
};
