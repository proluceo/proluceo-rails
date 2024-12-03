class Period < ApplicationRecord
  self.primary_key = :company_id, :starts_on, :ends_on
  self.schema = :accounting

  belongs_to :company

  def to_s
    "#{starts_on} - #{ends_on}"
  end
end
