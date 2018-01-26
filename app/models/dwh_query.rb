# Klasse zum Ausführen von Queries gegen das Data Warehouse der LGI (KNZ).
class DwhQuery < ActiveRecord::Base
  self.abstract_class = true # Abstrakte Klasse => hat kein korrespondierendes DB-Objekt.
  establish_connection(:knz) # Gegen die KNZ verbinden

  # Führt den KNZ-Query aus und liefert das Resultat zurück.
  # Dieses ist vom Typ ActiveRecord::Result
  def self.getDoubleSerNoCheck(shpt_req_nr, colli_nr)
    logger.info("Setze SQL gegen KNZ ab (Parameter: SHPT-REQ-NR '#{shpt_req_nr}'; COLLI-NR '#{colli_nr}')")
    result=connection.select_all("
      SELECT
        trim(bon_colli_view.shpt_req_nr)    \"shpt_req_nr\",
        trim(bon_colli_view.colli_nr)       \"colli_nr\",
        trim(bon_colli_view.div_cd)         \"div_cd\",
        trim(bon_colli_view.vers_pal_nr)    \"vers_pal_nr\",
        trim(bon_colli_view.colli_art_cd)   \"colli_art_cd\",
        trim(bon_epos_view.epos_id_nr)      \"epos_id_nr\",
        trim(bon_epos_view.epos_soll_mg)    \"epos_soll_mg\",
        trim(bon_epos_view.epos_ist_mg)     \"epos_ist_mg\",
        trim(bon_epos_view.pack_spur_cd)    \"pack_spur_cd\",
        trim(bon_epos_view.part_nr)         \"part_nr\",
        trim(bon_auftrag_view.tour_id_nr)   \"tour_id_nr\",
        trim(bon_tour_id_view.vers_soll_dt) \"vers_soll_dt\",
        trim(bon_tour_id_view.shpt_carrier_cd)|| trim(bon_tour_id_view.lkw_id_nr) \"lkw_id\",
        trim(bon_colli_view.verl_dt)||trim(bon_colli_view.verl_zt)                \"verl_dt\",
        trim(bon_auftrag_view.ship_dt)                \"ship_dt\",
        trim(bon_lkw_view.lkw_ist_abfahrt_dt_zt)      \"lkw_ist_abfahrt_dt_zt\",
        trim(bon_lkw_view.lkw_kennzeichen_tx)         \"lkw_kennzeichen_tx\"
      FROM lgcadmin.bon_colli_view
      INNER JOIN lgcadmin.bon_epos_view
      ON bon_colli_view.div_cd        = bon_epos_view.div_cd
      AND bon_colli_view.orig_appl_nm = bon_epos_view.orig_appl_nm
      AND bon_colli_view.shpt_req_nr  = bon_epos_view.shpt_req_nr
      AND bon_colli_view.colli_nr     = bon_epos_view.colli_nr
      INNER JOIN lgcadmin.bon_auftrag_view
      ON bon_colli_view.div_cd        = bon_auftrag_view.div_cd
      AND bon_colli_view.orig_appl_nm = bon_auftrag_view.orig_appl_nm
      AND bon_colli_view.shpt_req_nr  = bon_auftrag_view.shpt_req_nr
      INNER JOIN lgcadmin.bon_tour_id_view
      ON bon_auftrag_view.tour_id_nr = bon_tour_id_view.tour_id_nr
      AND bon_auftrag_view.site_cd   = bon_tour_id_view.site_cd
      INNER JOIN lgcadmin.bon_lkw_view
      ON bon_tour_id_view.vers_soll_dt     = bon_lkw_view.vers_soll_dt
      AND bon_tour_id_view.shpt_carrier_cd = bon_lkw_view.shpt_carrier_cd
      AND bon_tour_id_view.lkw_id_nr       = bon_lkw_view.lkw_id_nr
      AND bon_tour_id_view.site_cd         = bon_lkw_view.site_cd
      WHERE bon_colli_view.colli_nr        = #{connection.quote(colli_nr)}
      OR bon_colli_view.shpt_req_nr        = #{connection.quote(shpt_req_nr)}
    ")
  end

end