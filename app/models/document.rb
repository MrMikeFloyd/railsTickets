class Document < ApplicationRecord

  # Validations
  validates :description, presence:true

  # Relationships
  belongs_to :claim

  # Uploader für Dokumente
  mount_uploader :file, DocumentUploader

end
