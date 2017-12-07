class Picture < ApplicationRecord

  # TODO: Gegebenenfalls mit Documents zusammen legen und um DOCUMENT_TYPE o.ä. ergänzen

  # Validations
  validates :description, presence:true

  # Relationships
  belongs_to :claim

  # Uploader für Fotos
  mount_uploader :file, PictureUploader

  # Methods

  # After save callback - Status des Claims auf "in Bearbeitung setzen" wenn nötig
  after_save do
    claim.set_in_progress
    claim.save
  end

end
