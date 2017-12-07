class RemoveClaimStatusFromClaim < ActiveRecord::Migration[5.1]
  def change
    remove_column :claims, :claim_status_id
  end
end
