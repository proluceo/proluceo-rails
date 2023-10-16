class Currency < ApplicationRecord
  self.primary_key = :iso
  self.schema = :accounting
  self.search_result_attributes = ['iso']

  def to_s
    iso
  end

  def self.search(query)
    ActsAsTenant.without_tenant do
      query.blank? ? all : where(
        "iso::text ILIKE ?", "%#{query}%"
      )
    end
  end
end
