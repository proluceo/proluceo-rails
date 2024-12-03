class FormattedLedgerEntryPart < ApplicationRecord
  self.primary_key = [:ledger_entry_id, :account_number]
  self.schema = :accounting
  belongs_to :company
  default_scope -> {unscope(:order)}
end