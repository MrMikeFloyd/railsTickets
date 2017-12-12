# Klasse zum Ausführen von Queries gegen das Data Warehouse der LGI (KNZ).
class DwhQuery < ActiveRecord::Base
  self.abstract_class = true # Abstrakte Klasse => hat kein korrespondierendes DB-Objekt.
  establish_connection(:knz) # Gegen die KNZ verbinden

  # Führt den "DoubleSerNoCheck"-Report aus und liefert das Resultat zurück.
  # Dieses ist vom Typ ActiveRecord::Result
  def self.getDoubleSerNoCheck(shpt_req_nr)
    result=connection.select_all("SELECT DISTINCT BON_COLLI_INFO_VIEW.SHPT_REQ_NR,
        BON_COLLI_INFO_VIEW.COLLI_NR,
        BON_COLLI_INFO_VIEW.INFO_NR,
        BON_COLLI_INFO_VIEW.EPOS_ID_NR,
        BON_COLLI_INFO_VIEW.PERSONAL_ID,
        BON_AUFTRAG_VIEW.VERL_DT,
        BON_AUFTRAG_VIEW.VERL_ZT,
        BON_AUFTRAG_VIEW.PACK_PERS_ID,
        BON_AUFTRAG_VIEW.SHPT_CARRIER_CD,
        BON_AUFTRAG_VIEW.PA_SHPT_RELATION_CD,
        BON_EPOS_VIEW.TE_NR,
        BON_EPOS_VIEW.PACK_SPUR_CD,
        BON_EPOS_VIEW.PART_NR
      FROM (LGCADMIN.BON_COLLI_INFO_VIEW BON_COLLI_INFO_VIEW
      INNER JOIN LGCADMIN.BON_AUFTRAG_VIEW BON_AUFTRAG_VIEW
      ON (BON_COLLI_INFO_VIEW.DIV_CD      =BON_AUFTRAG_VIEW.DIV_CD)
      AND (BON_COLLI_INFO_VIEW.SHPT_REQ_NR=BON_AUFTRAG_VIEW.SHPT_REQ_NR))
      INNER JOIN LGCADMIN.BON_EPOS_VIEW BON_EPOS_VIEW
      ON ((BON_COLLI_INFO_VIEW.SHPT_REQ_NR =BON_EPOS_VIEW.SHPT_REQ_NR)
      AND (BON_COLLI_INFO_VIEW.COLLI_NR    =BON_EPOS_VIEW.COLLI_NR))
      AND (BON_COLLI_INFO_VIEW.EPOS_ID_NR  =BON_EPOS_VIEW.EPOS_ID_NR)
      WHERE BON_COLLI_INFO_VIEW.SHPT_REQ_NR=#{connection.quote(shpt_req_nr)}
    ")
  end

end