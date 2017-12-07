class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.string :load_id
      t.text :pid_info
      t.text :description
      t.string :pallet_id
      t.integer :number_of_pallets
      t.string :box_id
      t.string :serial_number_example
      t.integer :damage_type

      t.timestamps
    end
  end
end
