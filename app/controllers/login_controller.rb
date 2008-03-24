class LoginController < ApplicationController
  def login
    session[:user_id] = nil
    if request.post?
      
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
