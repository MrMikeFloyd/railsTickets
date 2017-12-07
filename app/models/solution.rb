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

end
