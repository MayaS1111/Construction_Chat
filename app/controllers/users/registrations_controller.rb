class Users::RegistrationsController < Devise::RegistrationsController
  def create

    super do |resource|
      Rails.logger.info("Custom user creation logic")

      # resource.admin = false

      if resource.persisted?
        begin
          project = Project.create!(owner_id: resource.id, name: "#{resource.first_name}'s DMs", description: "nil", location: "nil", project_type: "private", status: "nil")
          chat = Chat.create!(project_id: project.id, name: "#{resource.first_name} & BuiltBetter.Info", description: "nil")
          UserChat.create!(user_id: resource.id, chat_id: chat.id)
        rescue StandardError => e
          Rails.logger.error("Error during custom user creation: #{e.message}")
        end
      end
    end
  end
end
