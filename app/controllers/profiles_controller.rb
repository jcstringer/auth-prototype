class ProfilesController < ApplicationController
  before_filter :requires_authentication

  def show
  	render json: @current_user
  end

private

   def requires_authentication
   	@current_user = User.find_by_auth_token ...
   end

end
