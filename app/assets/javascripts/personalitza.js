$(document).ready(function() {
  $('.mostres a').hover(
    function() { canvi_mostra($(this), false); }, 
    function() { canvi_mostra($(this), false, true); }
  );
  $('.mostres a').click(function() {
    canvi_mostra($(this), true);
    return false;
  });
  $('.estampats input').change(function() {
    canvi_estampat($(this));
  });
})

function canvi_mostra(obj, save, orig) {
  if (save==undefined) save = false;
  if (orig==undefined) orig = false;
  var div = obj.parents('.mostres');
  var input = div.find('input');
  if (orig) var val = input.val();
  else var val = obj.attr('href');
  var name = input.attr('name');
  $('path.'+name).css('fill','url(#mostra_'+val+')');
  if (save) {
    div.find('a').removeClass('selected');
    obj.addClass('selected');
    input.val(val);
  }
}

function canvi_estampat(obj) {
  var name = obj.attr('name');
  if (obj.is(':checked')) {
    $('path.'+name).show();
  } else {
    $('path.'+name).hide();
  }
}