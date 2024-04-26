# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if current_user.blank?
        render plain: '401 Unauthorized.', status: :unauthorized
    end
    @users = User.all
  end

  def new
    @user = User.new
  end

  def block
      selected_user_ids = params[:user_ids]

    puts "Selected User IDs: #{params.inspect}"
    puts "Current User: #{current_user.inspect}"
       if current_user.status == 'Blocked'
         redirect_to logout_path
        return
       end


    if params.has_key?(:unblock)
      # uncomment
    # if params[:unblock].present?
     
      unblock(params)
    # elsif params[:remove].present?
    elsif params.has_key?(:remove)

      delete(params)
    else
      selected_user_ids = params[:user_ids]
      puts "Selected User IDs: #{selected_user_ids.inspect}"
      if selected_user_ids.present?
      User.where(id: selected_user_ids).update_all(status: 'Blocked')
      flash[:notice] = "Selected users blocked successfully"
        else
          flash[:alert] = "Please select at least one user to block"
      end
    end
    if current_user.blank?
        redirect_to logout_path
        return
    end
  #   if current_user.blank?
  #     redirect_to logout_path
  #     return
  # end
  redirect_to users_path
    

  # selected_user_ids = params[:user_ids]
  #   puts "Selected User IDs: #{selected_user_ids.inspect}"

  # if selected_user_ids.present?
  #   User.where(id: selected_user_ids).update_all(status: 'Blocked')
  #   flash[:notice] = "Selected users blocked successfully"
  # else
  #   flash[:alert] = "Please select at least one user to block"
  # end
  # redirect_to users_path

 
  end

  def unblock(params)

    # Implement block logic for selected users
    selected_user_ids = params[:user_ids]
    puts "Selected User IDs: #{selected_user_ids.inspect}"
    if selected_user_ids.present?
      User.where(id: selected_user_ids).update_all(status: 'Active')
      flash[:notice] = "Selected users unblocked successfully"
    else
      flash[:alert] = "Please select at least one user to unblock"
    end
  
  end

  def delete(params)
    # Implement block logic for selected users
    selected_user_ids = params[:user_ids]
    puts "Selected User IDs: #{selected_user_ids.inspect}"
    if selected_user_ids.present?
      User.where(id: selected_user_ids).destroy_all()
      flash[:notice] = "Selected users deleted successfully"
    else
      flash[:alert] = "Please select at least one user to delete"
    end
  end

  def create
    # puts 'Hellooooo'
    @user = User.new(user_params)
    @user.status = "Active"
    @user.registration_time = Time.current
    @user.last_login = Time.current
    if @user.save
      flash[:notice] = "User created successfully"
      session[:user_id] = @user.id 
      # redirect_to users_path
      redirect_to user_sessions_new_path

    else
      flash[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation  )
  end
end