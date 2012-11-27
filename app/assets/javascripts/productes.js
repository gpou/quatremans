

$(document).ready(function() {
  var main_image = $("#main_image").attr('src');
  var on_image = false;
  $(".thumbnails.petit a").hover(
    function() {
      on_image = true;
      $("#main_image").attr('src', $(this).find('img').attr('src'));
    }, 
    function() {
      on_image = false;
      window.setTimeout(function() { 
        if (on_image) return;
        $("#main_image").attr('src', main_image); 
      }, 200);
    }
  );

  $("a[rel=zoom]").fancybox({
    'transitionIn'    : 'none',
    'transitionOut'   : 'none',
    'titlePosition'   : 'over'
  });

  $(".personalitza").click(function() {
    $.fancybox({
      href: $(this).attr('href'),
      type: 'iframe', 
      margin: 0,
      padding: 0,
      width: 770,
      height: '90%',
      titleShow: false,
      autoScale: false,
      modal: false,
      showCloseButton: true,
      autoDimensions : false,
      hideOnOverlayClick: false,
      onComplete: function(){
        isFancy = true;
        $("body").css({'overflow-y':'hidden'});
        $('body').bind("mousewheel", function() { if (isFancy) return false; });
      },
      onClosed: function(){
        isFancy = false;
        $("body").css({'overflow-y':'visible'});
      },
    });
    return false;
  });
})

