class AddUpdateUserToClaim < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :update_user, :string
  end
end
