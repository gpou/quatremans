
(function($){
  window.onload=function(){
    var w = $("#coleccio").width();
    var tw = $("#coleccio .jTscroller").width();
    var offset = (w-tw)/2;
    $("#coleccio .jTscroller").css('left',offset+'px');
    $("#coleccio").thumbnailScroller({
      scrollerType:"hoverAccelerate", 
      scrollerOrientation:"horizontal", 
      scrollSpeed:2, 
      scrollEasing:"easeOutCirc", 
      scrollEasingAmount:600, 
      acceleration:0.1, 
      noScrollCenterSpace:200, 
      autoScrolling:0, 
      autoScrollingSpeed:2000, 
      autoScrollingEasing:"easeInOutQuad", 
      autoScrollingDelay:500 
    });
  }
})(jQuery);
