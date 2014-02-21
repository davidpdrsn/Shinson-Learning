require 'grouper'

class TechniquesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :edit, :update, :destroy, :new]
  before_action :get_technique, only: [:destroy, :update, :edit]

  def index
    grouper = Grouper.new(current_user.techniques)

    default_grouping = [:category_name, :belt_pretty_print]
    groupings = Hash.new(default_grouping)
    groupings['category-belt'] = [:category_name, :belt_pretty_print]
    groupings['belt-category'] = [:belt_pretty_print, :category_name]

    @techniques = grouper.group_by(*groupings[params[:group_by]])
  end

  def new
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
