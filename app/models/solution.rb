class Solution < ApplicationRecord

  # Relations
  belongs_to :claim

  # Validations
  # Zumindest PID/Load-ID-Daten und eine Beschreibung sollten erfasst werden
  validates :pid_info, :load_id, :description, presence:true

  # Typ der Beschädigung
  enum damage_type: {
      "Box"=> 0,
      "Gerät"=> 1
  }

  # Methoden

  # After save callback - Status des Claims auf "in Bearbeitung setzen" wenn nötig
  after_save do
    claim.set_in_progress
    claim.save
  end

end
