var ready = function(){
  var i = 0;
  function change_counter(){
    i = i + 2;
    $('#random_card_time').attr('value', i);
    setTimeout( change_counter, 1000 );
  }
  setTimeout( change_counter, 1000 );
};
$(document).ready(ready);
$(document).on('page:change', ready });