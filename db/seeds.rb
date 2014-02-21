ActiveRecord::Base.transaction do

  3.times do
    User.create!(
      email: Faker::Internet.email,
      password: 'foobar'
    )
  end

end
