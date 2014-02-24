class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :edit, :update]
  before_action :get_technique, only: [:create, :destroy, :edit, :update]
  before_action :get_note, only: [:edit, :update, :destroy]

  def create
    @note = @technique.notes.new(note_params)
    @note.user = current_user

    if @note.save
      flash.notice = "Note saved"
    else
      flash.alert = "Note not saved"
    end

    redirect_to @technique
  end

  def edit
  end

  def update
    if @note.update_attributes(note_params)
      redirect_to @technique, notice: "Note updated"
    else
      redirect_to @technique, alert: "Note not updated"
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

  def get_technique
    @technique = current_user.techniques.find(params[:technique_id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Technique not found"
    redirect_to root_path
  end

  def note_params
    params.require(:note).permit(:text, :question)
  end
end
