class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order
  before_action :masquerade_user!
  before_action :store_current_location, :unless => :devise_controller? 
  
  def store_current_location
    store_location_for(:user, request.url) unless request.xhr?
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

end
