class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def email
    UserMailer.welcome_email(current_user).deliver_now
    redirect_to root_path, notice: 'An email has been sent!'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
  
end
