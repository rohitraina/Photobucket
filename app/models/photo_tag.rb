class PhotoTag < ActiveRecord::Base
  attr_accessible :id, :photo_id, :tag_id
  
  belongs_to :photo
  belongs_to :tag
end
