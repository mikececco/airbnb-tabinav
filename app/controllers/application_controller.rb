class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone_number profile_pic role])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone_number profile_pic role email])
  end

  private

  def skip_pundit?
    # params[:controller] == "pages" && params[:action] == "home"
    # params[:controller] == "flats" && params[:action] == "index"
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^flats$)|(^bookings$)/
    # params[:controller] == "pages" && params[:action] == "home" ||
    # params[:controller] == "flats" && params[:action] == "index"
  end

  def user_not_authorized
    redirect_back(fallback_location: root_path, alert: "You are not authorized to perform this action.")
  end
end
