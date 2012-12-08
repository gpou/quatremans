$(document).ready(function() {
  $('.mostres a').hover(
    function() { 
      var id = canvi_mostra($(this), false);
      zoom_mostra(id);
    }, 
    function() { 
      canvi_mostra($(this), false, true); 
      zoom_mostra();
    }
  );
  $("path[class~='mostra']").bind('mouseover',
    function() {
      zoom_mostra($(this).css('fill'));
    }
  );
  $("path[class~='mostra']").bind('mouseout',
    function() {
      zoom_mostra();
    }
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

function zoom_mostra(id) {
  var img = $(id).find('image').attr('alt');
  var nom = $(id).find('image').attr('title');
  if (img) $("#zoom").html("<p>"+nom+"</p><img src='"+img+"' />");
  else; //$("#zoom").html("");
}

function canvi_mostra(obj, save, orig) {
  if (save==undefined) save = false;
  if (orig==undefined) orig = false;
  var div = obj.parents('.mostres');
  var input = div.find('input');
  if (orig) var val = input.val();
  else var val = obj.attr('href');
  var name = input.attr('name');
  $("path[class~='"+name+"']").css('fill','url(#mostra_'+val+')');
  if (save) {
    div.find('a').removeClass('selected');
    obj.addClass('selected');
    input.val(val);
  }
  return ('#mostra_'+val); 
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
