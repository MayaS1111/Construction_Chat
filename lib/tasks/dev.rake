desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  starting = Time.now

  
  Project.delete_all
  User.delete_all
  

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    }
  end

  people << { first_name: "Alice", last_name: "Smith" }
  people << { first_name: "Bob", last_name: "James" }
  people << { first_name: "Carol", last_name: "Clark" }
  people << { first_name: "Doug", last_name: "Williams" }

  image_name = ["Buddy","Mimi","Abby","Jack","Lily","Lucy","Jasmine","Bear","Loki","Dusty","Maggie","Milo","Lucky","Pepper","Baby","Boo","Sammy","Coco","Mittens","Socks"]

  image_name =
  people.each do |person|
    name = person.fetch(:first_name).downcase

    user = User.create(
      admin: [true, false].sample,
      email: "#{name}@example.com",
      employee_id: Faker::Number.number(digits: 10),
      password: "password",
      first_name: "#{person[:first_name]}",
      job_title: Faker::Construction.role,
      last_name: "#{person[:last_name]}",
      phone_number: Faker::PhoneNumber.phone_number,
      profile_image: "https://api.dicebear.com/9.x/notionists/svg?seed=#{image_name.sample}&radius=50&backgroundColor=ffd5dc&bodyIcon=galaxy,saturn,electric&bodyIconProbability=10&gesture=hand,handPhone,ok,okLongArm,point,pointLongArm,waveLongArm&gestureProbability=20&lips=variant01,variant02,variant03,variant04,variant05,variant06,variant07,variant08,variant10,variant11,variant13,variant14,variant15,variant16,variant17,variant18,variant19,variant20,variant21,variant22,variant23,variant24,variant25,variant26,variant27,variant29,variant30"
    )
  end

  users = User.all

  users.each do |user|
    name = user.fetch(:first_name)
    project = Project.create(
      owner_id: user.id,
      name: "#{name}'s DMs",
      description: "nil", 
      location: "nil",
      project_type: "private",
      member_count: "2"
    )
  end

  admin_users = User.where(admin: "true")

  admin_users.each do |user|
    num = rand(1..3)
    num.times do
      project = Project.create(
        owner_id: user.id,
        name: "#{Faker::Construction.subcontract_category} #{Faker::Number.number(digits: 4)}",
        description: "This project needs #{Faker::Construction.heavy_equipment}s and #{Faker::Construction.trade}. We will be using #{Faker::Construction.material} for the length of #{Faker::Measurement.length}", 
        location: Faker::Address.full_address,
        project_type: "public",
        member_count: "00"
      )
    end  
  end
  

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{Project.count} projects."
end
# Faker::Hacker.say_something_smart
