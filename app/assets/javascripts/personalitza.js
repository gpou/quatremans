$(document).ready(function() {
  $('.mostres a').hover(
    function() { canvi_mostra($(this), false); }, 
    function() { canvi_mostra($(this), false, true); }
  );
  $('.mostres a').click(function() {
    canvi_mostra($(this), true);
    return false;
  });
  $('.estampats a').hover(
    function() { canvi_estampat($(this), false); }, 
    function() { canvi_estampat($(this), false, true); }
  );
  $('.estampats a').click(function() {
    canvi_estampat($(this), true);
    return false;
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
  $("path[class='"+name+"']").css('fill','url(#mostra_'+val+')');
  if (save) {
    div.find('a').removeClass('selected');
    obj.addClass('selected');
    input.val(val);
  }
}

function canvi_estampat(obj, save, orig) {
  if (save==undefined) save = false;
  if (orig==undefined) orig = false;
  var div = obj.parents('.estampats');
  var input = div.find('input');
  if (orig) var val = input.val();
  else var val = obj.attr('href');
  var name = input.attr('name');
  $("use[class='"+name+"']").attr('xlink:href','#estampat_'+val);
  if (save) {
    div.find('a').removeClass('selected');
    obj.addClass('selected');
    input.val(val);
  }
}
