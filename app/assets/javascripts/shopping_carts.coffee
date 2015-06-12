# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@show_quantity_form = (id) ->
  $('#select-quantity-' + id).hide()
  $('#form-quantity-' + id).removeClass("hidden")

@modify_quantity_form = (id, quantity) ->
  $('#input-quantity-' + id).val(quantity)
  $('#form-quantity-' + id + ' form')[0].submit()
