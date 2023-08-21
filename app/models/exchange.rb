class Exchange < ApplicationRecord
  self.schema = :sales
  belongs_to :market_member
end
