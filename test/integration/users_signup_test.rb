require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup" do
	get signup_path
	assert_no_difference 'User.count' do
		post users_path, params: { user: { username: "", email: "", password: "", password_confirmation: ""} }
	end
  end
  
  test "valid signup" do
	get signup_path
	assert_difference('User.count') do
		post users_path, params: { user: { username: "MadeUpUser",
											email: "fake@foo.com", 
											password: "Bl@hblah", 
											password_confirmation: "Bl@hblah" } }
	end
	follow_redirect!
	assert logged_in?
  end
  
end
