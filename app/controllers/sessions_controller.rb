class SessionsController < ApplicationController
  def new
   
  end

  def create
      user = User.find_by(email: params[:session][:email].downcase)
      if !user.nil? and user.authenticate(params[:session][:password])
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_to post_index_path
      else
          flash[:danger] = 'Invalid email/password combination.'
          render 'new'
      end
  end
  
  def destroy
      log_off if logged_in?
      redirect_to root_path
  end
end
