# frozen_string_literal: true

class PurchaseInvoiceLineComponent < ViewComponent::Base
  with_collection_parameter :line
  def initialize(line:, editable:)
    @line = line
    @editable = editable
  end

end
