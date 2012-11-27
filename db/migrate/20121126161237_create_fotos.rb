class CreateFotos < ActiveRecord::Migration
  def up
    create_table :fotos do |t|
      t.references :producte
      t.integer :position
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at

      t.timestamps
    end
    Foto.create_translation_table! :nom =>  :string
  end

  def down
    drop_table :fotos
    Foto.drop_translation_table!
  end
end
