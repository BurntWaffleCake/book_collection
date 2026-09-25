ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module SignInAdmin
  extend ActiveSupport::Concern

  included do
    include Devise::Test::IntegrationHelpers

    # All controllers require an authenticated admin (see ApplicationController).
    # Routes are lazy-loaded in Rails 8 and Devise's :admin mapping is registered
    # when routes load, so make sure that has happened before signing in.
    setup do
      Rails.application.try(:reload_routes_unless_loaded)
      sign_in admins(:one)
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include SignInAdmin
  end
end
