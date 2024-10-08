# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_project, only: %i[index create]
  before_action :set_chat, only: %i[show edit update destroy]
  before_action :set_user, only: %i[create_private_chat]
  before_action :set_direct_message_project, only: %i[index create_private_chat]

  # GET /chats or /chats.json
  def index
    @current_chat = Chat.find(params[:chat_id]) if params[:chat_id].present?

    @private_chats = current_user.chats.private_projects
    @public_chats = current_user.chats.for_project(@project)

    @new_chat = @project.chats.new
    @chat_bot = User.where(id: '0')

    @highlighted_project_id = params[:selected_project]
    @highlighted_chat_id = params[:selected_chat]
  end

  # GET /chats/1 or /chats/1.json
  def show; end

  # GET /chats/new
  def new;end

  # GET /chats/1/edit
  def edit; end

  def messages
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(:created_at)
    respond_to(&:js)
  end

  def create_private_chat
    common_private_chat = current_user.chats.filtered_common_private_chats(current_user, @user).first

    if common_private_chat
      respond_to do |format|
        format.html do
          redirect_to "/chat/#{common_private_chat.project_id}/#{common_private_chat.id}", alert: 'You already have a private chat with this user.'
        end
      end
    else
      @chat = Chat.new.private_chat(current_user, @user, @direct_message_project)

      respond_to do |format|
        if @chat.save
          format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat.id}", notice: 'Chat was successfully created.' }
        else
          format.json { render json: { success: false, errors: @chat.errors.full_messages } }
        end
      end
    end
  end

  # POST /chats or /chats.json
  def create
    @current_chat = @chat
    @chat = @project.chats.new(chat_params)

    respond_to do |format|
      if @chat.save
        UserChat.create(user_id: current_user.id, chat_id: @chat.id)

        format.html { redirect_to "/chat/#{@chat.project_id}/#{@chat.id}", notice: 'Chat was successfully created.' }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html do
          redirect_to "/chat/#{current_user.direct_message_project.id}/#{current_user.direct_message_project.first_chat.id}", alert: 'Chat needs name to be created', status: :unprocessable_entity
        end
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html do
          redirect_to "/chat/#{@chat.project_id}/#{@chat.id}", notice: 'Chat was successfully updated.'
        end
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
      format.html do
        redirect_to "/chat/#{@chat.project_id}/#{@chat_list_ids[0]}", notice: 'Chat was successfully destroyed.'
      end
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

  def set_direct_message_project
    @direct_message_project = current_user.projects.private_type
  end

  def chat_params
    params.require(:chat).permit(:project_id, :name, :description, user_chats_attributes: %i[chat_id user_id])
  end
end
