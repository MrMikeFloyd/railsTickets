class CreateClaimTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :claim_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
