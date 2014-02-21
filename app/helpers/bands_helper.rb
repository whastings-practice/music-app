module BandsHelper
  def band_form_url(band)
    band.persisted? ? band_url(band) : bands_url
  end

  def band_submit_text(band)
    band.persisted? ? "Edit Band" : "Add Band"
  end
end
