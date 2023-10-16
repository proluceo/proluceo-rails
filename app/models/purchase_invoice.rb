class PurchaseInvoice < ApplicationRecord
  self.primary_key = "purchase_invoice_id"
  self.schema = :accounting
  belongs_to :company
  belongs_to :payment_account, class_name: 'Account', foreign_key: [:company_id, :payment_account_number]
  #belongs_to :document, autosave: true
  has_many :lines, class_name: 'PurchaseInvoiceLine', foreign_key: :purchase_invoice_id

  accepts_nested_attributes_for :lines

  class << self
    def search(params)
      params[:query].blank? ? all : where(
        "cast(issued_on as text) ILIKE ? OR supplier_name ILIKE ? OR reference ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"
      )
    end

    def new_with_last_invoice_defaults(new_attributes={})
      last_invoice = last
      return new(new_attributes) if last_invoice.nil?
      new(last_invoice.attributes.slice('supplier_name', 'currency', 'payment_account_number').merge(new_attributes))
    end
  end

  def send_to_ledger
    append_fsm_event('send_to_ledger')
  end

  def set_lines_defaults
    self.lines.first.company_id = self.company_id
  end
end
