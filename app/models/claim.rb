class Claim < ApplicationRecord

  # Validations
  # Description and user name of initial creator always have to be set
  validates :description, length: {maximum: 250}, presence:true
  validates :insert_user, :status, presence:true

  # Callbacks
  after_initialize :init_defaults

  # Relationships
  belongs_to :claim_type
  has_many :pictures, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_one :solution, dependent: :destroy

  # Claimstatus
  enum status: {
      "Neu"=> 0,
      "In Bearbeitung"=> 1,
      "Abgeschlossen" => 2,
  }

  # Default-Wert für Pagination
  self.per_page = 6

  # Local methods

  # Defaults setzen
  def init_defaults
    if self.status.nil?
      self.status = "Neu" # Status eines neuen Claims ist immer "Neu"
    end
  end

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

  def is_initial?
    self.status == "Neu"
  end

  def is_in_progress?
    self.status == "In Bearbeitung"
  end

  # Sets the 'In Progress' status, if it is still new
  def set_in_progress
    if(self.status == "Neu")
      self.status = "In Bearbeitung"
      logger.info("Transitioning current claim from 'New' to 'In Progress'.")
    end
  end

  def is_terminated?
    self.status == "Abgeschlossen"
  end

  # Sets the claim into the terminal status
  def set_terminated
    self.status = 2
    logger.info("Current claim is now 'Terminated'.")
  end

  # Returns whether the claim already has a solution
  def has_solution?
    !solution.nil?
  end

end
