# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name phone_number profile_image job_title])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name phone_number profile_image job_title])
  end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end
end
