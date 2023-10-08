class LedgerEntry < ApplicationRecord
  self.primary_key = :ledger_entry_id
  self.schema = :accounting
  belongs_to :company
  has_many :parts, class_name: 'LedgerEntryPart', foreign_key: :ledger_entry_id
  accepts_nested_attributes_for :parts

  attr_accessor :credit_amount, :debit_amount, :account_input

  before_destroy :delete_parts

  def autosave_associated_records_for_parts
    return if parts.empty?
    parts.each(&:validate!)
    augmented_parts = parts.map { |p| p.attributes.merge({
      ledger_entry_id: self.id
    }) }

    LedgerEntryPart.insert_all(augmented_parts, returning: %w[account_number amount direction ledger_entry_id company_id])
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def delete_parts
    q = ActiveRecord::Base.sanitize_sql_array(['DELETE FROM accounting.ledger_entry_parts WHERE ledger_entry_id=?', ledger_entry_id])
    ActiveRecord::Base.connection.execute(q)
  end
end
