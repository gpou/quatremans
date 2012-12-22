class AddDefaultToConfigparametre < ActiveRecord::Migration
  def change
    add_column :configparametres, :configopcio_id, :integer
  end
end
