class Technique
  constructor: (id, name) ->
    @id = id
    @name = name

  choiceMarkup: ->
    "
    <li>
      <a href='#' data-id='#{@id}' data-name='#{@name}'>#{@id} | #{@name}</a>
    </li>
    "

  pickMarkup: ->
    "
    <li>
      <a href='#' data-id='#{@id}' data-name='#{@name}'>#{@id} | #{@name}</a>
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

  _picksListEmpty: ->
    this._$picksList().find('li').length == 0

  _removePick: ($linkNode) ->
    $linkNode.parents('li').remove()

  _addPick: ($linkNode) ->
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
    markup: (techniques) ->
      techniqueList.markupFor(techniques)
    enterPressedHandler: (selection, event) ->
      techniqueList.pickTechnique selection, event
    containerClass: 'new-study__results'

  $(document).on 'click', '.new-study__results a', (event) ->
    techniqueList.pickTechnique this, event

  $(document).on 'click', '.new-study__picks a', (event) ->
    techniqueList.unpickTechnique this, event

  $(document).on 'submit', ".new-study form", (event) ->
    $('.new-study__picks').find('ul li a').toArray().forEach (link) =>
      $(this).append "<input type='hidden'
                             multiple='multiple'
                             name='study[technique_ids][]'
                             value='#{$(link).data 'id'}'>"
