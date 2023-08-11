class Document < ApplicationRecord
  self.primary_key = 'document_id'
  self.schema = :common
  belongs_to :company

  def self.unprocessed
    where(processed: false)
  end

  def file=(tempfile)
    self.attachment_blob = tempfile.read
    self.meta = {
      content_type: tempfile.content_type,
      filename: tempfile.original_filename
    }
  end
end
