class AddCrearUsuariToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :crear_usuari, :boolean, :default => true
  end
end
