class PostController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def create
    @post = current_user.post.new(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to post_index_path
    else
      render 'new'
    end
  end

  private

  def require_login
    return if logged_in?

    flash[:error] = 'You must be logged in to access this section'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
