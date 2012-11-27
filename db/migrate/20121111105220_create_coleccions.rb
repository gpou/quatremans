class CreateColeccions < ActiveRecord::Migration
  def up
    create_table :coleccions do |t|
      t.string :slug, :null => false
      t.timestamps
    end
    Coleccio.create_translation_table! :nom =>  :string, :slug =>  :string, :descripcio => :text
  end

  def down
    drop_table :coleccions
    Coleccio.drop_translation_table!
  end
end
