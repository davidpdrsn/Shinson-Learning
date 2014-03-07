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
  config.include Devise::TestHelpers, type: :controller

  config.use_transactional_fixtures = false

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.around(:each, :caching) do |example|
    caching = ActionController::Base.perform_caching
    ActionController::Base.perform_caching = example.metadata[:caching]
    example.run
    ActionController::Base.perform_caching = caching
  end
end
