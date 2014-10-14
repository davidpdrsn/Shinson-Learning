class StudiesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!, only: [:index, :new, :create, :update,
                                            :show, :study, :destroy, :edit]
  before_filter :get_study, only: [:show, :study, :destroy, :edit, :update]

  def index
    @page_title = "Studies"
    @studies = current_user.sorted_studies
  end

  def show
    @page_title = @study.name
  end

  def new
    @page_title = "New study"
    @study = current_user.studies.new
  end

  def create
    @study = current_user.studies.new study_params

    @study.techniques = Technique.where(id: technique_ids)
    if @study.save
      flash.notice = "Study created"
      redirect_to @study
    else
      render :new
    end
  end

  def edit
    @page_title = "Edit \"#{@study.name}\""
  end

  def update
    if @study.update_attributes study_params
      redirect_to @study, notice: "Study updated"
    else
      render :edit
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

  def technique_ids
    (params[:study][:technique_ids] || "").split(",").map(&:to_i)
  end

  def get_study
    @study = current_user.studies.find params[:id]
    @study_cache = StudyCache.new(@study)
  end

  def study_params
    params.require(:study).permit :name
  end
end
