class FavoritesController < ApplicationController
	before_action :is_logged_in, only: [:create, :destroy]
	before_action :owner_user, only: :destroy
	
	def create
		tweet = Tweet.find(params[:tweet_id])
		current_user.favorite(tweet)
		redirect_to current_user
	end
	
	def destroy
		tweet = Favorite.find(params[:id]).tweet
		current_user.unfavorite(tweet)
		redirect_to current_user
	end
	
	
	private
	
		def owner_user
			@favorite = current_user.favorites.find_by(id: params[:id])
			redirect_to current_user if @favorite.nil?
		end
end
