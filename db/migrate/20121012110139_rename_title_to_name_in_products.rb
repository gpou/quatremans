class RenameTitleToNameInProducts < ActiveRecord::Migration
  def up
    rename_column :products, :title, :name
  end
end
