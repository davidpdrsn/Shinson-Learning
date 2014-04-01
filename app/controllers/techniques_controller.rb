class TechniquesController < ApplicationController
  include FindsTechniques

  before_action :authenticate_user!, except: [:show]
  before_action :get_technique, only: [:destroy, :update, :edit]

  def index
    @page_title = "Techniques"
    @default_grouping = default_grouping
    @techniques = current_user.techniques_grouped_by *groupings[params[:group_by]]

    respond_to do |format|
      format.html {}
      format.json do
        render json: current_user.techniques_as_hash
      end
    end
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
    @technique = Technique.find(params[:id])
    @page_title = @technique.name
    @note = @technique.notes.new
    @notes = @technique.notes.reject(&:new_record?)
  end

  def edit
    @page_title = "Edit #{@technique.name}"
  end

  def update
    if @technique.update_attributes(techinque_params)
      flash.notice = "Technique updated"
      redirect_to @technique
    else
      render :edit
    end
  end

  def destroy
    @technique.destroy
    flash.notice = "Technique deleted"
    redirect_to root_path
  end

  private

  def default_grouping
    [:category_name, :belt_pretty_print]
  end

  def groupings
    Hash.new(default_grouping).tap do |hash|
      hash['category-belt'] = [:category_name, :belt_pretty_print]
      hash['belt-category'] = [:belt_pretty_print, :category_name]
    end
  end

  def technique_param_key
    :id
  end

  def techinque_params
    params.require(:technique).permit(:name, :belt_id, :category_id, :description)
  end
end
