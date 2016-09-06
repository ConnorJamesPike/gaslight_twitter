require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  
  test "attempted favoriter needs to be logged in" do
	assert_no_difference 'Favorite.count' do
		post favorites_path
	end
  end
  
  test "deleting favorite needs to be logged in" do
	assert_no_difference 'Favorite.count' do
		delete favorite_path(favorites(:one))
	end
  end
  
  test "only owner user can destroy" do
	log_in_as(users(:bob))
	favorite = favorites(:one)
	assert_no_difference 'Favorite.count' do
		delete favorite_path(favorite)
	end
  end
  
  test "owner can destroy" do
	log_in_as(users(:preloaded))
	favorite = favorites(:one)
	assert_difference 'Favorite.count', -1 do
		delete favorite_path(favorite)
	end
  end
  
end
