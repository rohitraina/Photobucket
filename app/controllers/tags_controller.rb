class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    if params[:album_id]
      @tags = Album.find( params[:album_id] ).photo_tags
    else
      @tags = Tag.order('title')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end
  
end
