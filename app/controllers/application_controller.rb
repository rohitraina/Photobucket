class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  private
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end 
end
