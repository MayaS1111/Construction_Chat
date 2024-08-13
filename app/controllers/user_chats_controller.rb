class UserChatsController < ApplicationController
  before_action :set_user_chat, only: %i[ show edit update destroy ]

  # GET /user_chats or /user_chats.json
  def index
    @user_chats = UserChat.all
    @users = User.all
  end

  # GET /user_chats/1 or /user_chats/1.json
  def show
  end

  # GET /user_chats/new
  def new
    @user_chat = UserChat.new
    @user_chats = UserChat.all
    @users = User.all
    @chats = Chat.all
    @own_projects = current_user.projects 
    # Project.where(owner_id: current_user)
    # @own_chats =  @own_chats.where(project_id: ?) 
    
  end

  # GET /user_chats/1/edit
  def edit
  end

  # POST /user_chats or /user_chats.json
  def create
    user = User.find_by(id: params.dig(:user_chat, :user_id)).id
    chat = Chat.find(params.dig(:user_chat, :chat_id))
    
    if !chat.members.exists?(user)
      @user_chat = UserChat.new(user_chat_params)

      respond_to do |format|
        if @user_chat.save
          if User.where.not(id: "0").exists?
            bot = User.create(id: 0, first_name: "BuiltBetter", last_name: "Bot", phone_number: "0000000000", email: "builtbetter@info.com", job_title: "Helper Bot", password: "password", admin: "true", profile_image: "https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&backgroundColor=D2042D&radius=50&eyesColor=000000&mouthColor=000000&shapeColor=ffffff&scale=70")
          end
          Message.create(body: "#{@user_chat.user.name} has been added by #{current_user.name}",  chat_id: @user_chat.chat.id , sender_id: "0")
  
          format.html { redirect_to "/chat/#{chat.project_id}/#{chat.id}", notice: "User was successfully added." }
          format.json { render :show, status: :created, location: @user_chat }
          format.js
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user_chat.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to "/chat/#{chat.project_id}/#{chat.id}", alert: "User already in chat" }
      end  
    end
  end
  

  # PATCH/PUT /user_chats/1 or /user_chats/1.json
  def update
    respond_to do |format|
      if @user_chat.update(user_chat_params)
        format.html { redirect_to "/all_users", notice: "User chat was successfully updated." }
        format.json { render :show, status: :ok, location: @user_chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_chats/1 or /user_chats/1.json
  def destroy
    chat_id = @user_chat.chat_id
    @user_chat.remove_message(current_user, chat_id)
    @user_chat.destroy

    respond_to do |format|
      #TODO: when current user removes someone, dont go to dms
      format.html { redirect_to "/chat/#{current_user.projects.first.id}/#{current_user.projects.first.chats.first.id}", notice: "User chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user_chat
      @user_chat = UserChat.find(params[:id])
    end

    def user_chat_params
      params.require(:user_chat).permit(:user_id, :chat_id)
    end
    
    
end
