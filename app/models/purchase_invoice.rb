class PurchaseInvoice < ApplicationRecord
  self.primary_key = "purchase_invoice_id"
  belongs_to :company
  belongs_to :payment_account, class_name: 'Account', foreign_key: [:company_id, :payment_account_number]
  #belongs_to :document, autosave: true
  has_many :lines, class_name: 'PurchaseInvoiceLine', foreign_key: [:purchase_invoice_id]

  #delegate :file=, to: :document

  def self.search(params)
    params[:query].blank? ? all : where(
      "cast(issued_on as text) ILIKE ? OR supplier_name ILIKE ? OR reference ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"
    )
  end
end
