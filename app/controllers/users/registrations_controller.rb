# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        Rails.logger.info('Custom user creation logic')

        # resource.admin = false

        if resource.persisted?
          begin
            project = Project.create!(owner_id: resource.id, name: "#{resource.first_name}'s DMs", description: 'nil',
                                      location: 'nil', project_type: 'private', status: 'nil')

            if User.where(id: 0).exists?
              chat_bot = User.find_by(id: 0)
            else
              chat_bot = User.create(id: 0, first_name: 'BuiltBetter', last_name: 'Bot', phone_number: '0000000000',
                                     email: 'buildbetter@info.com', job_title: 'Helper Bot', password: 'password', admin: 'true', profile_image: 'https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&radius=50&scale=70&shapeColor=000000&backgroundColor=D2042D')
            end

            chat = Chat.create!(project_id: project.id, name: "#{resource.first_name} & #{chat_bot.name}",
                                description: 'nil')
            UserChat.create!(user_id: resource.id, chat_id: chat.id)
            UserChat.create!(user_id: chat_bot.id, chat_id: chat.id)
            Message.create(
              body: 'Welcome to BuiltBetter! Please message here for any help you my need with the application. Even application feedback is welcomed!', sender_id: chat_bot.id, chat_id: chat.id
            )
          rescue StandardError => e
            Rails.logger.error("Error during custom user creation: #{e.message}")
          end
        end
      end
    end
  end
end
