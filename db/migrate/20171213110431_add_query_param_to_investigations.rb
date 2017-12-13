class AddQueryParamToInvestigations < ActiveRecord::Migration[5.1]
  def change
    add_column :investigations, :query_param, :string
  end
end
