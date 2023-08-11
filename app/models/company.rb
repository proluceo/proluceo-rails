class Company < ApplicationRecord
  self.primary_key = "company_id"
  self.schema = :common
  has_many :accounts

  def to_s
    name
  end
end
