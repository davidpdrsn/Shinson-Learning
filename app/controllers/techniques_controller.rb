class TechniquesController < ApplicationController
  DEFAULT_GROUPING = [:category_name, :belt_pretty_print]
  TECHNIQUE_PARAM_KEY = :id

  before_action :authenticate_user!

  def index
    techniques = current_user.techniques_grouped_by *groupings[params[:group_by]]
    @page = TechniquesIndexPage.new(techniques: techniques, default_grouping: DEFAULT_GROUPING)
    @page_title = "Techniques"
  end

  def new
    @page_title = "New technique"
    @technique = current_user.techniques.new
  end

  def create
    @technique = current_user.techniques.new(techinque_params)

    if @technique.save
      flash.notice = "Technique saved"
      redirect_to @technique
    else
      render :new
    end
  end

  def show
    @technique = current_user.techniques.find(params[:id])
    @notes = @technique.notes
    @technique_cache = TechniqueCache.new @technique

    @page_title = @technique.name

    respond_to do |format|
      format.html
      format.json { render json: @technique }
    end
  end

  def edit
    @technique = current_user.techniques.find(params[:id])
    @page_title = "Edit \"#{@technique.name}\""
  end

  def update
    @technique = current_user.techniques.find(params[:id])

    respond_to do |format|
      if @technique.update_attributes(techinque_params)
        format.html do
          flash.notice = "Technique updated"
          redirect_to @technique
        end

        format.json { render json: @technique }
      else
        format.html { render action: :edit }
        format.json { render nothing: true }
      end
    end
  end

  def destroy
    @technique = current_user.techniques.find(params[:id])

    @technique.destroy
    flash.notice = "Technique deleted"
    redirect_to root_path
  end

  def new_multiple
    @page_title = "Add multiple techniques"
  end

  def create_multiple
    # TODO: extract two lines into one method call
    technique_attributes = Zipper.new(params[:techniques]).zip
    invalid_techniques = CreatesTechniquesInBulk.new(technique_attributes).create_for_user current_user

    if invalid_techniques.blank?
      flash.notice = "Techniques saved"
      redirect_to techniques_path
    else
      flash.alert = "One of the techniques were invalid"
      redirect_to multiple_new_techniques_path
    end
  end

  private

  def groupings
    # TODO: don't use tap
    Hash.new(DEFAULT_GROUPING).tap do |hash|
      hash['category-belt'] = [:category_name, :belt_pretty_print]
      hash['belt-category'] = [:belt_pretty_print, :category_name]
    end
  end

  def techinque_params
    params.require(:technique).permit(:name, :belt_id, :category_id, :description)
  end
end
