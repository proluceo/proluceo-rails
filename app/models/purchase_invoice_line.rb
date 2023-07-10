class PurchaseInvoiceLine < ApplicationRecord
  self.primary_keys = [:purchase_invoice_id, :account_number]

  belongs_to :purchase_invoice, optional: true
  belongs_to :company
  belongs_to :account, foreign_key: [:company_id, :account_number]
  belongs_to :tax_account, foreign_key: [:company_id, :tax_account_number], class_name: 'Account', optional: true
end
