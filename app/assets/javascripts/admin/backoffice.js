$(document).ready(function(){
    $("#sidebar").before('<div class="view_filter">Ver filtros</div>');
    $(".view_filter").click(function(){
        $("#sidebar").toggle();
    });
    $("#footer").html('<img style="width:80px" src="/assets/ylosix_logo.svg"/><br>Version 1.0');
    $(".yes").css({'border-radius':'50%' , 'padding':'6px 4px 6px 5px'});
    $(".yes").html('<i class="fa fa-check fa-lg"></i>');
    $(".no").css({'border-radius':'50%' , 'padding':'6px 6px 7px 7px'});
    $(".no").html('<i class="fa fa-times fa-lg"></i>');
    $(".view_link").attr('title','Ver');
    $(".view_link").css({'border-radius':'50%','padding':'7px 8px 9px 9px'});
    $(".view_link").html('<i class="fa fa-file-text-o fa-lg"></i>');
    $(".edit_link").attr('title','Editar');
    $(".edit_link").css({'border-radius':'50%','padding':'8px 7px 9px 9px'});
    $(".edit_link").html('<i class="fa fa-pencil-square-o fa-lg"></i>');
    $(".delete_link").attr('title','Eliminar');
    $(".delete_link").css({'border-radius':'50%','padding':'8px 9px 9px 10px'});
    $(".delete_link").html('<i class="fa fa-trash-o fa-lg"></i>');
    $(".clone_link").attr('title','Clonar');
    $(".clone_link").css({'border-radius':'50%','padding':'8px 9px 11px 9px'});
    $(".clone_link").html('<i class="fa fa-copy fa-lg"></i>');

});