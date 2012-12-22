class AddCountryToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :country_id, :integer
  end
end
