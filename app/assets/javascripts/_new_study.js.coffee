class Technique
  constructor: (id, name) ->
    @id = id
    @name = name

  markup: ->
    "
    <li>
      <a href='#' data-id='#{@id}' data-name='#{@name}'>#{@name}</a>
    </li>
    "

class TechniqueList
  constructor: ->
    @picks = []

  markupFor: (techniques) ->
    if techniques.length > 0
      "<ul>" +
        (techniques.reduce ((acc, technique) ->
          acc += new Technique(technique.id, technique.name).markup()), "") +
      "</ul>"
    else
      "<p>No matches were found...</p>"

  pickTechnique: (linkNode, event) ->
    event.preventDefault()
    this._addPick $(linkNode)

  unpickTechnique: (linkNode, event) ->
    event.preventDefault()
    this._removePick $(linkNode)
    if this._picksListEmpty() then this._handlePicksListEmpty()

  _$picks: -> $('.new-study__picks')
  _$picksList: -> this._$picks().find('ul')
  _$results: -> $(".new-study__results")

  _picksListEmpty: ->
    this._$picksList().find('li').length == 0

  _removePick: ($linkNode) ->
    this._$results()
      .find("[data-id=#{$linkNode.data 'id'}]")
      .removeClass('new-study__picked-link')

    $linkNode.parents('li').remove()

  _addPick: ($linkNode) ->
    $linkNode.addClass 'new-study__picked-link'
    if this._$picksList().length == 0
      this._$picks().append "<ul></ul>"
      this._$picks().find('p').hide()

    unless this._picksListContains $linkNode
      this._$picksList()
        .append new Technique($linkNode.data('id'), $linkNode.data('name')).markup()

  _picksListContains: ($linkNode) ->
    this._$picksList().find("[data-id=#{$linkNode.data('id')}]").length > 0

  _handlePicksListEmpty: ->
    this._$picksList().remove()
    this._$picks().find('p').show()

$(window).on "load page:load", ->
  techniqueList = new TechniqueList()

  $(document).on "sayt:fetch:starting", -> domain.injectSpinner()
  $(document).on "sayt:fetch:complete", -> domain.removeSpinner()

  $(".new-study__query").sayt
    url: "/searches"
    requestType: "POST"
    keyboard: true
    minLength: 0
    searchOnFocus: true
    selectionClass: 'new-study__selection'
    contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    markup: (techniques) ->
      techniqueList.markupFor(techniques)
    enterPressedHandler: (selection, event) ->
      techniqueList.pickTechnique selection, event
    containerClass: 'new-study__results__content'

  $(document).on 'click', '.new-study__results a', (event) ->
    techniqueList.pickTechnique this, event

  $(document).on 'click', '.new-study__picks a', (event) ->
    techniqueList.unpickTechnique this, event

  $(document).delegate '.new-study__add-all', 'click', (event) ->
    event.preventDefault()
    $('.new-study__results a[data-id]').each -> $(this).click()

  $(document).on 'sayt:results:injected', ->
    $('.new-study__picks a').each ->
      id = $(this).data 'id'
      $('.new-study__results').find("[data-id=#{id}]").addClass "new-study__picked-link"


  $(document).on 'submit', ".new-study form", (event) ->
    ids = $('.new-study__picks').find('ul li a').toArray().reduce ((acc, link) ->
      acc.push $(link).data("id")
      acc
    ), []

    $(this).append "<input type='hidden'
                           name='study[technique_ids]'
                           value='#{ids}'>"
