class CreateBucketAlbums < ActiveRecord::Migration
  def change
    create_table :bucket_albums do |t|
      t.references :bucket
      t.references :album

      t.timestamps
    end
    
    add_index :bucket_albums, :bucket_id
    add_index :bucket_albums, :album_id
  end
end
