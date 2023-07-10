class Supplier < ApplicationRecord
    self.primary_keys = :company_id, :name
    belongs_to :company
    has_many :purchase_invoices, class_name: 'PurchaseInvoice', foreign_key: [:company_id, :name]

    def to_s
      name
    end

    def self.search(params)
      params[:q].blank? ? all : where(
        "name ILIKE ?", "%#{params[:q]}%"
      )
    end
  end