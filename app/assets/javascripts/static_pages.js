$('.smoothscroll').live('click', function(e){
  var el = $(this).attr('href');
  $('html,body').animate({scrollTop: $(el).offset().top},'slow');
  e.preventDefault();
  return false;
});