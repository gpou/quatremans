class RenameConfigRelationFields < ActiveRecord::Migration
  def change
    change_table :configparametres do |t|
      t.rename :config_grup_id, :configgrup_id
    end
    change_table :configparametre_translations do |t|
      t.rename :config_parametre_id, :configparametre_id
    end
    change_table :configzones do |t|
      t.rename :config_parametre_id, :configparametre_id
    end
    change_table :configopcio_translations do |t|
      t.rename :config_opcio_id, :configopcio_id
    end
  end
end
