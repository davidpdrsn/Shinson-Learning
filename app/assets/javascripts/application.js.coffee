//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require fastclick
//= require_tree .

$ ->
  FastClick.attach document.body

  $(document).on "change", 'select[name="groupings"]', domain.setGrouping

  [
    { element: '.toggle-techniques', callback: domain.toggleTechniques },
    { element: '.peek__link', callback: domain.peekAtTechnique },
    { element: '.flash__close', callback: domain.closeFlash },
    { element: '.notes__new-button', callback: domain.toggleNewNoteForm }
  ].forEach (x) ->
    $(document).on 'click', x.element, x.callback
