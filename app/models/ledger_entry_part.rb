class LedgerEntryPart < ApplicationRecord
  self.primary_key = :ledger_entry_id, :account_number
  self.schema = :accounting
  belongs_to :company
  belongs_to :account, class_name: 'Account', foreign_key: [:company_id, :account_number]
  belongs_to :ledger_entry, optional: true

  delegate :account_label, :value_on, :label, :account_reversed, :aggregate_credit, :aggregate_debit, :debit, :credit, to: :formatted

  attr_accessor :account_input

  def debit?
    direction == 'debit'
  end

  def credit?
    direction == 'credit'
  end

  def debit_amount
    debit? ? amount : nil
  end

  def credit_amount
    credit? ? amount : nil
  end

  def credit_amount=(new_amount)
    if new_amount.present?
      self.amount = new_amount
      self.direction = :credit
    end
  end

  def debit_amount=(new_amount)
    if new_amount.present?
      self.amount = new_amount
      self.direction = :debit
    end
  end

  def account_input=(account_input)
    return unless self.account_number.blank?
    self.account_number = account_input
  end

  def formatted
    FormattedLedgerEntryPart.where(ledger_entry_id: ledger_entry_id, account_number: account_number).first
  end
end
