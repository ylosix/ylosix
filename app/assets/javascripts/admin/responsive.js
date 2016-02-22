$(document).ready(function(){
    //filter box
    $("#sidebar").before('<div class="view_filter">Ver filtros</div>');
    $(".view_filter").click(function(){
        $("#sidebar").toggle();
    });
    //add footer logo ylos
    $("#footer").html('<div class="logo"></div>');
    //add icon buttons
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
    $(".set_link").attr('title','Predefinido');
    $(".set_link").css({'border-radius':'50%','padding':'8px 9px 11px 9px'});
    $(".set_link").html('<i class="fa fa-star fa-lg"></i>');
    //add menu icons
    $("#dashboard>a").before('<i class="fa fa-dashboard fa-lg" style="color:#fff"></i><br>');
    $("#catalog>a").before('<i class="fa fa-book fa-lg" style="color:#fff"></i><br>');
    $("#administration>a").before('<i class="fa fa-users fa-lg" style="color:#fff"></i><br>');
    $("#locales>a").before('<i class="fa fa-language fa-lg" style="color:#fff"></i><br>');
    $("#preferences>a").before('<i class="fa fa-cogs fa-lg" style="color:#fff"></i><br>');
    $("#design>a").before('<i class="fa fa-pencil-square-o fa-lg" style="color:#fff"></i><br>');
    $("#orders>a").before('<i class="fa fa-shopping-basket fa-lg" style="color:#fff"></i><br>');
    $("#transports>a").before('<i class="fa fa-truck fa-lg" style="color:#fff"></i><br>');
});
