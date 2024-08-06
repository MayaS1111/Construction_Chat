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
    @own_projects = Project.where(owner_id: current_user)
    # @own_chats =  @own_chats.where(project_id: ?) 
    
  end

  # GET /user_chats/1/edit
  def edit
  end

  # POST /user_chats or /user_chats.json
  def create
    @user_chat = UserChat.new(user_chat_params)
    respond_to do |format|
      if @user_chat.save
        if User.where.not(id: "0").exists?
          bot = User.create(id: 0, first_name: "BuiltBetter", last_name: "Bot", phone_number: "0000000000", email: "buildbetter@info.com", job_title: "Helper Bot", password: "password", admin: "true", profile_image: "https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&backgroundColor=D2042D&radius=50&eyesColor=000000&mouthColor=000000&shapeColor=ffffff&scale=70")
        end
        Message.create(body: "#{@user_chat.user.name} has been added by #{current_user.name}",  chat_id: @user_chat.chat.id , sender_id: "0")
        format.html { redirect_to "/home", notice: "User was successfully added." }
        format.json { render :show, status: :created, location: @user_chat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_chat.errors, status: :unprocessable_entity }
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
    chat_id = @user_chat.chat.id
    @user_chat.destroy!

    respond_to do |format|
      if User.where.not(id: "0").exists?
        bot = User.create(id: 0, first_name: "BuiltBetter", last_name: "Bot", phone_number: "0000000000", email: "buildbetter@info.com", job_title: "Helper Bot", password: "password", admin: "true", profile_image: "https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&scale=70&shapeColor=000000&backgroundColor=D2042D")
      end
      if @user_chat.user == current_user
        Message.create(body: "#{current_user.name} has left the chat",  chat_id: chat_id , sender_id: "0")
      else
        Message.create(body: "#{@user_chat.user.name} has been removed by #{current_user.name}",  chat_id: chat_id , sender_id: "0")
      end
      format.html { redirect_to "/chat/#{current_user.projects.first.id}/#{current_user.projects.first.chats.first.id}", notice: "User chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_chat
      @user_chat = UserChat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_chat_params
      params.require(:user_chat).permit(:user_id, :chat_id)
    end
end
