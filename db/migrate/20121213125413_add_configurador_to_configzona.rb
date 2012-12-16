class AddConfiguradorToConfigzona < ActiveRecord::Migration
  def change
    add_column :configzones, :configurador, :boolean
  end
end
