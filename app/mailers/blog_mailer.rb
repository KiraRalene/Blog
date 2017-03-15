class BlogMailer < ApplicationMailer

  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
    if @owner.present?
      mail(to: @owner.email, subject: 'You got a new comment on your post')
    end
  end
end
