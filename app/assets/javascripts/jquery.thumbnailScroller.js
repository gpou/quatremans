/*
Thumbnail scroller jQuery plugin
Author: malihu [http://manos.malihu.gr]
Homepage: manos.malihu.gr/jquery-thumbnail-scroller
*/
(function($){  
 $.fn.thumbnailScroller=function(options){  
	var defaults={ //default options
		scrollerType:"hoverPrecise", //values: "hoverPrecise", "hoverAccelerate", "clickButtons"
		scrollerOrientation:"horizontal", //values: "horizontal", "vertical"
		scrollEasing:"easeOutCirc", //easing type
		scrollEasingAmount:800, //value: milliseconds
		acceleration:2, //value: integer
		scrollSpeed:600, //value: milliseconds
		noScrollCenterSpace:0, //value: pixels
		autoScrolling:0, //value: integer
		autoScrollingSpeed:8000, //value: milliseconds
		autoScrollingEasing:"easeInOutQuad", //easing type
		autoScrollingDelay:2500 //value: milliseconds
	};
	var options=$.extend(defaults,options);
  return this.each(function(){ 
		//cache vars
		var $this=$(this);
		var $scrollerContainer=$this.children(".jTscrollerContainer");
		var $scroller=$this.children(".jTscrollerContainer").children(".jTscroller");
		var $scrollerNextButton=$this.children(".jTscrollerNextButton");
		var $scrollerPrevButton=$this.children(".jTscrollerPrevButton");
		//set scroller width
		if(options.scrollerOrientation=="horizontal"){
			$scrollerContainer.css("width",999999); 
			var totalWidth=$scroller.outerWidth(true);
			$scrollerContainer.css("width",totalWidth);
		}else{
			var totalWidth=$scroller.outerWidth(true);
		}
		var totalHeight=$scroller.outerHeight(true); //scroller height
		//do the scrolling
		if(totalWidth>$this.width() || totalHeight>$this.height()){ //needs scrolling		
			var pos;
			var mouseCoords;
			var mouseCoordsY;
			if(options.scrollerType=="hoverAccelerate"){ //type hoverAccelerate
				var animTimer;
				var interval=8;
				$this.hover(function(){ //mouse over
					$this.mousemove(function(e){
						pos=findPos(this);
						mouseCoords=(e.pageX-pos[1]);
						mouseCoordsY=(e.pageY-pos[0]);
					});
					clearInterval(animTimer);
					animTimer = setInterval(Scrolling,interval);
				},function(){  //mouse out
					clearInterval(animTimer);
					$scroller.stop();
				});
			}else if(options.scrollerType=="clickButtons"){
				ClickScrolling();
			}else{ //type hoverPrecise
				pos=findPos(this);
				$this.mousemove(function(e){
					mouseCoords=(e.pageX-pos[1]);
					mouseCoordsY=(e.pageY-pos[0]);
					var mousePercentX=mouseCoords/$this.width(); if(mousePercentX>1){mousePercentX=1;}
					var mousePercentY=mouseCoordsY/$this.height(); if(mousePercentY>1){mousePercentY=1;}
					var destX=Math.round(-((totalWidth-$this.width())*(mousePercentX)));
					var destY=Math.round(-((totalHeight-$this.height())*(mousePercentY)));
					$scroller.stop(true,false).animate({left:destX,top:destY},options.scrollEasingAmount,options.scrollEasing); 
				});
			}
			//auto scrolling
			if(options.autoScrolling>0){
				AutoScrolling();
			}
		} else {
			//no scrolling needed
			$scrollerPrevButton.add($scrollerNextButton).hide(); //hide buttons
		}
		//"hoverAccelerate" scrolling fn
		var scrollerPos;
		var scrollerPosY;
		function Scrolling(){
			if((mouseCoords<$this.width()/2) && ($scroller.position().left>=0)){
				$scroller.stop(true,true).css("left",0); 
			}else if((mouseCoords>$this.width()/2) && ($scroller.position().left<=-(totalWidth-$this.width()))){
				$scroller.stop(true,true).css("left",-(totalWidth-$this.width())); 
			}else{
				if((mouseCoords<=($this.width()/2)-options.noScrollCenterSpace) || (mouseCoords>=($this.width()/2)+options.noScrollCenterSpace)){
					scrollerPos=Math.round(Math.cos((mouseCoords/$this.width())*Math.PI)*(interval+options.acceleration));
					$scroller.stop(true,true).animate({left:"+="+scrollerPos},interval,"linear"); 
				}else{
					$scroller.stop(true,true);
				}
			}
			if((mouseCoordsY<$this.height()/2) && ($scroller.position().top>=0)){
				$scroller.stop(true,true).css("top",0); 
			}else if((mouseCoordsY>$this.height()/2) && ($scroller.position().top<=-(totalHeight-$this.height()))){
				$scroller.stop(true,true).css("top",-(totalHeight-$this.height())); 
			}else{
				if((mouseCoordsY<=($this.height()/2)-options.noScrollCenterSpace) || (mouseCoordsY>=($this.height()/2)+options.noScrollCenterSpace)){
					scrollerPosY=Math.cos((mouseCoordsY/$this.height())*Math.PI)*(interval+options.acceleration);
					$scroller.stop(true,true).animate({top:"+="+scrollerPosY},interval,"linear"); 
				}else{
					$scroller.stop(true,true);
				}
			}
		}
		//auto scrolling fn
		var autoScrollingCount=0;
		function AutoScrolling(){
			$scroller.delay(options.autoScrollingDelay).animate({left:-(totalWidth-$this.width()),top:-(totalHeight-$this.height())},options.autoScrollingSpeed,options.autoScrollingEasing,function(){
				$scroller.animate({left:0,top:0},options.autoScrollingSpeed,options.autoScrollingEasing,function(){
					autoScrollingCount++;
					if(options.autoScrolling>1 && options.autoScrolling!=autoScrollingCount){
						AutoScrolling();
					}
				});
			});
		}
		//click scrolling fn
		function ClickScrolling(){
			$scrollerNextButton.click(function() { return false; });
			$scrollerPrevButton.click(function() { return false; });
			$scrollerNextButton.hover(function(e){ //next button
				e.preventDefault();
				if(options.scrollerOrientation=="horizontal"){
					var posX=$scroller.position().left;
					var diffX=totalWidth+(posX-$this.width());
					var speed = diffX*options.scrollSpeed;
					$scroller.stop().animate({left:$this.width()-totalWidth},speed,options.scrollEasing);
				}
			}, function() {
				$scroller.stop()
			});
			$scrollerPrevButton.hover(function(e){ //previous button
				e.preventDefault();
				if(options.scrollerOrientation=="horizontal"){
					var posX=$scroller.position().left;
					var diffX=-posX
					var speed = diffX*options.scrollSpeed;
					$scroller.stop().animate({left:0},speed,options.scrollEasing);
				}
			}, function() {
				$scroller.stop()
			});
		}
	});  
 };  
})(jQuery); 
//global js functions
//find element Position
function findPos(obj){
	var curleft=curtop=0;
	if (obj.offsetParent){
		curleft=obj.offsetLeft
		curtop=obj.offsetTop
		while(obj=obj.offsetParent){
			curleft+=obj.offsetLeft
			curtop+=obj.offsetTop
		}
	}
	return [curtop,curleft];
}