class Exchange < ApplicationRecord
  self.schema = :sales
  rich_text_column :body
  belongs_to :market_member, foreign_key: [:company_id, :market_member_name]
end
