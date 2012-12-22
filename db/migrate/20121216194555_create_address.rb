class CreateAddress < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.boolean :is_invoice
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :zip
      t.string :city
      t.string :phone
      t.string :dni
      t.references :provincia, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :adresses
  end
end
