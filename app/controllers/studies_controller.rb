class StudiesController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :new, :create, :show]

  def index
    @studies = current_user.studies
  end

  def show
    @study = current_user.studies.find params[:id]
  end

  def new
    @study = current_user.studies.new
  end

  def create
    @study = current_user.studies.new study_params

    if @study.save
      redirect_to @study, notice: "Study created"
    else
      render :new, alert: "Something went wrong"
    end
  end

  private

  def study_params
    params.require(:study).permit :category_id, :belt_id
  end
end
