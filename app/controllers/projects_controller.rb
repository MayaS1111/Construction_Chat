# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects or /projects.json
  def index; end

  # GET /projects/1 or /projects/1.json
  def show; end

  # GET /projects/new
  def new; end

  # GET /projects/1/edit
  def edit; end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.status = params.fetch('status')
    @project.project_type = 'public'
    @project.owner_id = current_user.id

    respond_to do |format|
      if @project.save
        @project.create_main_chat(current_user)
        format.html do
          redirect_to "/chat/#{@project.id}/#{@project.first_chat.id}", notice: 'Project was successfully created.'
        end
        format.json { render :show, status: :created, location: @project }
      else
        format.html do
          redirect_to "/chat/#{current_user.direct_message_project.id}/#{current_user.direct_message_project.first_chat.id}", alert: 'Project needs name to be created', status: :unprocessable_entity
        end
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project.status = params.fetch('status')

    respond_to do |format|
      if @project.update(project_params)
        format.html do
          redirect_to "/chat/#{@project.id}/#{@project.first_chat.id}",
                      notice: 'Project was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    respond_to do |format|
      @project.destroy!
      format.html do
        redirect_to "/chat/#{first_project.id}/#{first_chat.id}", notice: 'Project was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:owner_id, :name, :description, :location, :member_count, :project_type, :status,
                                    chats_attributes: %i[name description project_id])
  end
end
