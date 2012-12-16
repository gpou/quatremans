class AddNomToConfigzona < ActiveRecord::Migration
  def change
    add_column :configzones, :nom, :string
    add_column :productes, :svg_configurador, :text, :limit => 4294967295
  end
end
