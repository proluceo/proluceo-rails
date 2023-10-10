class FormattedLedgerEntry < ApplicationRecord
  self.primary_key = :ledger_entry_id
  self.schema = :accounting
  belongs_to :company

  def parts
    attributes['parts'].map do |p|
      OpenStruct.new(p)
    end
  end
end