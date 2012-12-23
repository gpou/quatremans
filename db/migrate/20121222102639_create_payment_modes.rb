class CreatePaymentModes < ActiveRecord::Migration
  def up
    create_table "paymentmodes" do |t|
      t.string   "slug"
      t.string   "name"
      t.string   "state", :default => "inactive"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    Paymentmode.create_translation_table! :name =>  :string
  end

  def down
    drop_table :paymentmodes
  end
end
