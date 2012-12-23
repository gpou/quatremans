class AddProducteToOrderitemparametre < ActiveRecord::Migration
  def change
    add_column :orderitemparametres, :producte_id, :integer
  end
end
