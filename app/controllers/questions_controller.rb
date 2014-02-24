class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @questions = current_user.questions
  end
end
