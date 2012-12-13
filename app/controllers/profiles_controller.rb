class Unauthorized < StandardError; end

class ProfilesController < ApplicationController

  before_filter :requires_authentication
	rescue_from Unauthorized, with: :unauthorized

  def show
  	render json: @current_user
  end

	private

	def current_user
		@current_user
	end

  def requires_authentication
  	authenticate_user!
  	raise Unauthorized if current_user.nil?
  end

  def authenticate_user!
  	return if @authenticated

   	@current_user = authenticate_with_http_basic { |u, p| User.find_by_email_and_password(u, p) } ||
   									(auth_token.present? ? @current_user = User.find_by_auth_token(auth_token) : nil)

  	@authenticated = true
  end

  def auth_token
  	request.headers['Authorization'] || params[:token]
  end

  def unauthorized
  	head status: :unauthorized
  end

end
