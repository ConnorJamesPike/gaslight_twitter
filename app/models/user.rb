class User < ApplicationRecord
	before_save { self.email = email.downcase }
	USERNAME_REGEX = /\A^*\w*$\z/
	validates :username, presence: true, length: { maximum: 15}, format: { with: USERNAME_REGEX }, uniqueness: { case_sensitive: true}
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	PASSWORD_REGEX = /\A(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$\z/
	has_secure_password
	validates :password, presence: true, format: { with: PASSWORD_REGEX }, length: { minimum: 8, maximum: 16 }
	
	
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
