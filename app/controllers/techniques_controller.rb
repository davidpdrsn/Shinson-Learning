class TechniquesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :get_technique, only: [:destroy, :update, :edit]

  def index
    @page_title = "My techniques"

    default_grouping = [:category_name, :belt_pretty_print]
    groupings = Hash.new(default_grouping)
    groupings['category-belt'] = [:category_name, :belt_pretty_print]
    groupings['belt-category'] = [:belt_pretty_print, :category_name]

    @techniques = Technique.for_user_grouped_by(current_user, *groupings[params[:group_by]])
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
      flash.alert = "Technique not valid"
      render :new
    end
  end

  def show
    @technique = Technique.find(params[:id])
    @new_note = @technique.notes.new
    @notes = @technique.notes.reject { |note| note.new_record? }

    respond_to do |format|
      format.html {}
      # TODO: should this be tested?
      format.json do
        render json: { technique: @technique, notes: @notes }
      end
    end
  end

  def edit
  end

  def update
    if @technique.update_attributes(techinque_params)
      flash.notice = "Technique updated"
      redirect_to @technique
    else
      flash.alert = "Technique not updated"
      render :edit
    end
  end

  def destroy
    @technique.destroy
    flash.notice = "Technique deleted"
    redirect_to root_path
  end

  private

  def get_technique
    @technique = current_user.techniques.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Technique not found"
    redirect_to root_path
  end

  def techinque_params
    params.require(:technique).permit(:name, :belt_id, :category_id, :description)
  end
end
