class AddSvgEstampatsToProduct < ActiveRecord::Migration
  def change
    add_column :productes, :svg_estampat_davant, :text, :limit => 4294967295
    add_column :productes, :svg_estampat_darrera, :text, :limit => 4294967295
  end
end
