class User < ApplicationRecord
	before_save { self.email = email.downcase }
	validates :username, presence: true, length: { maximum: 15}, uniqueness: { case_sensitive: true}
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	PASSWORD_REGEX = /\A(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$\z/
	has_secure_password
	validates :password, presence: true, format: { with: PASSWORD_REGEX }, length: { minimum: 8, maximum: 16 }
end
