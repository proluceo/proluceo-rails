module CompanyDependent
  extend ActiveSupport::Concern

  included do
    params_method = "#{self.controller_name.singularize}_params"
    alias_method :orig_params, params_method
    define_method params_method do
      _params = orig_params
      _params.merge(company_id: current_company.id)
    end
  end
end