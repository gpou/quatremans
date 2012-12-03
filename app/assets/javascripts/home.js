
$(document).ready(function() {
  $("#fotos div").data('actual',0);
  //window.setInterval(canvi_foto_centre, 3000);
  //window.setInterval(canvi_foto_esq, 8000);
  //window.setInterval(canvi_foto_dret, 5000);
});

function canvi_foto_esq() {
  canvi_foto('aprendre');
}
function canvi_foto_centre() {
  canvi_foto('models');
}
function canvi_foto_dret() {
  canvi_foto('nina');
}
function canvi_foto(a) {
  var apartat = $("#"+a);
  var actual = apartat.data('actual');
  var seguent = actual + 1;
  if (seguent > apartat.find('img').size()-1) seguent = 0;
  var img_actual = apartat.find('img:eq('+actual+')');
  var img_seguent = apartat.find('img:eq('+seguent+')');
  img_actual.animate({opacity: 0}, 1000);
  img_seguent.animate({opacity: 1}, 1000);
  apartat.data('actual',seguent);
}