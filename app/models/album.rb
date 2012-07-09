class Album < ActiveRecord::Base
  attr_accessible :id, :title, :description, :path, :tags, :photos_attributes, :buckets_attributes
  
  has_many :photos, :dependent => :destroy
  has_many :bucket_albums
  has_many :buckets, :through => :bucket_albums
  
  validates :title, :presence => true
  validates :path, :presence => true, :uniqueness => true
  
  before_validation :ensure_path, :set_title
  after_create :create_directories
  after_destroy :destroy_directories

  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  def ensure_path
    self.path = self.title.parameterize unless self.path
  end
  
  def set_title
    self.title = File.basename(self.path).titleize unless self.title || !self.path
  end
  
  def tags    
    tags = Array.new
    self.photos.map{ |photo|
        if photo.tags.empty?
          return
        else
          photo.tags
        end
    }.each_with_index{ |photo_tags,i|
        if i == 0
          tags = photo_tags
        else
          tags = tags & photo_tags
        end
    }
    return tags
  end
  
  def tags=(tags)
    tags = tags.split(" ").sort
    current_tags = ( self.tags.nil? ? [] : self.tags.map{|tag|tag.title} )
    return if tags == self.tags    
    (current_tags - tags).each { |tag|
      self.photos.each {|photo|
        photo.untag( tag )
      }
    }
    
    (tags - current_tags).each do |tag|
      self.photos.each { |photo|
        photo.tag( tag )
      }
    end
  end

  def photo_tags
    tags = Array.new
    self.photos.each{ |photo|
      tags = tags | photo.tags
    }
    return tags
   end

  protected

  private
  
  def create_directories
    #Dir.mkdir( APP_CONFIG[:photos_path] + self.path ) unless File.exists?( APP_CONFIG[:photos_path] + self.path )
    #Dir.mkdir( APP_CONFIG[:thumbs_path] + self.path ) unless File.exists?( APP_CONFIG[:thumbs_path] + self.path )
  end
  
  def destroy_directories
    #puts "DELETE DIRECTORY " + APP_CONFIG[:photos_path] + self.path
    #Dir.delete( APP_CONFIG[:photos_path] + self.path ) if File.exists?( APP_CONFIG[:photos_path] + self.path )
    #Dir.delete( APP_CONFIG[:thumbs_path] + self.path  ) if File.exists?( APP_CONFIG[:thumbs_path] + self.path )
  end
end
