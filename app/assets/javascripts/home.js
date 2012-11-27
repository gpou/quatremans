
$(document).ready(function() {
  var apartat = "";
  $("#area_aprendre").hover(
    function() {
      if (apartat!="") return;
      apartat = "#aprendre";
      canvi_foto();
    },
    function() {
      apartat = "";
    }
  )
  function canvi_foto() {
    if (apartat=='') return;
    var actual = $(apartat).find('.activa');
    var seguent = actual.next();
    if (seguent.length==0) seguent = $(apartat).find('img').first();
    actual.addClass('anterior').removeClass('activa');
    seguent.css('opacity',0).addClass('seguent');
    seguent.animate(
      {opacity: 1},
      800,
      function() {
        actual.removeClass('anterior');
        seguent.addClass('activa').removeClass('seguent')
      }
    );
    window.setTimeout(canvi_foto, 4000);
  }

})