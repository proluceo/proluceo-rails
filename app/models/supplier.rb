class Supplier < ApplicationRecord
    self.primary_key = :company_id, :name
    self.schema = :accounting
    belongs_to :company
    has_many :purchase_invoices, class_name: 'PurchaseInvoice', foreign_key: [:company_id, :supplier_name]

    self.search_result_attributes = ['name']

    def to_s
      name
    end

    def self.search(search)
      search.blank? ? all : where(
        "name ILIKE ?", "%#{search}%"
      )
    end
  end
