//= require active_admin/base
//= require jquery.ui.tabs

function serializeFotos(){
  var fotosIds = $.makeArray(
    $(".index_as_block .handler").map(function(){
      return $(this).data("id");
    })
  );
  return {ids: fotosIds};
};

$(".foto").sortable({
  update: function(){
    $.ajax({
      url: "/admin/fotos/sort",
      handle: '.handler',
      type: 'post',
      data: serializeFotos(),
      complete: function(){
        $(".paginated_collection").effect("highlight");
      }
    });
  }
});