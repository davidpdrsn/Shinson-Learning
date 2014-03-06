class Question
  constructor: (technique) ->
    @id = technique.id
    @answer = technique.description
    @question = technique.name

  injectToDom: ->
    $('.study-container')
      .html("")
      .append(this._markup())

  _markup: -> "
    <div class='study__card'>
      <div class='study__card__front'>
        <div class='study__card__label'>Question</div>
        #{@question}
      </div>

      <div class='study__card__back'>
        <div class='study__card__label'>Answer</div>
        #{@answer}
      </div>
    </div>

    <div class='study__controls'>
      <div class='study__controls__submit'>
        <button class='study__controls__right' type='button'>Guessed correctly</button>
        <button class='study__controls__wrong'type='button'>Didn't guess correctly</button>
      </div>

      <button class='study__controls__flip' type='button'>Flip</button>
    </div>
    "

class Study
  constructor: (study, techniques) ->
    @id = study.id
    @questions = techniques.map (t) -> new Question(t)
    @current_question = @questions[0]
    @score = 0
    @progress = 0

  play: ->
    this._initProgress()
    @current_question.injectToDom()
    this._bindButtons()

  _initProgress: () ->
    $(".study-progress").append("<span class='study-progress__tile'></span>")
    this._setProgressWidth()

  _progressPercentage: ->
     @progress/@questions.length * 100

  _setProgressWidth: ->
    console.log "setting width"
    el = $(".study-progress__tile")
    el.css width: "#{this._progressPercentage()}%"

  _bindButtons: ->
    $(document).on 'click', '.study__controls__flip', => this._flip()
    $(document).on 'click', '.study__controls__right', => @score++; this._next()
    $(document).on 'click', '.study__controls__wrong', => this._next()

  _next: ->
    @current_question = @questions[@questions.indexOf(@current_question)+1]
    @progress++
    this._setProgressWidth()
    if @current_question
      @current_question.injectToDom()
    else
      durationOfProgressAnimation = 500
      setTimeout((=>
        $.ajax({
          url: "/studies/#{@id}/scores",
          type: "POST",
          data: {
            study_id: @id,
            score: {
              correct_answers: @score
            }
          }
        }).done =>
          Turbolinks.visit "/studies/#{@id}"
      ), durationOfProgressAnimation)

  _flip: ->
    $(".study__controls__submit").addClass "show"
    $(".study__card").toggleClass "study__card--flipped"

$(window).on "load page:load", ->
  if /\/studies\/\d+\/study/.test window.location.pathname
    domain.injectSpinner()
    $.ajax({
      url: window.location.pathname,
      type: "GET",
      dataType: "JSON"
    }).done (json) ->
      domain.removeSpinner()
      study = new Study(json.study, json.techniques)
      study.play()

  if $('#scores_chart').length > 0
    Morris.Line
      element: 'scores_chart'
      data: $("#scores_chart").data("scores")
      xkey: 'created_at'
      ykeys: ['correct_answers']
      labels: ['Correct answers']
      xLabels: 'day'
      smooth: false
      hideHover: false
      ymin: 0
      ymax: $("#scores_chart").data("max-score")
      dateFormat: (x) -> moment(x).format("MMM Do YYYY")
      xLabelFormat: (x) -> moment(x).format("DD-MM-YYYY")
      yLabelFormat: (y) -> if Math.round(y) == y
                             y
                           else
                             ""
