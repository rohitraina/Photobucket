class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title, :null => false
      t.text :description
      t.references :album
      t.string :file

      t.timestamps
    end
    
    add_index :photos, :id, :unique => true
    add_index :photos, :album_id
  end
end
