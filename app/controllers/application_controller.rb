class ApplicationController < ActionController::Base
  before_action :auth_user
  before_action :set_db_credentials
  before_action :set_model_current_company

  rescue_from ActiveRecord::DatabaseConnectionError, with: :refresh_token

  def current_company_id
    session[:company] ||= Company.first.id
  end

  def current_company
    Company.find(current_company_id)
  end

  def current_user
    session[:current_user]
  end

  private

  def set_model_current_company
    ApplicationRecord.current_company_id = current_company_id
  end

  def auth_user
    redirect_to '/login' unless current_user
  end

  def set_db_credentials
    # Connect to db with user credentials once signed in
    return unless current_user
    ActiveRecord::Base.establish_connection(
      adapter:  'postgresql',
      encoding: 'unicode',
      host:     ENV['RAILS_DB_HOST'],
      port:     ENV['RAILS_DB_PORT'],
      username: current_user.email,
      password: current_user.access_token,
      database: 'proluceo',
      pool: ENV.fetch("RAILS_MAX_THREADS") { 5 }
    )
  end

  def refresh_token(e)
    puts e.inspect
    raise e
    return redirect_to '/auth/google_oauth2' if e.message =~ /gruh/
  end
end
