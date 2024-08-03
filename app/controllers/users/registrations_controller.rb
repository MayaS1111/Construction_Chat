class Users::RegistrationsController < Devise::RegistrationsController
  def create
    Rails.logger.info("Custom user creation logic")
    
    super

    project = Project.create(owner_id: current_user.id, name: "#{current_user.first_name}'s DMs", description: "nil", location: "nil", project_type: "private", status: "nil")
    chat = Chat.create(project_id: project.id, name: "New DM", description: "This chat is for all members")
    UserChat.create(user_id: current_user.id, chat_id: chat.id)

    Rails.logger.info("Custom user creation completed")
  end 
end
