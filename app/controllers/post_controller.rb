class PostController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.post.new(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to post_index_path
    else
      render 'new'
    end
  end

  private 

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
