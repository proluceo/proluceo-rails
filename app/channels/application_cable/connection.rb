module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include DbAuthenticated
    identified_by :current_user, :current_tenant

    def connect
      user = request.session.fetch("current_user", nil) || reject_unauthorized_connection
      company_id = request.session.fetch("company", nil) || reject_unauthorized_connection

      self.current_user = user
      Current.user = user

      set_db_credentials
      company = Company.find(company_id)
      self.current_tenant = company
      ActsAsTenant.current_tenant = company
    end
  end
end
