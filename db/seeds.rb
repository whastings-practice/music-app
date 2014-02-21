ActiveRecord::Base.transaction do

  3.times do
    User.create!(
      email: Faker::Internet.email,
      password: 'foobar'
    )
  end

  3.times do
    Band.create!(name: Faker::Name.name)
  end
  band_ids = Band.all.pluck(:id)

  10.times do
    Album.create!(
      name: Faker::Lorem.words(2).join(' '),
      band_id: band_ids.sample,
      album_type: Album::TYPES.sample
    )
  end
  album_ids = Album.all.pluck(:id)

  30.times do
    Track.create!(
      name: Faker::Lorem.words((1..5).to_a.sample).join(' '),
      album_id: album_ids.sample,
      bonus: [true, false].sample,
      lyrics: Faker::Lorem.paragraphs((1..5).to_a.sample).join("\n")
    )
  end

end
