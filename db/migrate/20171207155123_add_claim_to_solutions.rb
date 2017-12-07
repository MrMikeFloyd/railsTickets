class AddClaimToSolutions < ActiveRecord::Migration[5.1]
  def change
    add_column :solutions, :claim_id, :integer
  end
end
