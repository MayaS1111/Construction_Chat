# frozen_string_literal: true

class UserChatsController < ApplicationController
  before_action :set_user_chat, only: %i[show edit update destroy]

  # GET /user_chats or /user_chats.json
  def index
    @user_chats = UserChat.all
    @users = User.all
  end

  # GET /user_chats/1 or /user_chats/1.json
  def show; end

  # GET /user_chats/new
  def new
    @user_chat = UserChat.new
  end

  # GET /user_chats/1/edit
  def edit; end

  # POST /user_chats or /user_chats.json
  def create
    # TODO: Can this be refactored more? (Ian)
    user = User.find_by(id: params.dig(:user_chat, :user_id))
    chat = Chat.find(params.dig(:user_chat, :chat_id))

    if !chat.members.exists?(user.id)
      @user_chat = UserChat.new(user_chat_params)

      respond_to do |format|
        if @user_chat.save
          @user_chat.create_message(user, current_user, chat.id)
          format.html { redirect_to "/chat/#{chat.project_id}/#{chat.id}", notice: 'User was successfully added.' }
          format.json { render :show, status: :created, location: @user_chat }
          format.js
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user_chat.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to "/chat/#{chat.project_id}/#{chat.id}", alert: 'User already in chat' }
      end
    end
  end

  # PATCH/PUT /user_chats/1 or /user_chats/1.json
  def update
    respond_to do |format|
      if @user_chat.update(user_chat_params)
        format.html { redirect_to '/all_users', notice: 'User chat was successfully updated.' }
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
      # TODO: when current user removes someone, dont go to dms
      # TODO: current_user.private_project.id
      format.html do
        redirect_to "/chat/#{current_user.direct_message_project.id}/#{current_user.direct_message_project.first_chat.id}",
                    notice: 'User chat was successfully destroyed.'
      end
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
