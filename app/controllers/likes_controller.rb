class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: [:destroy]
  before_action :find_post, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.liked_posts
  end

  def create
    if cannot? :like, @post
      redirect_to post_path(@post), alert:"Really your want to like your own post?"
      return
    end

    like = Like.new(user: current_user, post: @post)

    if like.save
      redirect_to post_path(@post), notice: "Thanks for liking"
    else
      redirect_to post_path(@post), notice: "Can't Like"
    end
  end

  def destroy
    if cannot? :like, @like.post
      redirect_to post_path(@like.post), alert: 'how are you unliking your own question?'
      return
    end

    redirect_to(
      post_path(@like.post),
      @like.destroy ? {notice: 'Like removed!'} : {alert: @likes.errors.full_messages.join(", ")}
    )
  end

  private

  def find_like
    @like ||= Like.find(params[:id])
  end

  def find_post
    @post ||= Post.find(params[:post_id])
  end
end
