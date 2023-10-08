class SessionsController < ApplicationController
  skip_before_action :auth_user
  skip_before_action :set_current_tenant
  skip_before_action :set_current_user
  skip_before_action :set_db_credentials

  def new
    render :new, layout: false
  end

  def create
    oauth_response = request.env['omniauth.auth']
    user = User.from_omniauth(oauth_response)
    session[:current_user] = user
    redirect_to '/'
  end
end