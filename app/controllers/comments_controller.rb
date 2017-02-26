class CommentsController < ApplicationController



    def new
      @comment = Comment.new
    end


    def create
      @post = Post.find params[:post_id]
      comment_params = params.require(:comment).permit(:name, :body)
      @comment = Comment.new comment_params
      @comment.post = @post
      if @comment.save
        redirect_to post_path(@post), notice: 'Answer created!'
      
      else
        flash.now[:alert] = 'Please fix errors below'
        render :new
      end
    end

    private

    def comment_params
      params.require(:post).permit([:name, :body])
    end

end
