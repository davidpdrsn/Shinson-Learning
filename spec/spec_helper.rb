require 'simplecov'
if ENV["COVERAGE"]
  SimpleCov.start do
    add_group 'Models', '/app/models/'
    add_group 'Controllers', '/app/controllers/'
    add_group 'Views', '/app/views/'
    add_group 'Libraries', '/lib/'

    project_name 'Shinson Learning'
  end
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
Capybara.javascript_driver = :webkit

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.full_backtrace = true
    config.formatter = 'doc' if config.formatters.none?
  end

  config.infer_base_class_for_anonymous_controllers = false

  config.order = :random

  config.profile_examples = 10
end
