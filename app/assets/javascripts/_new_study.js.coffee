class Technique
  constructor: (id, name) ->
    @id = id
    @name = name

  choiceMarkup: ->
    "
    <li>
      <a href='#' data-id='#{@id}' data-name='#{@name}'>#{@name}</a>
    </li>
    "

  pickMarkup: ->
    "
    <li>
      <a href='#' data-id='#{@id}' data-name='#{@name}'>#{@name}</a>
    </li>
    "

class TechniqueList
  constructor: ->
    @picks = []

  markupFor: (techniques) ->
    (techniques.reduce ((acc, technique) ->
      acc += new Technique(technique.id, technique.name).choiceMarkup()), "<ul>") + "</ul>"

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
        .append new Technique($linkNode.data('id'), $linkNode.data('name')).pickMarkup()

  _picksListContains: ($linkNode) ->
    this._$picksList().find("[data-id=#{$linkNode.data('id')}]").length > 0

  _handlePicksListEmpty: ->
    this._$picksList().remove()
    this._$picks().find('p').show()

$(window).on "load page:load", ->
  techniqueList = new TechniqueList()

  $(".new-study__query").sayt
    url: "/techniques"
    keyboard: true
    minLength: 1
    selectionClass: 'new-study__selection'
    markup: (techniques) ->
      "<h2>Matching techniques</h2> #{techniqueList.markupFor(techniques)}"
    enterPressedHandler: (selection, event) ->
      techniqueList.pickTechnique selection, event
    containerClass: 'new-study__results'

  $(document).on 'click', '.new-study__results a', (event) ->
    techniqueList.pickTechnique this, event

  $(document).on 'click', '.new-study__picks a', (event) ->
    techniqueList.unpickTechnique this, event

  $(document).on 'sayt:results:injected', ->
    $('.new-study__picks a').each ->
      id = $(this).data 'id'
      $('.new-study__results').find("[data-id=#{id}]").addClass "new-study__picked-link"

  $(document).on 'submit', ".new-study form", (event) ->
    $('.new-study__picks').find('ul li a').toArray().forEach (link) =>
      $(this).append "<input type='hidden'
                             multiple
                             name='study[technique_ids][]'
                             value='#{$(link).data 'id'}'>"
