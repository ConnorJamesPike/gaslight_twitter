require 'test_helper'

class FollowingTestTest < ActionDispatch::IntegrationTest
  
  def setup
	@follower = users(:preloaded)
	@followed = users(:bob)
	log_in_as(@follower)
  end
  
  test "follow a user" do
	assert_difference '@follower.following.count', 1 do
		post follows_path, params: { followed_id: @followed.id }
	end
  end
  
  test "unfollow a user" do
	@follower.follow(@followed)
	follow = @follower.active_follows.find_by(followed_id: @followed.id)
	assert_difference '@follower.following.count', -1 do
		delete follow_path(follow)
	end
  end
end
