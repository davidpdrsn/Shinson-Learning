class StudiesController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :new, :create, :show, :study]
  before_filter :get_study, only: [:show, :study]

  def index
    @studies = current_user.studies
  end

  def show
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

  def study
    respond_to do |format|
      format.html {}
      format.json do
        render json: @study.to_json
      end
    end
  end

  private

  def get_study
    @study = current_user.studies.find params[:id]
  end

  def study_params
    params.require(:study).permit :category_id, :belt_id
  end
end
