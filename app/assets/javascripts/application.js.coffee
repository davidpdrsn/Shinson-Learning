//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require fastclick
//= require raphael/raphael
//= require morris.js/morris.js
//= require moment/moment.js
//= require jquery-ui/ui/jquery.ui.core
//= require jquery-ui/ui/jquery.ui.widget
//= require jquery.sayt/jquery.sayt
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

  $(document).on 'click', '.main-header__toggle-nav', (event) ->
    event.preventDefault()
    domain.toggleNav $('.main-header__nav')

  $(document).on('page:fetch', domain.injectSpinner)
  $(document).on('page:receive', domain.removeSpinner)

  $(document).on 'click', '.create-multiple__buttons button', ->
    $form = $(this).parents(".create-multiple")
    $fieldset = $form.find("fieldset").last()
    lastFieldSet = -> $form.find("fieldset").last()

    domain.newTechniqueFieldset $form, $fieldset, lastFieldSet

  $(document).on 'click', '.create-multiple__remove-fieldset', ->
    domain.removeFieldset $(this).parents("fieldset")

  $(document).on 'submit', 'form.create-multiple', domain.validateBulkTechniqueForm
