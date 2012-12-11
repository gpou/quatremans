(function($){
  $(document).ready(function() {
    $(".jTscroller area").hover(
      function() {
        $("#"+$(this).attr("id")+"_linia").css('opacity',1);
        $("#"+$(this).attr("id")+"_nom").css('opacity',1);
      }, function() {
        $("#"+$(this).attr("id")+"_linia").css('opacity',0);
        $("#"+$(this).attr("id")+"_nom").css('opacity',0);
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
