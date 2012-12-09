class AddPositionToProductes < ActiveRecord::Migration
  def change
    add_column :productes, :position, :integer
  end
end
