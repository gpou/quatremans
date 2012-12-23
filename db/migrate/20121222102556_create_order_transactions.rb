class CreateOrderTransactions < ActiveRecord::Migration
  def up
    create_table "ordertransactions" do |t|
      t.references :order
      t.integer  "amount"
      t.boolean  "success"
      t.string   "reference"
      t.string   "message"
      t.string   "action"
      t.text     "params"
      t.boolean  "test"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
    drop_table :ordertransactions
  end
end
