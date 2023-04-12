class ApplicationController < ActionController::Base
  before_action :set_model_current_company

  def current_company_id
    session[:company] ||= Company.first.id
  end

  def current_company
    Company.find(current_company_id)
  end

  private

  def set_model_current_company
    ApplicationRecord.current_company_id = current_company_id
  end
end
