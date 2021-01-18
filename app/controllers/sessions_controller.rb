class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if !!@user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      message =  "Something haven't worked well, make sure you filled everything correctly"
      redirect_to login_path, notice: message
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

end
