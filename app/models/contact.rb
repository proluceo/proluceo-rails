class Contact < ApplicationRecord
  self.primary_key = :person_id
  self.schema = :sales
  belongs_to :market_member, foreign_key: [:company_id, :market_member_name]
end
