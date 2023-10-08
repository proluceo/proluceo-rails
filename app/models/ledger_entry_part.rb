class LedgerEntryPart < ApplicationRecord
  self.primary_key = :ledger_entry_id, :account_number
  self.schema = :accounting
  belongs_to :company
  belongs_to :account, class_name: 'Account', foreign_key: [:company_id, :account_number]
  belongs_to :ledger_entry, optional: true

  attr_accessor :credit_amount, :debit_amount, :account_input

  def debit?
    direction == 'debit'
  end

  def credit?
    direction == 'credit'
  end

  def credit_amount=(credit_amount)
    if credit_amount.present?
      self.amount = credit_amount
      self.direction = :credit
    end
  end

  def debit_amount=(debit_amount)
    if debit_amount.present?
      self.amount = debit_amount
      self.direction = :debit
    end
  end

  def account_input=(account_input)
    return unless self.account_number.blank?
    self.account_number = account_input
  end
end
