class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, :null => false
      t.text :description
      t.string :path

      t.timestamps
    end
    
    add_index :albums, :id, :unique => true
  end
end
