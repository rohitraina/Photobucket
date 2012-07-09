class BucketsController < ApplicationController
  # GET /buckets
  # GET /buckets.json
  def index
    @buckets = Bucket.find(:all, :order => 'title')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buckets }
    end
  end

  # GET /buckets/1
  # GET /buckets/1.json
  def show
    @bucket = Bucket.find(params[:id])
    @albums = @bucket.albums.find(:all, :order => 'title')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/new
  # GET /buckets/new.json
  def new
    @bucket = Bucket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/1/edit
  def edit
    @bucket = Bucket.find(params[:id])
  end

  # POST /buckets
  # POST /buckets.json
  def create
    @bucket = Bucket.new(params[:bucket])
    if @bucket.save
      flash[:notice] = "Photo Bucket created! Now add Albums in this Photo Bucket."
      redirect_to new_bucket_album_path(@bucket)
    else
      render :action => :new
    end
  end

  # PUT /buckets/1
  # PUT /buckets/1.json
  def update
    @bucket = Bucket.new(params[:bucket])
    if @bucket.update_attributes(params[:bucket])
      flash[:notice] = "Photo Bucket updated!"
      redirect_to @bucket
    else
      render :action => :edit
    end
  end

  # DELETE /buckets/1
  # DELETE /buckets/1.json
  def destroy
    @bucket = Bucket.find( params[:id])
    if @bucket.destroy
      redirect_to buckets_path
    else
      redirect_to @bucket
    end
  end
end
