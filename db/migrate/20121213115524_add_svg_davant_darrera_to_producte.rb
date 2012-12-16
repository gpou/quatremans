class AddSvgDavantDarreraToProducte < ActiveRecord::Migration
  def change
    add_column :productes, :svg_davant, :text, :limit => 4294967295
    change_table :productes do |t|
      t.rename :svg_configurador, :svg_darrera
    end
  end
end
