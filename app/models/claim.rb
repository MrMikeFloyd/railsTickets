class Claim < ApplicationRecord

  # Validations
  validates :description, length: {maximum: 250}, presence:true
  validates :insert_user, presence:true # Username des initialen Erstellers ist immer zu setzen

  # Relationships
  has_many :pictures, dependent: :destroy
  has_many :documents, dependent: :destroy

  # Local methods

  # Gibt die E-Mailadresse des aktuellen Users zurück
  def set_insert_user(user)
    logger.info("Setting insert user.")
    insert_user = User.find_by(id: user.id)
    self.insert_user = insert_user.email
  end


end
