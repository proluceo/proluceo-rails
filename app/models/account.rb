class Account < ApplicationRecord
  self.primary_keys = :company_id, :number
  self.schema = :accounting

  belongs_to :company
  has_many :purchase_invoices, class_name: 'PurchaseInvoice', foreign_key: [:company_id, :number]

  def to_s
    number.to_s + ' ' + label
  end

  def self.search(params)
    params[:q].blank? ? all : where(
      "label ILIKE ? OR cast(number as text) ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%"
    )
  end
end
