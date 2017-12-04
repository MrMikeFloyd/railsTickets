class AddClaimTypeToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :claim_type_id, :integer
  end
end
