class UsersController < ApplicationController
  skip_before_action :ensure_user_login

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    user_new = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      role: params[:role],
    )
    if user_new.save
      if not user_new.is_customer(user_new.id)
        redirect_to clerks_path
      else
        session[:current_user_id] = user_new.id
        redirect_to "/home"
      end
    else
      flash[:error] = user_new.errors.full_messages.join(", ")
      if user_new.role == "customer"
        redirect_to new_user_path
      else
        redirect_to new_clerk_path
      end
    end
  end
end
