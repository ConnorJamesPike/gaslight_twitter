ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  def log_in_as(user)
	session[:user_id] = user.id
  end

  def logged_in?
	!session[:user_id].nil?
  end
end

class ActionDispatch::IntegrationTest
	def log_in_as(user, password: 'P@ssWord')
		post login_path, params: { session: { username: user.username, password: password} }
	end
end
