class ApplicationController < ActionController::Base
  def current_company
    session[:company] ||= Company.first.id
    Company.find(session[:company])
  end
end
