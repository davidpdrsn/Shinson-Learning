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

  _$picks: -> $('.picked-techniques')

  _$picksList: -> $('.picked-techniques').find('ul')

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

$(window).on "load page:fetch", ->
  $(document).on "sayt:fetch:starting", -> domain.injectSpinner()
  $(document).on "sayt:fetch:complete", -> domain.removeSpinner()

  techniqueList = new TechniqueList()

  $("#study-search-query").sayt
    url: "/techniques"
    minLength: 1
    markup: (techniques) -> techniqueList.markupFor(techniques)
    enterPressedHandler: techniqueList.pickTechnique

  $(document).on 'click', '.ajax-results a', (event) ->
    techniqueList.pickTechnique this, event

  $(document).on 'click', '.picked-techniques a', (event) ->
    techniqueList.unpickTechnique this, event

  $(document).on 'submit', "form#new_study", (event) ->
    techniqueIds = $('.picked-techniques').find('ul li a').toArray().reduce ((acc, li) ->
      acc.push $(li).data 'id'
      acc), []

    techniqueIds.forEach (id) =>
      $(this).append "<input type='hidden' multiple='multiple' name='study[technique_ids][]' value='#{id}'>"
