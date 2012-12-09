class AddFieldsToProductes < ActiveRecord::Migration
  def change
    add_column :productes, :disponible, :boolean, :default => 1
    add_column :productes, :actiu, :boolean, :default => true
    add_column :productes, :tipus, :string, :default => "model"
    add_column :productes, :dificultat, :integer
    add_column :productes, :coordenades_coleccio, :string
    add_column :productes, :dibuix_file_name, :string
    add_column :productes, :dibuix_content_type, :string
    add_column :productes, :dibuix_file_size, :string
    add_column :productes, :svg, :text
  end
end
