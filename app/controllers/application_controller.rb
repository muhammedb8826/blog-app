class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :update_allowed_parameters, if: :devise_controller?
 
  protected
end
