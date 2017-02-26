class PostsController < ApplicationController
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
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit([:title, :body, :category_id])
  end

end
