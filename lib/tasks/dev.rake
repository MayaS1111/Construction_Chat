desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  User.delete_all

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    }
  end

  image_name = [Buddy,Mimi,Abby,Jack,Lily,Lucy,Jasmine,Bear,Loki,Dusty,Maggie,Milo,Lucky,Pepper,Baby,Boo,Sammy,Coco,Mittens,Socks].sample

  people << { first_name: "Alice", last_name: "Smith" }
  people << { first_name: "Bob", last_name: "Smith" }
  people << { first_name: "Carol", last_name: "Smith" }
  people << { first_name: "Doug", last_name: "Smith" }

  people.each do |person|
    name = person.fetch(:first_name).downcase

    user = User.create(
      admin: [true, false].sample,
      email: "#{name}@example.com",
      employee_id: Faker::Number.number(digits: 10),
      password: "password",
      first_name: "#{person[:first_name]}",
      job_title: Faker::Job.title,
      last_name: "#{person[:last_name]}",
      phone_number: Faker::PhoneNumber.phone_number,
      profile_image: "https://api.dicebear.com/9.x/notionists/svg?seed=#{image_name}&radius=50&backgroundColor=ffd5dc&bodyIcon=galaxy,saturn,electric&bodyIconProbability=10&gesture=hand,handPhone,ok,okLongArm,point,pointLongArm,waveLongArm&gestureProbability=20&lips=variant01,variant02,variant03,variant04,variant05,variant06,variant07,variant08,variant10,variant11,variant13,variant14,variant15,variant16,variant17,variant18,variant19,variant20,variant21,variant22,variant23,variant24,variant25,variant26,variant27,variant29,variant30"
      
    )
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
end
