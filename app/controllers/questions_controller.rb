require 'crud_controller'

class QuestionsController < ApplicationController
  include CrudController

  before_action :authenticate_user!, only: [:index]

  on_index do |action|
    action.entity(:questions) { current_user.questions }
  end
end
