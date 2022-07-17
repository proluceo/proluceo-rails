module CompanyDependent
  extend ActiveSupport::Concern

  included do
    # Add current company_id from session before creating the entry
    params_method = "#{controller_name.singularize}_params"
    alias_method :orig_params, params_method
    define_method params_method do
      _params = orig_params
      _params.merge(company_id: current_company.id)
    end

    # Scope the index on the current company_id
    alias_method :orig_index, :index
    def index
      # controller_name == model.pluralize. i.e. for a controller named 'invoices' we set the
      # instance variable @invoices
      instance_variable_set("@#{controller_name}", orig_index.where(company_id: current_company))
    end
  end
end