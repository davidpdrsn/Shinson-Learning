class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @page_title = "Questions"
    @questions = current_user.questions
  end
end
