class CreateProvincia < ActiveRecord::Migration
  def up
    create_table :provincias do |t|
      t.string :name
      t.references :country, :null => false
      t.float :preu_ports
      t.timestamps
    end
  end

  def down
  end
end
