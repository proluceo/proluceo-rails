class Company < ApplicationRecord
  self.primary_key = "company_id"
  has_many :accounts

  def to_s
    name
  end
end
