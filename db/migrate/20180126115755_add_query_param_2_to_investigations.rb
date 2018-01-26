class AddQueryParam2ToInvestigations < ActiveRecord::Migration[5.1]
  def change
    add_column :investigations, :query_param_2, :string
  end
end
