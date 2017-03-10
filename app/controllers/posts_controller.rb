class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action(:authorize, only: [:edit, :destroy, :update])
  def show
    @post = Post.find params[:id]
    @category = Category.find_by_id(@post.category_id.to_i)
    @comment = Comment.new
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = 'Post created successfully'
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find params[:id]
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit([:title, :body, :category_id])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize

    if cannot?(:manage, @post)
      redirect_to posts_path, alert: 'not authorized'
    end
  end
end
