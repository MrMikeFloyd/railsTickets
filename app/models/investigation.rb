# Die Recherchen eines Claims.
class Investigation < ApplicationRecord

  # Validations
  # Cutom-Validator: Mindestens ein Query-Parameter müssen gesetzt sein
  validate :at_least_one_query_param_set

  # Relationships
  belongs_to :claim

  # Methoden

  # Führt eine Abfrage aus und speichert das Resultat.
  def perform_query
    logger.info("Iniziiere DWH-Query mit Parametern: '#{self.query_param}'; '#{self.query_param_2}'")
    self.query_result = DwhQuery.getDoubleSerNoCheck(self.query_param, self.query_param_2).to_hash
    logger.info("Query abgeschlossen - speichere Investigation.")
    self.save
  end

  # Überschriebener Getter für Query Result, um ein Hash anstelle eines Strings
  # zurück zu geben
  def query_result
    ret = self[:query_result]
    unless ret.nil?
      JSON.parse ret.gsub('=>', ':')
    end
  end

  # After save callback - Status des Claims auf "in Bearbeitung" wenn nötig
  after_save do
    claim.set_in_progress
    claim.save
  end

  # Stellt sicher, dass >=1 der Abfrageparameter gesetzt ist
  # Custom validation, siehe http://guides.rubyonrails.org/active_record_validations.html#custom-validators
  def at_least_one_query_param_set
    if(query_param.blank? && query_param_2.blank?)
      errors.add(:query_param, "Einer oder beide der Abfrageparameter müssen gesetzt sein.")
    end
  end

end
