class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.chats.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.status = params.fetch("status")
    @project.project_type = "public"
    @project.owner_id = current_user.id

    respond_to do |format|
      if @project.save
        @chat = Chat.create(project_id: @project.id, name: "Main", description: "This chat is for all members")
        UserChat.create(user_id: current_user.id, chat_id: @chat.id)
        format.html { redirect_to "/home", notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project.status = params.fetch("status")

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to "/chat/#{@project.id}/#{current_user.projects.first.chats.first.id}", notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    debugger
    chats_to_delete = Chat.where(project_id: @project.id)
    user_chats_to_delete = []
    messages_to_delete  = []

    chats_to_delete.each do |chat|
      user_chats_to_delete = UserChat.where(chat_id: chat.id)
    end
    user_chats_to_delete.each do |user_chat|
      messages_to_delete = Message.where(user_chat_id: user_chats_to_delete)
    end

    messages_to_delete.each do |message|
      message.destroy!
    end
    user_chats_to_delete.each do |user_chat|
      user_chat.destroy!
    end

    chats_to_delete.each do |chat|
      chat.destroy!
    end
    
    first_project = current_user.projects.first
    first_chat = first.project.chats.first
    respond_to do |format|
      @project.destroy!
      format.html { redirect_to "/chat/#{first_project.id}/#{first_chat.id}", notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:owner_id, :name, :description, :location, :member_count, :project_type, :status, chats_attributes: [:name, :description, :project_id])
    end
end
