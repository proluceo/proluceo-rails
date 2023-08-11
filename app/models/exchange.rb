class Exchange < ApplicationRecord
  self.primary_key = %w(company_id sender_id recipient_id happened_at)
  self.schema = :sales
  belongs_to :market_member
end
