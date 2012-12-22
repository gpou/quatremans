class CreateCountry < ActiveRecord::Migration
  def up
    create_table :countries do |t|
      t.string :name
      t.float :preu_ports
      t.timestamps
    end
  end

  def down
    drop_table :countries
  end
end
