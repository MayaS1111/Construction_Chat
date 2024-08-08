class UsersController < ApplicationController
  before_action :set_user, only: %i[ profile all_users members ]
  before_action :set_profile_user, only: %i[ profile ]
  
  
  private

    def set_user
      @users = User.all
      if params[:id]
        @user = User.find_by!(id: params.fetch(:id))
      else
        @user = current_user
      end
    end
    def set_profile_user
      if params[:user] && params[:user] == "admin"
        @user_profile = current_user
      else
        @user_profile = User.find_by!(id: params.fetch(:user))
      end
    end
end
