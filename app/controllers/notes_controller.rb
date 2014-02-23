class NotesController < ApplicationController
  include SessionsHelper
  include NotesHelper

  before_action :require_signed_in
  before_action only: [:destroy] do
    user_can_delete_note?(Note.find(params[:id]))
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @track = Track.find(params[:track_id])
    @note.track_id = @track.id
    if @note.save
      flash[:notice] = "Note added!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @note.errors.full_messages
      render 'tracks/show', status: :unprocessable_entity
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track)
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end
end
