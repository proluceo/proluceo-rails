class ApplicationController < ActionController::Base
  before_action :auth_user
  before_action :set_db_credentials
  before_action :set_model_current_company

  after_action :reset_db_connection

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

  def user_db_conf
    {
      adapter:  'postgresql',
      encoding: 'unicode',
      host:     ENV['RAILS_DB_HOST'],
      port:     ENV['RAILS_DB_PORT'],
      username: current_user.email,
      password: current_user.access_token,
      database: 'proluceo',
      pool: ENV.fetch("RAILS_MAX_THREADS") { 5 }
    }
  end

  def set_db_credentials
    # Connect to db with user credentials once signed in
    return reset_db_connection unless current_user
    ActiveRecord::Base.establish_connection(user_db_conf)
  end

  def refresh_token(e)
    if e.cause.is_a?(PG::ConnectionBad) && e.cause.message =~ /authentication failed/
      # Remove the connection from the pool
      ActiveRecord::Base.remove_connection(user_db_conf)
      reset_db_connection

      puts e.inspect
      Rails.logger.info("Token expired for user #{current_user.email}")
      return redirect_to '/login'
    end
    raise e
  end

  def reset_db_connection
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations.find_db_config(Rails.env))
  end
end
