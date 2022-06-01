class Account < ApplicationRecord
  self.primary_keys = :company_id, :number
  belongs_to :company
  has_many :purchase_invoices, class_name: 'PurchaseInvoice', foreign_key: [:company_id, :number]

  def to_s
    number.to_s
  end
end
