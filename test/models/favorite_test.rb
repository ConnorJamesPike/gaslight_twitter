require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  
  def setup
	@favorite = Favorite.new(user_id: users(:preloaded).id, tweet_id: tweets(:one).id)
  end
  
  test "validity" do
	assert @favorite.valid?
  end
  
  test "needs user" do
	@favorite.user_id = nil
	assert_not @favorite.valid?
  end
  
  test "needs tweet" do
	@favorite.tweet_id = nil
	assert_not @favorite.valid?
  end
end
