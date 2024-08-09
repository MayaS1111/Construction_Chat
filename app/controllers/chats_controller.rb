class ChatsController < ApplicationController
  before_action :set_project
  before_action :set_chat, only: %i[ show edit update destroy  ]

  # GET /chats or /chats.json
  def index
    if params[:project_id].present?
      @current_project = Project.find(params[:project_id])
    end
    if params[:chat_id].present?
      @current_chat = Chat.find(params[:chat_id])
    end
    
    @private_chats = Chat.all.joins(:user_chats).where('user_chats.user_id = ?', current_user).joins(:project).where('projects.project_type = ?', "private")
    @public_chats = Chat.all.joins(:user_chats).where('user_chats.user_id = ?', current_user).joins(:project).where('projects.id = ?', @current_project)
    @users_user_chats = UserChat.where(user_id: current_user.id)

    @new_chat = @current_project.chats.new
    @chat_bot = User.where(id: "0")
  end

  # GET /chats/1 or /chats/1.json
  def show
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  def create_private_chat
    # Log the parameters for debugging
    Rails.logger.debug "Received Parameters: #{params.inspect}"
  
    # Find the project
    project = Project.find_by(id: params[:project_id])
  
    # Check if the project exists
    if project.nil?
      Rails.logger.debug "Project not found with ID: #{params[:project_id]}"
      render json: { success: false, errors: ["Project not found"] }
      return
    end
  
    # Find the chat based on project ID and other context if needed
    chat = project.chats.find_by(id: params[:chat_id])
    if chat.nil?
      Rails.logger.debug "Chat not found in project with ID: #{params[:chat_id]}"
      render json: { success: false, errors: ["Chat not found"] }
      return
    end
  
    # Check if the user is a member of the chat
    user_to_chat_with = chat.members.find_by(id: params[:user_id])
    if user_to_chat_with.nil?
      Rails.logger.debug "User not found as a member of chat with ID: #{params[:user_id]}"
      render json: { success: false, errors: ["User not found as a member"] }
      return
    end
  
    # Create a new chat if all checks pass
    @chat = Chat.new(
      body: nil,
      name: "#{current_user.name} & #{user_to_chat_with.name}",
      project: project
    )
  
    if @chat.save
      UserChat.create(chat: @chat, user: current_user)
      UserChat.create(chat: @chat, user: user_to_chat_with)
      
      render json: { success: true, chat_id: @chat.id }
    else
      render json: { success: false, errors: @chat.errors.full_messages }
    end
  end
  
  

  # POST /chats or /chats.json
  def create
    if params[:project_id].present?
      @current_project = Project.find(params[:project_id])
    end
    @chat = @current_project.chats.new(chat_params)

    respond_to do |format|
      if @chat.save
        UserChat.create(user_id: current_user.id, chat_id: @chat.id)
        format.html { redirect_to "/chat/#{@chat.project.id}/#{@chat.id}", notice: "Chat was successfully created." }
        format.json { render :show, status: :created, location: @chat }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

 

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to "/projects/#{@chat.project_id}/chats/#{@chat.id}", notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    user_chats_to_delete = UserChat.where(chat_id: @chat.id)
    messages_to_delete = Message.where(user_chat_id: user_chats_to_delete)

    messages_to_delete.each do |message|
      message.destroy!
    end
    user_chats_to_delete.each do |user_chat|
      user_chat.destroy!
    end

    #TO DO: Refactor this section (use a set)
    @chat_list = Chat.where(project_id: @chat.project_id)
    @chat_list_ids = [].reverse

    @chat_list.each do |chat|
      @chat_list_ids << chat.id
    end
    # @chat_list_ids = Chat.where(project_id: @chat.project_id).id

    respond_to do |format|
      @chat.destroy!

      format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat_list_ids[0]}", notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def set_project
      @projects = Project.find(params[:project_id])
    end
  
    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:project_id, :name, :description, user_chats_attributes:[:chat_id, :user_id])
    end
end
