class UsersController < ApplicationController
  before_action :set_user, only: %i[ profile ]
  

  private

    def set_user
      if params[:id]
        @user = User.find_by!(id: params.fetch(:id))
      else
        @user = current_user
      end
    end
end
