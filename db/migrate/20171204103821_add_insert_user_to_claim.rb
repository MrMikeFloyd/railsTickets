class AddInsertUserToClaim < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :insert_user, :string
  end
end
