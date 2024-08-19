# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :set_user, only: %i[profile all_users members]
  before_action :set_profile_user, only: %i[profile]

  def home; end

  private

  def set_user
    @users = User.all
    @user = if params[:id]
              User.find_by!(id: params.fetch(:id))
            else
              current_user
            end
  end

  def set_profile_user
    @user_profile = if params[:user] && params[:user] == 'admin'
                      current_user
                    else
                      User.find_by!(id: params.fetch(:user))
                    end
  end
end
