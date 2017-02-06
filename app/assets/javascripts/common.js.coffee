$(document).ready ->

  $('#tabs a').click (e) ->
    $(this).tab('show')
  # переключаемся на вкладку общие
  $('#tabs a[href="#base"]').tab('show')


  $('.form-horizontal select').chosen()