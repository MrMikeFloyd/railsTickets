class Picture < ApplicationRecord

  # Relationships
  belongs_to :claim

  # Uploader für Fotos
  mount_uploader :file, PictureUploader

end
