class TracksController < ApplicationController
  include SessionsHelper

  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_track_variables, only: [:new, :create, :edit, :update]

  def show
    @track = Track.find(params[:id])
    @note = Note.new
    render :show
  end

  def new
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
    render :edit
  end

  def update
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
    if params[:id]
      @track = Track.find(params[:id])
    else
      @track = Track.new
    end
    @albums = Album.all
    @selected_album = (@track.album || Album.find(params[:album_id]))
  end

  def track_params
    params.require(:track).permit(:name, :album_id, :bonus, :lyrics)
  end
end
