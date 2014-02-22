class TracksController < ApplicationController
  before_action :load_track_variables, only: [:new, :create, :edit, :update]

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:notice] = "Track added!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      flash[:notice] = "Track updated!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy
    redirect_to album_url(track.album_id)
  end

  private

  def load_track_variables
    @albums = Album.all
    @album = Album.find(params[:album_id]) if params[:album_id]
  end

  def track_params
    params.require(:track).permit(:name, :album_id, :bonus, :lyrics)
  end
end
