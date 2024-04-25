# app/controllers/application_controller.rb
class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email], status: 'Active')

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      @user.update(last_login: Time.current)
      redirect_to users_path
    else
      flash[:alert] = "Login failed"
      redirect_to new_user_session_path
    end
  end

  def destroy
    puts 'HHHHHHHH'
    # session[:user_id] = nil
    # redirect_to new_user_session_path
    

    # User.find(session[:user_id]).destroy      
    session[:user_id] = nil         
    redirect_to root_path
  end
end