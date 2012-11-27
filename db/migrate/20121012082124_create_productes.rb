class CreateProductes < ActiveRecord::Migration
  def up
    create_table :productes do |t|
      t.references :coleccio
      t.string :slug, :null => false
      t.float :preu
      t.timestamps
    end
    Producte.create_translation_table! :nom =>  :string, :slug =>  :string, :descripcio => :text
  end

  def down
    drop_table :productes
    Producte.drop_translation_table!
  end
end
