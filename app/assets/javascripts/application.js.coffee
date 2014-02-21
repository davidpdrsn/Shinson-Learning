//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$ ->
  $('select[name="groupings"]').on "change", ->
    grouping = $(this).val()
    newUrl = window.location.origin + window.location.pathname + "?group_by=" + grouping
    window.location.href = newUrl
