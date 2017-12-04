class AddStatusToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :status_id, :integer
  end
end
