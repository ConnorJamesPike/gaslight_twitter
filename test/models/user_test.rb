require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
	@user = User.new(username: "MadeUpUser", email: "fake@foo.com", password: "Bl@hblah", password_confirmation: "Bl@hblah")
  end
  
  test "user validity" do
	assert @user.valid?
  end
  
  test "username required" do
	@user.username = " "
	assert_not @user.valid?
  end
  
  test "email required" do
	@user.email = " "
	assert_not @user.valid?
  end
  
  test "password required" do
	@user.password = @user.password_confirmation = " " * 5
	assert_not @user.valid?
  end
  
  test "username max length" do
	@user.username = "a" * 16
	assert_not @user.valid?
  end
  
  test "email max length" do
	@user.email = "a" * 255 + "@foo.com"
	assert_not @user.valid?
  end
  
  test "password min length" do
	@user.password = @user.password_confirmation = "a" * 7
	assert_not @user.valid?
  end
  
  test "password max length" do
	@user.password = @user.password_confirmation = "a" * 17
	assert_not @user.valid?
  end
  
  test "username valid format" do 
	valid_usernames = %w[UserName user_name us3rname]
	valid_usernames.each do |valid_username|
		@user.username = valid_username
		assert @user.valid?
	end
  end
  
  test "username invalid format" do
	invalid_usernames = %w[userN@me "user name"]
	invalid_usernames.each do |invalid_username|
		@user.username = invalid_username
		assert_not @user.valid?
	end
  end
  
  test "email valid format" do
	valid_emails = %w[fake@fake.com fak3.notreal@fake.Com f_ak-3.@fake.foo.com fake+3@gmail.com]
	valid_emails.each do |valid_email|
		@user.email = valid_email
		assert @user.valid?
	end
  end
  
  test "email invalid format" do
	invalid_emails = %w[fake.com fake@fake,com n@me@fake.com fake@fake.com+org]
	invalid_emails.each do |invalid_email|
		@user.email = invalid_email
		assert_not @user.valid?
	end
  end
  
  test "password valid format" do
	valid_passwords = %w[p@ssWord passW0rd]
	valid_passwords.each do |valid_password|
		@user.password = @user.password_confirmation = valid_password
		assert @user.valid?
	end
  end
  
  test "password invalid format" do
	invalid_passwords = %w[password PASSWORD PassWord p@ssword PASSW0RD]
	invalid_passwords.each do |invalid_password|
		@user.password = @user.password_confirmation = invalid_password
		assert_not @user.valid?
	end
  end
  
  test "unique user" do
	dup_user = @user.dup
	@user.save
	assert_not dup_user.valid?
  end
  
  test "save emails as lowercase" do
	camel_email = "fake@Fake.Com"
	@user.email = camel_email
	@user.save
	assert_equal camel_email.downcase, @user.reload.email
  end
  
  test "correct password authenticates" do
	@user.save
	assert !!@user.authenticate("Bl@hblah")
  end
  
  test "incorrect password does not authenticate" do
	@user.save
	assert_not !!@user.authenticate("blahblah")
  end
end
