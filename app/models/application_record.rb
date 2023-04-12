class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Until default_order has been propertly implemented in ActiveRecord
  default_scope -> { order(primary_key) }

  @@current_company_id

  def self.current_company_id=(current_company_id)
    @@current_company_id = current_company_id
  end

  def self.current_company_id
    @@current_company_id
  end

  def self.companys
    where(company_id: current_company_id)
  end
end
