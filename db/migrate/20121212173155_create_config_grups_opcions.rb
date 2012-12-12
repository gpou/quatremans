class CreateConfigGrupsOpcions < ActiveRecord::Migration
  def up
    create_table :configgrups_configopcions, :id => false do |t|
      t.references :configgrup, :null => false
      t.references :configopcio, :null => false
    end
  end

  def down
    drop_table :configgrups_configopcions
  end
end
