class BucketAlbum < ActiveRecord::Base
  attr_accessible :id, :bucket_id, :album_id, :buckets_attributes, :albums_attributes
  
  belongs_to :bucket
  belongs_to :album
end
