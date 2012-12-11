class CreateParametres < ActiveRecord::Migration
  def up
    create_table :config_parametres do |t|
      t.string :nom
      t.references :producte
      t.references :config_grup
      t.string :tipus
      t.integer :position
    end
    ConfigParametre.create_translation_table! :nom =>  :string

    create_table :config_zones do |t|
      t.references :config_parametre
      t.text :svg
    end

    create_table :config_grups do |t|
      t.string :nom
      t.references :coleccio
      t.string :tipus
    end

    create_table :config_opcions do |t|
      t.string :nom
      t.string :tipus
      t.float :preu
      t.text :svg
    end
    ConfigOpcio.create_translation_table! :nom =>  :string

  end

  def down
    drop_table :config_parametres
    ConfigParametre.drop_translation_table!
    drop_table :config_zones
    drop_table :config_grups
    drop_table :config_opcions
    ConfigOpcio.drop_translation_table!
  end
end
