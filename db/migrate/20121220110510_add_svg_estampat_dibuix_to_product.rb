class AddSvgEstampatDibuixToProduct < ActiveRecord::Migration
  def change
    add_column :productes, :svg_estampat, :text, :limit => 4294967295
  end
end
