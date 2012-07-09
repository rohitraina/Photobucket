class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title, :length => 50, :null => false

      t.timestamps
    end
    
    add_index :tags, :id, :unique => true
  end
end
