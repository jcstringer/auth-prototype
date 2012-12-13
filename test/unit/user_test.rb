require 'test_helper'

class UserTest < ActiveSupport::TestCase
	# let(:user) { User.new ... }
	setup do
    @user = User.new name: "Joe Smith", email: "joe@example.com", password: "pass123"
	end

  test "can be valid" do
    assert @user.valid?
  end

  test "email must be unique" do
    @user.email = users(:chris).email

    refute @user.valid?
    assert @user.errors[:email]
    # assert_equal 1, @user.errors.size
    # assert_equal 1, user.errors[:email].size
    # assert_equal ["has already been taken"], user.errors[:email]
    assert @user.errors[:email].include?(unique_error_message)
  end

  test "email must be present" do
  	@user.email = nil

    refute @user.valid?
    assert @user.errors[:email]
    assert @user.errors[:email].include?(presence_error_message)
  end

  test "name must be present" do
  	@user.name = nil

    refute @user.valid?
    assert @user.errors[:name]
    assert @user.errors[:name].include?(presence_error_message)
  end

  test "password must be present" do
  	@user.password = nil

    refute @user.valid?
    assert @user.errors[:password]
    assert @user.errors[:password].include?(presence_error_message)
  end

  def unique_error_message
  	# TODO: Get thes value from the transation yaml files...
  	"has already been taken"
  end

  def presence_error_message
		"can't be blank"
  end

end
