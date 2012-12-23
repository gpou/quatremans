class CreateOrders < ActiveRecord::Migration
  def up
    create_table "orders" do |t|
      t.string   "number"
      t.integer  "paymentmode_id"
      t.string   "shipping_mode"
      t.decimal  "shipping_amount",    :precision => 10, :scale => 2
      t.decimal  "amount",        :precision => 10, :scale => 2
      t.decimal  "vat_amount",       :precision => 10, :scale => 2
      t.string   "state"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "comment"
      t.string   "description"
      t.integer  "old_id"
      t.string   "spedition_number"
    end
  end

  def down
    drop_table :orders
  end
end