class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to user_article_path(current_user, @article)
    else
      redirect_to user_article_path(current_user, @article)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :article_id, :user_id)
  end
end
