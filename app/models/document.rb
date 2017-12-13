class Document < ApplicationRecord

  # Validations
  validates :description, :file, presence:true

  # Relationships
  belongs_to :claim

  # Uploader für Dokumente
  mount_uploader :file, DocumentUploader

  # Methods

  # After save callback - Status des Claims auf "in Bearbeitung setzen" wenn nötig
  after_save do
    claim.set_in_progress
    claim.save
  end

end
