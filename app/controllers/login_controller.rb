class LoginController < ApplicationController
  def login
    session[:user] = nil
    
    if request.post?
      username = params[:username]
      password = params[:password]
      
      if VALID_USERS.has_key? username
        if VALID_USERS[username] == password
          session[:user] = username
          redirect_to :controller => 'rss_feeds'
        end
      end
      
      flash[:error] = "Close but no cigar!"
    end
  end
  
  def logout
    session[:user] = nil
    redirect_to :action => 'login'
  end
end
