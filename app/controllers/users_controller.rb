class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(params[:user_id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created'
      log_in @user
      redirect_to post_index_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
