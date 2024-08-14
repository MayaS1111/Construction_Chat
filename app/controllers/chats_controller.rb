class ChatsController < ApplicationController
  before_action :set_project, only: %i[ index create ]
  before_action :set_chat, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ create_private_chat ]
  # Setting DM project
  before_action :set_private_project, only: %i[ index create_private_chat ]

  # GET /chats or /chats.json
  def index
    if params[:chat_id].present?
      @current_chat = Chat.find(params[:chat_id])
    end
    
    @private_chats = current_user.chats.private_projects
    @public_chats = current_user.chats.for_project(@project)

    @new_chat = @project.chats.new
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
    current_private_chats = current_user.chats.private_projects
    chats_with_user_to_chat_with = @user.chats.private_projects
    chat_ids_with_current_user = current_private_chats.pluck(:id)
    chat_ids_with_user_to_chat_with = chats_with_user_to_chat_with.pluck(:id)
    common_chat_ids = chat_ids_with_current_user & chat_ids_with_user_to_chat_with
  
    chat = Chat.joins(:user_chats).where(id: common_chat_ids).group('chats.id').having('COUNT(user_chats.user_id) = 2').first
  
    if chat
      respond_to do |format|
        format.html { redirect_to "/chat/#{chat.project_id}/#{chat.id}", alert: "You already have a private chat with this user." }
        format.js
      end
    else
      @chat = Chat.new(
        description: "nil",
        name: "#{current_user.first_name} & #{@user.first_name}",
        project: @private_project.first
      )
  
      respond_to do |format|
        if @chat.save
          UserChat.create(chat: @chat, user: current_user)
          UserChat.create(chat: @chat, user: @user)
  
          format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat.id}", notice: "Chat was successfully created." }
        else
          format.json { render json: { success: false, errors: @chat.errors.full_messages } }
        end
      end
    end
  end


  # POST /chats or /chats.json
  def create
    @chat = @project.chats.new(chat_params)

    respond_to do |format|
      if @chat.save
        UserChat.create(user_id: current_user.id, chat_id: @chat.id)
        
        format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat.id}", notice: "Chat was successfully created." }
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
    respond_to do |format|
      @chat.destroy!
      format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat_list_ids[0]}", notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_chat
      @chat = Chat.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def set_user
      @user =  User.find(params[:user_id])
    end

    def set_private_project
      @private_project = current_user.projects.private_type
    end

    def chat_params
      params.require(:chat).permit(:project_id, :name, :description, user_chats_attributes:[:chat_id, :user_id])
    end
end
