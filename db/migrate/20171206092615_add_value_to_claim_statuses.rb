class AddValueToClaimStatuses < ActiveRecord::Migration[5.1]
  def change
    add_column :claim_statuses, :value, :number
  end
end
