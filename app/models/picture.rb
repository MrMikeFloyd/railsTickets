class Picture < ApplicationRecord

  # TODO: Gegebenenfalls mit Documents zusammen legen und um DOCUMENT_TYPE o.ä. ergänzen

  # Validations
  validates :description, presence:true

  # Relationships
  belongs_to :claim

  # Uploader für Fotos
  mount_uploader :file, PictureUploader

end
