class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :title, :null => false
      t.string :description

      t.timestamps
    end
    
    add_index :buckets, :id, :unique => true
  end
end
