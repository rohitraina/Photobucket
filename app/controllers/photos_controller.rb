class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index    
    if params[:tag_id] && params[:album_id]
      @tag = Tag.find_by_title!( params[:tag_id] )
      @photos = @tag.photos.find(:all, :conditions => ['photos.album_id = :album', {:album => Album.find(params[:album_id] ) } ], :order => "photos.id ASC")
    elsif params[:tag_id]
      @tag = Tag.find_by_title!( params[:tag_id] )
      @photos = @tag.photos.find(:all, :order => "photos.id ASC")
    elsif params[:album_id]
      @album = Album.find(params[:album_id])
      @photos = @album.photos.find(:all, :order => "photos.id ASC")
    else
      @photos = Photo.find(:all, :order => "photos.id ASC")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
    previous_rs = Photo.previous( @photo.id, @photo.album )
    @previous = previous_rs.first unless previous_rs.empty?
    next_rs = Photo.next( @photo.id, @photo.album )
    @next = next_rs.first unless next_rs.empty?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end
  
  def scan
    require "scan"
    ScanFiles.Scan(false)
    redirect_to(root_path)
  end
  
  def upload_photos
    @album = Album.find(params[:album_id])
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end  
  
  def edit_multiple_photos
    if params[:album_id]
      @album = Album.find( params[:album_id] )
      @photos = @album.photos
    else
      @photos = Photo.find( params[:photo_ids] )
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])
    @photo.file = params[:file]

    respond_to do |format|
      if @photo.save
        format.html { render :text => "FILEID:" + @photo.file.album.url }
        format.json { render :nothing => true }
      else
        format.html { render :text => "ERRORS:" + @photo.errors.full_messages.join(" "), :status => 500 }
        format.json  { render json => @photo.errors, :status => 500 }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find( params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Photo updated!"
      if params[:bucket_id]
        redirect_to bucket_album_photo_path( params[:bucket_id], params[:album_id], @photo )
      elsif params[:album_id]
        redirect_to album_photo_path( params[:album_id], @photo )
      else
        redirect_to @photo
      end
    else
      render :action => :edit
    end
  end
  
  def update_multiple_photos
    @photos = params[:photos][:photo]
    @photos.each do |photo_item|
      photo = Photo.find( photo_item[0] )
      if photo_item[1][:_delete] == "1"
        photo.destroy
      else
        photo.title = photo_item[1][:title]
        photo.tag_list = photo_item[1][:tags]
        photo.save
      end
    end
    flash[:notice] = "Updated photos!"
    redirect_to photos_path
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find( params[:id])
    @album = @photo.album
    if @photo.destroy
      if params[:bucket_id]
        redirect_to bucket_album_path( params[:bucket_id], @album )
      else
        redirect_to @album
      end
    else
      redirect_to @photo
    end
  end
end
