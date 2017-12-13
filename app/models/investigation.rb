# Die Recherchen eines Claims.
class Investigation < ApplicationRecord

  # Validations
  # Sowohl ein Query-Parameter als auch ein Resultat sind zur Speicherung nötig
  validates :query_param, presence: true

  # Relationships
  belongs_to :claim

  # Methoden

  # Führt eine Abfrage aus und speichert das Resultat.
  def perform_query
    logger.info("Query Parameter: #{self.query_param}")
    unless self.query_param.empty?
      logger.info("Iniziiere DWH-Query.')")
      self.query_result = DwhQuery.getDoubleSerNoCheck(self.query_param).to_hash
      logger.info("Query abgeschlossen - speichere Investigation.")
      self.save
    else
      raise "Query-Parameter ist nil."
    end
  end

  # Überschriebener Getter für Query Result, um ein Hash anstelle eines Strings
  # zurück zu geben
  def query_result
    ret = self[:query_result]
    unless ret.nil?
      JSON.parse ret.gsub('=>', ':')
    end
  end

  # After save callback - Status des Claims auf "in Bearbeitung setzen" wenn nötig
  after_save do
    claim.set_in_progress
    claim.save
  end

end
