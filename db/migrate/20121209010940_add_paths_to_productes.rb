class AddPathsToProductes < ActiveRecord::Migration
  def change
    add_column :productes, :coleccio_path, :text
    add_column :productes, :coleccio_mascara_path, :text
  end
end
