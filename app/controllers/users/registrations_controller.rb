class Users::RegistrationsController < Devise::RegistrationsController
  def create
    Rails.logger.info("Custom user creation logic")

    super

    if resource.persisted?  # Check if user was successfully created
      begin
        # Create a new Project and Chat
        project = Project.create!(owner_id: resource.id, name: "#{resource.first_name}'s DMs", description: "nil", location: "nil", project_type: "private", status: "nil")
        chat = Chat.create!(project_id: project.id, name: "New DM", description: "This chat is for all members")
        UserChat.create!(user_id: resource.id, chat_id: chat.id)

        Rails.logger.info("Custom user creation completed successfully")
      rescue StandardError => e
        Rails.logger.error("Error during custom user creation: #{e.message}")
        # Handle errors or rollback transactions if needed
      end
    else
      Rails.logger.error("User was not successfully created")
    end
  end
end
