module AlbumsHelper
  def album_form_url(album, band)
    album.persisted? ? album_url(album) : band_albums_url(band)
  end

  def album_submit_text(album)
    album.persisted? ? "Edit Album" : "Add Album"
  end

  def album_band_selected(album, band)
    album.band_id == band.id ? "selected" : ""
  end

  def album_type_selected(album, type)
    album.album_type == type ? "checked" : ""
  end

  def album_type_description(album)
    if album.album_type == 'studio'
      "Recorded in studio."
    elsif album.album_type == 'live'
      "Performed live."
    end
  end
end
