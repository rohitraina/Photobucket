class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.json
  def index
    if params[:tag_id]
      @albums = Album.find(:all, :conditions => [ "id IN ( SELECT DISTINCT photos.album_id FROM photos WHERE photos.id IN ( SELECT photo_id FROM photo_tags WHERE photo_tags.tag_id = :t) )", { :t => Tag.find( params[:tag_id] ).id } ], :order => 'title')
    else
      @albums = Album.find(:all, :order => 'title')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])
    
    if @album.save
      flash[:notice] = "Album created! Now add some Photos to this Album."
      if params[:bucket_id]
        @album.buckets << Bucket.find( params[:bucket_id] )
        redirect_to upload_photos_bucket_album_photos_path(params[:bucket_id], @album )
      else
        redirect_to upload_photos_album_photos_path( @album )
      end
    else
      render :action => :new
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      flash[:notice] = "Album updated!"
      if params[:bucket_id]
        redirect_to bucket_album_path(params[:bucket_id], @album )
      else
        redirect_to @album
      end
    else
      render :action => :edit
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find( params[:id])
    if @album.destroy
      if params[:bucket_id]
        redirect_to bucket_path(params[:bucket_id] )
      else
        redirect_to albums_path
      end
    else
      redirect_to @album
    end
  end
end
