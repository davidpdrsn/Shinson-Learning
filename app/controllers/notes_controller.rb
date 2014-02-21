class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :get_technique, only: [:create, :destroy]

  def create
    @note = @technique.notes.new(note_params)
    @note.user = current_user

    if @note.save
      flash.notice = "Note saved"
      redirect_to @technique
    else
      flash.alert = "Note not saved"
      redirect_to @technique
    end
  end

  def destroy
    @note = @technique.notes.find(params[:id])
    @note.destroy
    flash.notice = "Note deleted"
    redirect_to @technique
  end

  private

  def get_technique
    @technique = current_user.techniques.find(params[:technique_id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Technique not found"
    redirect_to root_path
  end

  def note_params
    params.require(:note).permit(:text)
  end
end
