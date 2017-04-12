var ready = function(){
  var i = 0;
  function change_counter(){ 
    $(document).ajaxSuccess( function() { i = 0 } )
    i = i + 1;
    $('#random_card_time').attr('value', i);
    setTimeout( change_counter, 1000 );
  }
  setTimeout( change_counter, 1000 );
}
$(document).ready(ready);
