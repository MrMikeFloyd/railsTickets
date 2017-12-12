class CreateInvestigations < ActiveRecord::Migration[5.1]
  def change
    create_table :investigations do |t|
      t.text :query_result # Das Ergebnis der Query als Hash

      t.timestamps
    end
  end
end
