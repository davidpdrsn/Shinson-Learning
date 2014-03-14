RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, type: :controller

  config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}
end
