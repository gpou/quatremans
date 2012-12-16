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
  $('.vestits a.dropdown-toggle').click(function() {
    var id = $(this).attr('id').substr(5);
    var sel = toggle_subproducte(id);
    if (sel) $('#seleccio_'+id).attr('checked','checked');
    else $('#seleccio_'+id).removeAttr('checked');
    return false;
  });
  $('.vestits input.seleccio').click(function() {
    toggle_subproducte($(this).attr('id').substr(9));
  });
  function toggle_subproducte(id) {
    var div = $('#'+id).find('.subproducte_opcions');
    if (div.css('display')=='block') {
      div.fadeOut();
      $('#dibuix_'+id).fadeOut();
      return false;
    } else {
      div.fadeIn();
      $('#dibuix_'+id).fadeIn();
      return true;
    }
  }
  function desactiva_subproducte(id) {

  }
  $("path[class~='mostra']").bind('mouseover',
    function() {
      var $this = $(this);
      $(".mostres .selected").each(function() {
        var div = $(this).parents('.mostres');
        var input = div.find('input');
        var name = input.attr('name');
        if ($this.attr('class').indexOf(name)>=0) {
          var id = input.val();
          zoom_mostra(id);
        }
      })
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
  var nom = $('#opcio_'+id).attr('title');
  var img = $('#opcio_'+id).find('img').attr('src');
  if (img) $("#zoom").html("<p>"+nom+"</p><img src='"+img+"' />");
  else; // $("#zoom").html("");
}

function canvi_mostra(obj, save, orig) {
  if (save==undefined) save = false;
  if (orig==undefined) orig = false;
  var div = obj.parents('.mostres');
  var input = div.find('input');
  if (orig) {
    var val = input.val();
    var color = div.find('.selected img').attr('alt');
  } else {
    var val = obj.attr('href');
    var color = obj.find('img').attr('alt');
  }
  var name = input.attr('id');
  $("path[class~='"+name+"']").css('fill','#'+color);
  if (save) {
    div.find('a').removeClass('selected');
    obj.addClass('selected');
    input.val(val);
  }
  return (val); 
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
