require 'test_helper'

class FavoriteTestTest < ActionDispatch::IntegrationTest
  def setup
	@favoriter = users(:preloaded)
	@favorited = tweets(:seven)
	log_in_as(@favoriter)
  end
  
  test "favorite a tweet" do
	assert_difference '@favoriter.favorite_tweets.count', 1 do
		post favorites_path, params: { tweet_id: @favorited.id }
	end
  end
  
  test "unfavorite a tweet" do
	@favoriter.favorite(@favorited)
	favorite = @favoriter.favorites.find_by(tweet_id: @favorited.id)
	assert_difference '@favoriter.favorite_tweets.count', -1 do
		delete favorite_path(favorite)
	end
  end
end
