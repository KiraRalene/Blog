class CommentsController < ApplicationController
    before_action(:authorize, only: [:edit, :destroy, :update])
    before_action :authenticate_user!, except: [:show, :index]
    def new
      @comment = Comment.new
    end


    def create
      @post = Post.find params[:post_id]
      @comment = Comment.new comment_params
      @comment.user = current_user
      @comment.post = @post
      if @comment.save
        redirect_to post_path(@post), notice: 'Comment created!'

      else
        flash.now[:alert] = 'Please fix errors below'
        render :new
      end
    end

    # def edit
    #   @post = Post.find(params[:post_id])
    #   @comment = @post.comments.find(params[:id])
    # end
    #
    # def update
    #   @comment = Comment.find params[:id]
    #   if @comment.update comment_params
    #     redirect_to comment_path(@comment)
    #   else
    #     render :edit
    #   end
    # end

    def destroy
      comment = Comment.find params[:id]
      comment.destroy
      redirect_to post_path(params[:post_id]), notice: 'comment deleted'
    end


    private

    def comment_params
      params.require(:comment).permit([:name, :body])
    end

    def authorize
      @comment = Comment.find params[:id]
      unless can?(:manage, @comment)
        redirect_to posts_path, alert: 'not authorized'
      end
    end

end
