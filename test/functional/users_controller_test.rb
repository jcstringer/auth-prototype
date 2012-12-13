require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:chris)
  end

  test "should get index" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: "Joe Smith", email: "joe@example.com", password: "pass123" }, format: :json
    end

    assert_response :created
  end

  test "should show user" do
    get :show, id: @user, format: :json
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { email: @user.email, name: @user.name, password: @user.password }, format: :json
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user, format: :json
    end

    assert_response :success
  end
end
