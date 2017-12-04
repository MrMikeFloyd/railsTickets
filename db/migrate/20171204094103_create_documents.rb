class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :file
      t.string :description

      t.timestamps
    end
  end
end
