class FollowsController < ApplicationController
	before_action :is_logged_in, only: [:create, :destroy]
	before_action :owner_user, only: :destroy
	
	def create
		user = User.find(params[:followed_id])
		current_user.follow(user)
		redirect_to user
	end
	
	def destroy
		user = Follow.find(params[:id]).followed
		current_user.unfollow(user)
		redirect_to user
	end
	
	private
	
		def owner_user
			@follow = current_user.active_follows.find_by(id: params[:id])
			redirect_to current_user if @follow.nil?
		end
end
