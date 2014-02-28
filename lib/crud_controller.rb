module CrudController; end

class CrudController::Action
  attr_accessor :notice, :alert
  attr_reader :name, :entities

  def initialize name
    @name = name
    @entities = []
    @success_handler = Proc.new {}
    @fail_handler = Proc.new {}
    @always_handler = Proc.new {}
  end

  [
    :success,
    :fail,
    :always
  ].each do |m|
    instance_variable_name = "@#{m}_handler"
    attr_reader instance_variable_name.delete "@"
    define_method m do |&block|
      instance_variable_set instance_variable_name, block
    end
  end

  def entity name, options = { main: false }, &block
    @entities << {
      name: name,
      main: options[:main],
      entity: Proc.new do
        value = instance_eval &block
        instance_variable_set "@#{name}", value
      end
    }
  end

  def set_entities_on controller
    @entities.each do |hash|
      controller.instance_eval &hash[:entity]
    end
  end

  def main_entity_name
    main_entity.fetch :name
  end

  private

  def main_entity
    @entities.detect { |hash| hash[:main] }
  end
end

class CrudController::ActionList < Array
  def get name
    self.detect { |action| action.name == name }
  end
end

module CrudController
  def self.define_action name, options
    options.fetch(:on).define_singleton_method(:"on_#{name}") do |&block|
      @@actions ||= ActionList.new
      action = Action.new name
      block.call action
      yield action if block_given?
      @@actions << action
    end
  end

  def self.included includer
    @@actions = ActionList.new

    define_action :index, on: includer do |action|
      action.entity(:page_title) { action.main_entity_name.to_s.titleize }
    end

    define_action :new, on: includer do |action|
      action.entity(:page_title) { "New #{action.main_entity_name.to_s.titleize}" }
    end

    define_action :create, on: includer do |action|
      action.notice ||= "#{action.main_entity_name.to_s.titleize} saved"
      action.alert ||= "#{action.main_entity_name.to_s.titleize} not saved"
    end

    define_action :edit, on: includer

    define_action :update, on: includer do |action|
      action.notice ||= "#{action.main_entity_name.to_s.titleize} updated"
      action.alert ||= "#{action.main_entity_name.to_s.titleize} not updated"
    end

    define_action :destroy, on: includer do |action|
      action.notice ||= "#{action.main_entity_name.to_s.titleize} deleted"
    end
  end

  def index
    action = @@actions.get :index
    action.set_entities_on self

    instance_eval &action.always_handler
  end

  def new
    action = @@actions.get :new
    action.set_entities_on self

    instance_eval &action.always_handler
  end

  def create
    action = @@actions.get :create
    action.set_entities_on self

    if instance_variable_get("@#{action.main_entity_name}").save
      flash.notice = action.notice
      instance_eval &action.success_handler
    else
      flash.alert = action.alert
      instance_eval &action.fail_handler
    end

    instance_eval &action.always_handler
  end

  def edit
    action = @@actions.get :edit
    action.set_entities_on self

    instance_eval &action.always_handler
  end

  def update
    action = @@actions.get :update
    action.set_entities_on self

    if instance_variable_get("@#{action.main_entity_name}").update note_params
      flash.notice = action.notice
      instance_eval &action.success_handler
    else
      flash.alert = action.alert
      instance_eval &action.fail_handler
    end

    instance_eval &action.always_handler
  end

  def destroy
    action = @@actions.get :destroy
    action.set_entities_on self

    instance_variable_get("@#{action.main_entity_name}").destroy
    flash.notice = action.notice
    instance_eval &action.always_handler
  end
end
