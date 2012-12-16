(function($){
  $(document).ready(function() {
    $(".jTscroller area").hover(
      function() {
        $("#"+$(this).attr("id")+"_linia").css('opacity',1);
        $("#"+$(this).attr("id")+"_nom").show();
      }, function() {
        $("#"+$(this).attr("id")+"_linia").css('opacity',0);
        $("#"+$(this).attr("id")+"_nom").hide();
      }
    );
  })

  window.onload=function(){
    $(".jTscroller .svg-path, .jTscroller path");
    $("#coleccio").thumbnailScroller({
      scrollerType:"clickButtons", 
      scrollerOrientation:"horizontal", 
      scrollEasing:"linear", 
      scrollEasingAmount:600, 
      acceleration:1, 
      scrollSpeed:2, 
      noScrollCenterSpace:10, 
      autoScrolling:0, 
      autoScrollingSpeed:5000, 
      autoScrollingEasing:"easeInOutQuad", 
      autoScrollingDelay:500 
    });
  }
})(jQuery);
