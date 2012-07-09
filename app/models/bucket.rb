class Bucket < ActiveRecord::Base
  attr_accessible :id, :title, :description, :albums_attributes, :album_list
  
  has_many :bucket_albums
  has_many :albums, :through => :bucket_albums

  validates :title, :presence => true
  
  def to_param
     "#{id}-#{title.parameterize}"
  end
  
  def album_list=(albums)
    self.albums = Album.find(albums.map{|album|album[0]})
  end
end
