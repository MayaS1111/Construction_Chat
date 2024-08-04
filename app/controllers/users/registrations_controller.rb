class Users::RegistrationsController < Devise::RegistrationsController
  def create
    Rails.logger.info("Custom user creation logic")

    super do |resource|
      # Custom logic after user creation
      Rails.logger.info("Custom user creation logic")
      
      if resource.persisted?
        begin
          project = Project.create!(owner_id: resource.id, name: "#{resource.first_name}'s DMs", description: "nil", location: "nil", project_type: "private", status: "nil")
          chat = Chat.create!(project_id: project.id, name: "New DM", description: "This chat is for all members")
          UserChat.create!(user_id: resource.id, chat_id: chat.id)
        rescue StandardError => e
          Rails.logger.error("Error during custom user creation: #{e.message}")
          # Handle errors or rollback transactions if needed
        end
      end
    end
  end
end
