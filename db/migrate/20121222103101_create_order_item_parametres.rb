class CreateOrderItemParametres < ActiveRecord::Migration
  def up
    create_table "orderitemparametres" do |t|
      t.references :orderitem
      t.references :configparametre
      t.references :configopcio
      t.string   "label"
      t.string   "value"      
    end
  end

  def down
    drop_table :orderitemparametres
  end
end
