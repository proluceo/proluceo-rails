class AccountBalance < ApplicationRecord
  self.primary_key = :company_id, :number
  self.schema = :accounting

  belongs_to :company
  has_many :purchase_invoices, class_name: 'PurchaseInvoice', foreign_key: [:company_id, :number]
  has_many :formatted_ledger_entry_parts, foreign_key: [:company_id, :account_number]

  self.search_result_attributes = %w(number description)

  def to_s
    number.to_s + ' ' + label
  end

  def description
    to_s
  end

  def self.search(query)
    query.blank? ? all : where(
      "label ILIKE ? OR cast(number as text) ILIKE ?", "%#{query}%", "#{query}%"
    )
  end
end
