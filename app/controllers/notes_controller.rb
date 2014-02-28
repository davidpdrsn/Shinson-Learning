require 'crud_controller'

class NotesController < ApplicationController
  include CrudController

  before_action :authenticate_user!, only: [:create, :destroy, :edit, :update]
  before_action :get_technique, only: [:create, :destroy, :edit, :update]
  before_action :get_note, only: [:edit, :update, :destroy]

  on_create do |action|
    action.always { redirect_to @technique }

    action.entity :note, main: true do
      @technique.notes.new(note_params).tap { |note| note.user = current_user }
    end
  end

  on_edit do |action|
    action.entity(:page_title) { "Edit note for #{@technique.name}" }
  end

  on_update do |action|
    action.always { redirect_to @technique }
    action.entity(:note, main: true) { @note }
  end

  on_destroy do |action|
    action.always { redirect_to @technique }
    action.entity(:note, main: true) { @note }
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
