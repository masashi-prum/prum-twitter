require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(user_name: "Example_name", full_name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar", self_introduction: "AAA")
  end

  test "should be valid?" do
  	assert @user.valid?
  end

  test "user_name should be present" do
  	@user.user_name = ""
  	assert_not @user.valid?
  end

  test "full_name should be present" do
  	@user.full_name = ""
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "self_introduction be present" do
  	@user.self_introduction = ""
  	assert_not @user.valid?
  end

  test "user_name should not be too long" do
  	@user.user_name = "a" * 51
  	assert_not @user.valid?
  end

  test "full_name should not be too long" do
  	@user.full_name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  test "self_introduction should not be too long" do
  	@user.self_introduction = "a" * 256
  	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
   end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
