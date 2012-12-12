class RenameConfigTables < ActiveRecord::Migration
  def change
    rename_table :config_parametres, :configparametres
    rename_table :config_parametre_translations, :configparametre_translations
    rename_table :config_zones, :configzones
    rename_table :config_grups, :configgrups
    rename_table :config_opcions, :configopcions
    rename_table :config_opcio_translations, :configopcio_translations
  end
end
