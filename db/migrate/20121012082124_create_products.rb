class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.float :price

      t.timestamps
    end
    #falta: add_index :microposts, [:user_id, :created_at]
  end
end
