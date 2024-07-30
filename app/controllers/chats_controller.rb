class ChatsController < ApplicationController
  before_action :set_project
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    # @chats = @project.chats.all
    @chats = Chat.all
    @messages = Message.all
    @user = current_user
    @projects = Project.all

    @users_user_chats = UserChat.where(user_id: current_user.id)
    # @user_projects = Project.where(id: )

    if params[:project_id].present?
      @current_project = Project.find(params[:project_id])
    end
    if params[:chat_id].present?
      @current_chat = Chat.find(params[:chat_id])
    end
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

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)


    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully created." }
        format.json { render :show, status: :created, location: @chat }
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
        format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat.id}", notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @user_chat_id_to_delete = UserChat.where(chat_id: @chat.id)
    @messages_to_delete = Message.where(user_chat_id: @user_chat_id_to_delete)

    @messages_to_delete.each do |message|
      message.destroy!
    end
    @user_chat_id_to_delete.each do |user_chat|
      user_chat.destroy!
    end

    @chat_list = Chat.where(project_id: @chat.project_id)
    @chat_list_ids = []

    @chat_list.each do |chat|
      @chat_list_ids << chat.id
    end

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
      params.require(:chat).permit(:user, :project_id, :chat_id, :name, :description)
    end
end
