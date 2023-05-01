namespace :dev do
  desc "Add sample data"
  task sample_data: :environment do
    25.times do 
      username = Faker::Creature::Animal.name.split(' ').join('_')
      user = User.create(
        email: "#{username}@example.com",
        username: username,
        # first_name: Faker::Name.first_name,
        # last_name: Faker::Name.last_name,
        password: "classname",
        role: "student"

      )
    end
  end
end
