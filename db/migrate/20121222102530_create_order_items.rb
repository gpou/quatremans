class CreateOrderItems < ActiveRecord::Migration
  def up
    create_table "orderitems" do |t|
      t.references :order
      t.references :producte
      t.decimal  "unit_price", :precision => 10, :scale => 2
      t.integer  "quantity"
      t.string   "label"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
    drop_table :orderitems
  end
end
