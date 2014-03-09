class StudiesController < ApplicationController
  respond_to :html, :json

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

    # TODO: move this into the model
    techniques = (params[:study][:technique_ids] || []).map(&:to_i).inject([]) do |acc, id|
      acc << Technique.find(id)
    end

    @study.techniques = techniques
    if @study.save
      flash.notice = "Study created"
      redirect_to @study
    else
      render :new
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
    params.require(:study).permit :name
  end
end
