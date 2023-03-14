class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(user_name: params[:session][:login_id]) || User.find_by(email: params[:session][:login_id])
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]    
      log_in user
      redirect_to forwarding_url || user
    else
      flash.now[:danger] = 'Invalid email/username/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def confirm_logout
  end

  def destroy
  	reset_session
    redirect_to root_path
  end
end
