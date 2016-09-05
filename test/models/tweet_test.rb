require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  
  def setup
	@user = users(:preloaded)
	
	@tweet = @user.tweets.build(content: "Hello World!")
  end
  
  test "tweet validity" do
	assert @tweet.valid?
  end
  
  test "user required" do
	@tweet.user_id = nil
	assert_not @tweet.valid?
  end
  
  test "has content" do
	@tweet.content = " "
	assert_not @tweet.valid?
  end
  
  test "tweet max length" do
	@tweet.content = "a" * 141
	assert_not @tweet.valid?
  end
  
  test "tweets ordered by most recent" do
	assert_equal tweets(:five), Tweet.first
  end
  
end
