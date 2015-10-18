# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'sidekiq/testing'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  # Mock
  config.mock_with :rspec

  # Fixtures
  config.use_transactional_fixtures = true

  # Additional helpers
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Requests::JsonHelpers, type: :request)

  # Infer type from location
  config.infer_spec_type_from_file_location!

  config.after(:each) do
    # Clean database
    DatabaseCleaner.clean

    # Fake Sidekiq
    Sidekiq::Testing.fake!
  end
end
