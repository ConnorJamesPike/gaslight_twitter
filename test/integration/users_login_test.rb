require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
	@user = users(:preloaded)
  end
  
  test "invalid login attempt" do
	get login_path
	post login_path, params: { session: { username: "", password: "" } }
	assert_not logged_in?
  end
  
  test "valid login attempt" do
	get login_path
	post login_path, params: { session: { username: @user.username, password: 'P@ssWord'} }
	follow_redirect!
	assert logged_in?
  end
  
  test "login then logout" do
  	get login_path
	post login_path, params: { session: { username: @user.username, password: 'P@ssWord'} }
	follow_redirect!
	assert logged_in?
	delete logout_path
	assert_not logged_in?
  end
  
end
