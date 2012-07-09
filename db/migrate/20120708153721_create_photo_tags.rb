class CreatePhotoTags < ActiveRecord::Migration
  def change
    create_table :photo_tags do |t|
      t.references :photo
      t.references :tag

      t.timestamps
    end
    
    add_index :photo_tags, :photo_id
    add_index :photo_tags, :tag_id
  end
end
