desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  starting = Time.now

  Message.delete_all
  UserChat.delete_all
  Chat.delete_all
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
  people << { first_name: "Adam", last_name: "Clark" }
  people << { first_name: "Shelly", last_name: "Williams" }

  image_name = ["Buddy","Mimi","Abby","Jack","Lily","Lucy","Jasmine","Bear","Loki","Dusty","Maggie","Milo","Lucky","Pepper","Baby","Boo","Sammy","Coco","Mittens","Socks"]

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
      profile_image: "https://api.dicebear.com/9.x/notionists/svg?seed=#{image_name.sample}&radius=50&backgroundColor=D2042D&bodyIcon=galaxy,saturn,electric&bodyIconProbability=10&gesture=hand,handPhone,ok,okLongArm,point,pointLongArm,waveLongArm&gestureProbability=20&lips=variant01,variant02,variant03,variant04,variant05,variant06,variant07,variant08,variant10,variant11,variant13,variant14,variant15,variant16,variant17,variant18,variant19,variant20,variant21,variant22,variant23,variant24,variant25,variant26,variant27,variant29,variant30"
    )
  end

  if User.where.not(id: "0").exists?
    bot = User.create(id: 0, first_name: "BuiltBetter", last_name: "Bot", phone_number: "0000000000", email: "buildbetter@info.com", job_title: "Helper Bot", password: "password", admin: "true", profile_image: "https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&scale=70&shapeColor=000000&backgroundColor=D2042D")
  end

  users = User.where.not(id: "0")
  users.each do |user|
    name = user.fetch(:first_name)
    project = Project.create(
      owner_id: user.id,
      name: "#{name}'s DMs",
      description: "nil", 
      location: "nil",
      project_type: "private",
      member_count: "2",
      status: "nil"
    )
    
    chat_with_bot = Chat.create!(project_id: project.id, name: "#{user.first_name} & #{bot.name}", description: "nil")
    UserChat.create!(user_id: user.id, chat_id: chat_with_bot.id)
    UserChat.create!(user_id: bot.id, chat_id: chat_with_bot.id)

    Message.create(body: "Welcome to BuiltBetter! Please message here for any help you my need with the application. Even application feedback is welcomed!", sender_id: bot.id, chat_id: chat_with_bot.id)
  end
  
  p "There are now #{User.count} users."


  admin_users = User.where(admin: "true")
  admin_users.each do |user|
    num = rand(3..5)
    num.times do
      projects = Project.create(
        owner_id: user.id,
        name: "#{Faker::Construction.subcontract_category} #{Faker::Number.number(digits: 4)}",
        description: "This project needs #{Faker::Construction.heavy_equipment}s and #{Faker::Construction.trade}. We will be using #{Faker::Construction.material} for the length of #{Faker::Measurement.length}", 
        location: Faker::Address.full_address,
        project_type: "public",
        member_count: "0",
        status: {'Open' => 20, 'In Progress' => 80, 'Closed' => 100}.find{|key, value| rand* 100 <= value}.first
        
      )
    end  
  end
  p "There are now #{Project.count} projects."


  private_projects = Project.where(project_type: "private")
  private_projects.each do |project|
    # name = user.fetch(:first_name)
    num = rand(1..3)
    user_set = Set.new()
    
    num.times do
      added_user = User.where.not(id: project.owner.id).sample 
      user_set << added_user
    end

    user_set.each do |user|
      chat = Chat.create(
        project_id: project.id,
        name: "#{project.owner.first_name} & #{user.first_name}",
        description: "nil",
      )
      
      user_chat = UserChat.create(
        chat_id: chat.id,
        user_id: user.id,
      )
      user_chat_owner = UserChat.create(
        chat_id: chat.id,
        user_id: project.owner.id,
      )
      
      num.times do
        message = Message.create(
          chat_id: chat.id,
          body: Faker::Hacker.say_something_smart,
          sender_id: user.id
        )
      end
    end
  end

  public_projects = Project.where(project_type: "public")
  public_projects.each do |project|
    # name = user.fetch(:first_name)
    users_in_project = Set.new()
    num = rand(3..5)

    main = Chat.create(
      project_id: project.id,
      name: "Main",
      description: "This chat is for all users",
    )

    num.times do
      role = Faker::Construction.role
      chat = Chat.create(
        project_id: project.id,
        name: "#{role}'s ##{Faker::Number.number(digits: 1)}",
        description: "This chat is for #{role}s",
      )
   
      users_in_chat = Set.new()
      users_in_chat << project.owner

      num2 = rand(3..5)
      num2.times do
        added_user = User.where.not(id: project.owner.id).sample 
        users_in_chat << added_user
      end
  
      users_in_chat.each do |user|
        users_in_project << user

        user_chat = UserChat.create(
          chat_id: chat.id,
          user_id: user.id,
        )
        
        num3 = rand(1..2)
        num3.times do
          message = Message.create(
            chat_id: chat.id,
            body: Faker::Hacker.say_something_smart,
            sender_id: user.id
          )
        end
      end
    end

   
    users_in_project.each do |user|
      user_chat2 = UserChat.create(
        chat_id: main.id,
        user_id: user.id,
      )

      num3 = rand(1..2)
      num3.times do
        message = Message.create(
          chat_id: main.id,
          body: Faker::Hacker.say_something_smart,
          sender_id: user.id
        )
      end
    end
  end

  p "There are now #{Chat.count} chats."
  p "There are now #{UserChat.count} user_chats."
  p "There are now #{Message.count} messages."
  
  ending = Time.now
  p "Done! It took #{(ending - starting).to_i} seconds to create sample data."
end
