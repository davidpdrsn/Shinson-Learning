//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$ ->
  $(document).on "change", 'select[name="groupings"]', domain.setGrouping
  $(document).on 'click', '.toggle-techniques', domain.toggleTechniques
  $(document).on 'click', '.peek__link', domain.peekAtTechnique
