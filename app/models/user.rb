class User < ApplicationRecord
	has_many :tweets
	has_many :active_follows, class_name: "Follow", foreign_key: "follower_id"
	has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id"
	has_many :following, through: :active_follows, source: :followed
	has_many :followers, through: :passive_follows, source: :follower
	before_save { self.email = email.downcase }
	USERNAME_REGEX = /\A^*\w*$\z/
	validates :username, presence: true, length: { maximum: 15}, format: { with: USERNAME_REGEX }, uniqueness: { case_sensitive: true}
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	PASSWORD_REGEX = /\A(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$\z/
	has_secure_password
	validates :password, presence: true, format: { with: PASSWORD_REGEX }, length: { minimum: 8, maximum: 16 }
	
	def timeline
		following_user_ids = "SELECT followed_id FROM follows WHERE follower_id = :user_id"
		Tweet.where("user_id IN (#{following_user_ids}) OR user_id = :user_id", user_id: id).distinct
	end
	
	def follow(following_user)
		active_follows.create(followed_id: following_user.id)
	end
	
	def unfollow(following_user)
		active_follows.find_by(followed_id: following_user.id).destroy
	end
	
	def following?(following_user)
		following.include?(following_user)
	end
	
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
