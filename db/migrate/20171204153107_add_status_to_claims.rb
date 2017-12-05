class AddStatusToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :claim_status_id, :integer
  end
end
