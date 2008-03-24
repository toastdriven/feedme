# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '968950020761706555ec8cff0354afad'
  
  
  protected
  def ensure_logged_in
    if session[:user]
      if VALID_USERS.has_key? session[:user]
        return true
      end
    end
    
    redirect_to :controller => 'login', :action => 'login'
  end
end
