class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :edit, :update, :index, :new]
  before_action :get_technique, only: [:new, :create, :destroy, :edit, :update, :index]
  before_action :get_note, only: [:edit, :update, :destroy]

  include FindsTechniques

  def index
    redirect_to @technique
  end

  def new
    @note = current_user.notes.new
    @note.technique = @technique
  end

  def create
    @note = @technique.notes.new(note_params)
    @note.user = current_user

    if @note.save
      flash.notice = "Note saved"
      redirect_to @technique
    else
      render :edit
    end
  end

  def edit
    @page_title = "Edit note for #{@technique.name}"
  end

  def update
    if @note.update_attributes(note_params)
      redirect_to @technique, notice: "Note updated"
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    flash.notice = "Note deleted"
    redirect_to @technique
  end

  private

  def get_note
    @note = @technique.notes.find(params[:id])
  end

  def technique_param_key
    :technique_id
  end

  def note_params
    params.require(:note).permit(:text, :question)
  end
end
