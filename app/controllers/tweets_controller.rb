class TweetsController < ApplicationController
	before_action :is_logged_in, only: [:create, :destroy]
	before_action :owner_user, only: :destroy
	
	def create
		@tweet = current_user.tweets.build(tweet_params)
		if @tweet.save
			redirect_to current_user
		else
			render 'new'
		end
	end
	
	def destroy
		@tweet.destroy
		redirect_to request.referrer || current_user
	end
	
	private
	
		def tweet_params
			params.require(:tweet).permit(:content)
		end
		
		def owner_user
			@tweet = current_user.tweets.find_by(id: params[:id])
			redirect_to current_user if @tweet.nil?
		end
	
end
