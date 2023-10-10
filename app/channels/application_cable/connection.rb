module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include DbAuthenticated
    identified_by :current_user, :current_company_id

    def connect
      self.current_user = request.session.fetch("current_user", nil) || reject_unauthorized_connection
      self.company_id = request.session.fetch("company", nil) || reject_unauthorized_connection
    end
  end
end
