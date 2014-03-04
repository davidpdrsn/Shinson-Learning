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
      <button class='study__controls__flip' type='button'>Flip</button>

      <div class='study__controls__submit'>
        <button class='study__controls__right' type='button'>Guessed correctly</button>
        <button class='study__controls__wrong'type='button'>Didn't guess correctly</button>
      </div>
    </div>
    "

class Study
  constructor: (study, techniques) ->
    @id = study.id
    @questions = techniques.map (t) -> new Question(t)
    @current_question = @questions[0]
    @score = 0

  play: ->
    @current_question.injectToDom()
    this._bindButtons()

  _bindButtons: ->
    $(document).on 'click', '.study__controls__flip', => this._flip()
    $(document).on 'click', '.study__controls__right', => @score++; this._next()
    $(document).on 'click', '.study__controls__wrong', => this._next()

  _next: ->
    @current_question = @questions[@questions.indexOf(@current_question)+1]
    if @current_question
      @current_question.injectToDom()
    else
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

  _flip: ->
    $(".study__controls__submit").show()
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
