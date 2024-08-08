class UsersController < ApplicationController
  before_action :set_user, only: %i[ profile all_users members ]
  
  
  private

    def set_user
      @users = User.all
      if params[:id]
        @user = User.find_by!(id: params.fetch(:id))
        
      else
        @user = current_user
        if params[:user]
          @user_profile = User.find_by!(id: params.fetch(:user))
        end
      end
    end
end
