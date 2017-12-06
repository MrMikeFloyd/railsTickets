class Claim < ApplicationRecord

  # Validations
  # Description and user name of initial creator always have to be set
  validates :description, length: {maximum: 250}, presence:true
  validates :insert_user, presence:true

  # Relationships
  belongs_to :claim_status
  belongs_to :claim_type
  has_many :pictures, dependent: :destroy
  has_many :documents, dependent: :destroy

  # Default-Wert für Pagination
  self.per_page = 6

  # Local methods

  # Setzt die Mailadresse des aktuellen Users beim Insert.
  def set_insert_user(user)
    logger.info("Setting insert user.")
    insert_user = User.find_by(id: user.id)
    self.insert_user = insert_user.email
  end

  # Setzt die Mailadresse des aktuellen Users beim Update.
  def set_update_user(user)
    logger.info("Setting update user.")
    update_user = User.find_by(id: user.id)
    self.update_user = update_user.email
  end

  # TODO: Hier aufräumen, weniger Methoden für den Status. Status ggf. einfach als ENUM umsetzen, da er eh hart mit der Geschäftslogik verwoben ist

  # Sets the 'In Progress' status, if it is still new
  def is_initial?
    self.claim_status == ClaimStatus.get_initial
  end

  # Sets the 'In Progress' status, if it is still new
  def set_in_progress
    self.claim_status = ClaimStatus.get_next(ClaimStatus.get_initial)
    logger.info("Current claim is now 'In Progress'.")
  end

  # Sets the 'In Progress' status, if it is still new
  def is_in_progress?
    self.claim_status == ClaimStatus.get_next(ClaimStatus.get_initial)
  end

  # Increments the current claim's status to the next higher value
  def increment_status
    self.claim_status = ClaimStatus.get_next(self.claim_status.value)
  end

  # Sets the claim into the terminal status
  def set_terminated
    self.claim_status = ClaimStatus.get_terminal
    logger.info("Current claim is now 'Terminated'.")
  end

  # Sets the claim into the terminal status
  def is_terminated?
    self.claim_status == ClaimStatus.get_terminal
  end


end
