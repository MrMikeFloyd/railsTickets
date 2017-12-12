class AddClaimToInvestigations < ActiveRecord::Migration[5.1]
  def change
    add_column :investigations, :claim_id, :integer
  end
end
