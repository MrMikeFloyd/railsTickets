class AddClaimToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :claim_id, :integer
  end
end
