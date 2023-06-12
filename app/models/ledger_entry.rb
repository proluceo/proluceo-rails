class LedgerEntry < ApplicationRecord
  self.primary_keys = :ledger_entry_id, :account_number
  belongs_to :company
  belongs_to :account, class_name: 'Account', foreign_key: [:company_id, :account_number]

  def self.create_from_parts(parts)
    new_entry_uuid =  Digest::UUID.uuid_v4
    parts.each { |p| p[:ledger_entry_id] = new_entry_uuid }
    insert_all(parts)
  end
end
