class NotesController < ApplicationController
  TECHNIQUE_PARAM_KEY = :technique_id

  before_action :authenticate_user!, only: [:create, :destroy, :edit, :update, :index, :new]

  def index
    redirect_to current_user.techniques.find(params[:technique_id])
  end

  def new
    @technique = current_user.techniques.find(params[:technique_id])
    @note = current_user.notes.new
    @note.technique = @technique
  end

  def create
    @technique = current_user.techniques.find(params[:technique_id])
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
    @technique = current_user.techniques.find(params[:technique_id])
    @note = @technique.notes.find(params[:id])
    @page_title = "Edit note for #{@technique.name}"
  end

  def update
    @technique = current_user.techniques.find(params[:technique_id])
    @note = @technique.notes.find(params[:id])

    if @note.update_attributes(note_params)
      redirect_to @technique, notice: "Note updated"
    else
      render :edit
    end
  end

  def destroy
    @technique = current_user.techniques.find(params[:technique_id])
    @note = @technique.notes.find(params[:id])

    @note.destroy
    flash.notice = "Note deleted"
    redirect_to @technique
  end

  private

  def note_params
    params.require(:note).permit(:text, :question)
  end
end
