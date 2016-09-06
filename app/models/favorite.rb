class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :tweet
	#belongs_to :favorited, class_name: "Tweet"
	#belongs_to :favoriter, class_name: "User"
	validates :user_id, presence: true
	validates :tweet_id, presence: true
end
