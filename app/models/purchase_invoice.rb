class PurchaseInvoice < ApplicationRecord
  self.primary_key = "purchase_invoice_id"
  belongs_to :company
  belongs_to :payment_account, class_name: 'Account', foreign_key: [:company_id, :payment_account_number]
  has_many :lines, class_name: 'PurchaseInvoiceLine', foreign_key: [:purchase_invoice_id]

  def attachment=(_tempfile)
    self.attachment_blob = _tempfile.read
  end
end
