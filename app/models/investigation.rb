# Die Recherchen eines Claims.
class Investigation < ApplicationRecord

  # Validations
  validates :query_result, presence:true

  # Relationships
  belongs_to :claim

  # Methoden

  # Führt eine Abfrage aus und speichert das Resultat.
  def perform_query(param)
    self.query_result = DwhQuery.getDoubleSerNoCheck(param).to_hash


  end



end
