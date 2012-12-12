class AddDibuixToConfigzona < ActiveRecord::Migration
  def change
    add_column :configzones, :dibuix, :boolean
  end
end
