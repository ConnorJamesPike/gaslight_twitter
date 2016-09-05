require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  
  def setup
	@follow = Follow.new(follower_id: users(:preloaded).id, followed_id: users(:bob).id)
  end
  
  test "validity" do
	assert @follow.valid?
  end
  
  test "follower required" do
	@follow.follower_id = nil
	assert_not @follow.valid?
  end
  
  test "followed required" do
	@follow.followed_id = nil
	assert_not @follow.valid?
  end
  
end
