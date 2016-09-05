require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
	@tweet = tweets(:one)
  end
  
  test "only logged in can create" do
	assert_no_difference 'Tweet.count' do
		post tweets_path, params: { tweet: { content: "blah blah"} }
	end
  end
  
  test "only logged in can destroy" do
	assert_no_difference 'Tweet.count' do
		delete tweet_path(@tweet)
	end
  end
  
  test "only owner user can destroy" do
	log_in_as(users(:bob))
	tweet = tweets(:one)
	assert_no_difference 'Tweet.count' do
		delete tweet_path(tweet)
	end
  end
  
end
