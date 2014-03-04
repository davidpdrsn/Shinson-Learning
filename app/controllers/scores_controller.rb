class ScoresController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def create
    @score = Study.find(params[:study_id]).scores.new score_params
    @score.user = current_user

    respond_to do |format|
      if @score.save
        format.json { render json: @score }
      else
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def score_params
    params.require(:score).permit :correct_answers
  end
end
