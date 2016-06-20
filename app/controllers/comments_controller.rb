class CommentsController < ApplicationController
  include SessionHelper

  def _new
    @comment = Comment.new
    render :_new, layout: false, locals: {comment: @comment}
  end

  def create
    article = Article.find(params[:blog_id])
    @comment = article.comments.new(content: params[:content], commenter_id: current_user.id)
    if @comment.save
      if request.xhr?
        render :_comment, layout: false, locals:{comment: @comment}
      else
        redirect_to blog_path(article)
      end
    else
      @errors = @user.errors.full_messages
      redirect_to blog_path(article)
    end
  end

end
