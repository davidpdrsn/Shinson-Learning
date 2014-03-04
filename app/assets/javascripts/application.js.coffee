//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require fastclick
//= require domain
//= require_tree .

$ ->
  FastClick.attach document.body

  $(document).on "change", 'select[name="groupings"]', ->
    domain.setGrouping $(this).val()

  $(document).on 'click', '.toggle-techniques', (event) ->
    event.preventDefault()
    domain.toggleTechniques $(this), $(this).parent().siblings('ul')

  $(document).on 'click', '.peek__link--all', (event) ->
    event.preventDefault()
    $list = $(this).next('ul')
    domain.peekAtAllTechniques $list,
                               $(this).parent().find('.toggle-techniques'),
                               $(this).parent().find('.peek__link')

  $(document).on 'click', '.peek__link', (event) ->
    event.preventDefault()
    domain.peekAtTechnique $(this), $(this).parents('li').find('.technique__description')

  $(document).on 'click', '.flash__close', (event) ->
    event.preventDefault()
    domain.closeFlash $(this).parents('.flash')

  $(document).on 'click', '.main-header__toggle-nav', (event) ->
    event.preventDefault()
    domain.toggleNav $('.main-header__nav')

  $(document).on 'click', '.notes__new-button', (event) ->
    event.preventDefault()
    domain.toggleNewNoteForm $('.notes__new-button'), $('.new_note')

  $(document).on('page:fetch', domain.injectSpinner)
  $(document).on('page:receive', domain.removeSpinner)
