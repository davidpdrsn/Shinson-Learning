class StudiesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!, only: [:index, :new, :create,
                                            :show, :study, :destroy]
  before_filter :get_study, only: [:show, :study, :destroy]

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

    techniques = (params[:study][:technique_ids] || "").split(",").map(&:to_i).inject([]) do |acc, id|
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

  def destroy
    @study.destroy

    redirect_to studies_path, notice: "Study deleted"
  end

  private

  def get_study
    @study = current_user.studies.find params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Study not found"
  end

  def study_params
    params.require(:study).permit :name
  end
end
