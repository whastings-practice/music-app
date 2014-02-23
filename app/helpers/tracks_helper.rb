module TracksHelper
  def track_form_url(track, album = nil)
    track.persisted? ? track_url(track) : album_tracks_url(album)
  end

  def track_submit_text(track)
    track.persisted? ? "Edit Track" : "Add Track"
  end

  def track_album_selected(album, selected_album)
    album.id == selected_album.id ? "selected" : ""
  end

  def track_bonus_selected(track)
    track.bonus ? "checked" : ""
  end
end
