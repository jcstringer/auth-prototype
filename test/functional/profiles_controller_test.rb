require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase

  setup do
    @user = users :chris
  end

  test "shows with basic auth" do
    login_with_basic_auth @user
    get :show, format: :json
    assert_response :success
  end

  test "shows with token auth in http header" do
    login_with_oauth_token @user.auth_token
    get :show, format: :json
    assert_response :success
  end

  test "unauthorized with a bad token in http header" do
    login_with_oauth_token "thisisabadtoken"
    get :show, format: :json
    assert_response :unauthorized
  end

  test "shows with token auth in querystring" do
    get :show, token: @user.auth_token, format: :json
    assert_response :success
  end

  test "unauthorized with a bad token in querystring" do
    get :show, token: "thisisabadtoken", format: :json
    assert_response :unauthorized
  end

	test "redirects without auth" do
    get :show, format: :json
    assert_response :unauthorized
  end

  def login_with_oauth_token(token)
    @request.headers['Authorization'] = "token #{token}"
  end

  def login_with_basic_auth(user)
    @request.headers['HTTP_AUTHORIZATION'] = encode_credentials(user.email, user.password)
  end

  def encode_credentials(username, password)
    "Basic #{ActiveSupport::Base64.encode64("#{username}:#{password}")}"
  end

end
