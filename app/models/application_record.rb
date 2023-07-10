class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  @@current_company_id

  # Until default_order has been propertly implemented in ActiveRecord
  default_scope -> { order(primary_key) }

  before_validation :set_company_id



  def self.current_company_id=(current_company_id)
    @@current_company_id = current_company_id
  end

  def self.current_company_id
    @@current_company_id
  end

  def self.companys
    where(company_id: current_company_id)
  end

  private
  def set_company_id
    self.company_id = self.class.current_company_id
  end
end
