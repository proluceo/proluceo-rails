class FormattedLedgerEntry < ApplicationRecord
  self.primary_key = :ledger_entry_id
  self.schema = :accounting
  belongs_to :company

  class << self
    def for_account(account_number)
      FormattedLedgerEntry.where("jsonb_path_exists(parts, '$[*] ? (@.account_number == :number )')", number: account_number)
    end
  end

  def parts
    attributes['parts'].map do |p|
      OpenStruct.new(p)
    end
  end

  def parts_for_account(account_number)
    parts.select {|p| p.account_number == account_number}
  end

  def debit_for_account(account_number)
    parts_for_account(account_number).sum(&:debit)
  end

  def credit_for_account(account_number)
    parts_for_account(account_number).sum(&:credit)
  end
end