class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :auth_user
  before_action :set_db_credentials

  set_current_tenant_through_filter
  before_action :set_current_tenant

  after_action :reset_db_connection

  rescue_from ActiveRecord::DatabaseConnectionError, with: :refresh_token

  include DbAuthenticated

  def current_company_id
    session[:company] ||= Company.first.id
  end

  def current_company
    Company.find(current_company_id)
  end

  private

  def set_current_tenant
    ActsAsTenant.current_tenant = current_company
  end

  def set_current_user
    Current.user = session[:current_user]
  end

  def auth_user
    redirect_to '/login' unless Current.user
  end

  def refresh_token(e)
    if e.cause.is_a?(PG::ConnectionBad) && e.cause.message =~ /authentication failed/
      # Remove the connection from the pool
      ActiveRecord::Base.remove_connection(user_db_conf)
      reset_db_connection

      puts e.inspect
      Rails.logger.info("Token expired for user #{Current.user.email}")
      return redirect_to '/login'
    end
    raise e
  end
end
