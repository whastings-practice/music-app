class AlbumsController < ApplicationController
  def index
    @albums = Album.where(band_id: params[:band_id])
    @band = Band.find(params[:band_id])
    render :index
  end

  def show
    @album = Album.find(params[:id])
    @band = @album.band
    @tracks = @album.tracks
    render :show
  end

  def new
    @album = Album.new
    load_album_variables
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Album added!"
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      load_album_variables
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
    load_album_variables
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      flash[:notice] = "Album updated!"
      redirect_to album_url(@album)
    else
      load_album_variables
      flash.now[:errors] = @album.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to band_url(album.band)
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end

  def load_album_variables
    @bands = Band.all
    @types = Album::TYPES
    if params[:band_id]
      @selected_band = Band.find(params[:band_id])
    else
      @selected_band = @album.band
    end
  end
end
