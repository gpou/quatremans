(function($){
  var mascara = null;
  var links = null;
  $(document).ready(function() {
    $(".jTscroller a").hover(
      function(e) {
        e.preventDefault();
        mascara.stop().animate({opacity:0.4});
        links.stop().animate({opacity:1});
      },
      function(e) { e.preventDefault(); }
    );
    $("svg#mascares g#formes path").bind('mouseover',
      function(e) {
        mascara = $("#"+$(this).attr("id")+"_mascara");
        mascara.stop().animate({opacity:0.4});
        links = $("#"+$(this).attr("id")+"_links");
        links.stop().animate({opacity:1});
      }
    );
    $("svg#mascares g#formes path").bind('mouseout',
      function(e) {
        mascara.stop().animate({opacity:0});
        links.stop().animate({opacity:0});
      }
    );
    $("svg#mascares g#formes path").bind('click',
      function(e) {
        links.trigger('click');
      }
    );
  })

  window.onload=function(){
    $("#coleccio").thumbnailScroller({
      scrollerType:"hoverAccelerate", 
      scrollerOrientation:"horizontal", 
      scrollSpeed:4, 
      scrollEasing:"easeOutCirc", 
      scrollEasingAmount:600, 
      acceleration:30, 
      noScrollCenterSpace:250, 
      autoScrolling:0, 
      autoScrollingSpeed:2000, 
      autoScrollingEasing:"easeInOutQuad", 
      autoScrollingDelay:500 
    });
  }
})(jQuery);
