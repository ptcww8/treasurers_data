# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


edu_level = ["Doctorate","Master","Primary","Secondary", "Bachelors"]
treasurer_type = ["principal treasurer","assistant principal treasurer","head treasurer","assistant head treasurer"]

6.times do
  user = User.create(email: Faker::Internet.email, password: "memphis")
	treasurer = Treasurer.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, date_of_birth: Faker::Date.birthday, branch_id: (1..5).to_a.sample, council: Faker::Address.city, whatsapp_number: Faker::PhoneNumber.cell_phone_with_country_code, employment_status: true, education_level: Treasurer::EDUCATION.sample, born_again: true, ud_join: Faker::Date.between(from: 32.years.ago, to: 5.years.ago), bishop_podcast: true, year_treasurer: Faker::Date.between(from: 4.years.ago, to: Date.today), treasurer_type: Treasurer::TREASURER_TYPE.values.sample, training_manual: true, tithe: (0..2).to_a.sample, user_id: user.id)
	treasurer.conference = ["2019","2018"]
	treasurer.save
	file = URI.open('https://picsum.photos/280/280')
	treasurer.image.attach(io: file, filename: "#{Faker::Lorem.word}.jpg")
end