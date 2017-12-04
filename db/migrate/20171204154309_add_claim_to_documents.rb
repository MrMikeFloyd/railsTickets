class AddClaimToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :claim_id, :integer
  end
end
