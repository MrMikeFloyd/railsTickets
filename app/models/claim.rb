class Claim < ApplicationRecord

  # Validations
  # Description and user name of initial creator always have to be set
  validates :description, length: {maximum: 250}, presence:true
  validates :insert_user, :status, presence:true

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
  def init_defaults(user)
    logger.info("Setting default values for new Claim instance.")
    if status.nil?
      self.status = "Neu" # Status eines neuen Claims ist immer "Neu"
    end
    if insert_user.nil?
      set_insert_user(user)
    end
  end

  # Setzt die Mailadresse des aktuellen Users beim Insert.
  def set_insert_user(user)
    logger.info("Setting insert user.")
    current_user = User.find_by(id: user.id)
    self.insert_user = current_user.email
  end

  def is_initial?
    status == "Neu"
  end

  def is_in_progress?
    status == "In Bearbeitung"
  end

  # Sets the 'In Progress' status, if it is still new
  def set_in_progress
    if self.status == "Neu"
      self.status = "In Bearbeitung"
      logger.info("Transitioning current claim from 'New' to 'In Progress'.")
    end
  end

  # Sets the 'In Progress' status, if it is already terminated (i.e. reopen it)
  def set_reopen
    if self.status == "Abgeschlossen"
      self.status = "In Bearbeitung"
      logger.info("Transitioning current claim from 'Terminated' to 'In Progress'.")
    else
      raise "Won't perform state transition to 'In Progress' as current claim isn't 'Terminated'."
    end
  end

  def is_terminated?
    status == "Abgeschlossen"
  end

  # Sets the claim into the terminal status
  def terminate
    if self.has_solution?
      self.status = "Abgeschlossen"
      logger.info("Current claim is now 'Terminated'.")
    else
      raise "Won't perform state transition to 'Terminated' as current claim doesn't have a solution."
    end
  end

  # Returns whether the claim already has a solution
  def has_solution?
    !solution.nil?
  end

end
