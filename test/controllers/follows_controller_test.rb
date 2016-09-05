require 'test_helper'

class FollowsControllerTest < ActionDispatch::IntegrationTest
  
  test "attempted follower needs to be logged in" do
	assert_no_difference 'Follow.count' do
		post follows_path
	end
  end
  
  test "deleting follow needs to be logged in" do
	assert_no_difference 'Follow.count' do
		delete follow_path(follows(:one))
	end
  end
  
  test "only owner user can destroy" do
	log_in_as(users(:preloaded))
	follow = follows(:one)
	assert_no_difference 'Follow.count' do
		delete follow_path(follow)
	end
  end
  
  test "owner can destroy" do
	log_in_as(users(:bob))
	follow = follows(:one)
	assert_difference 'Follow.count', -1 do
		delete follow_path(follow)
	end
  end
  
end
