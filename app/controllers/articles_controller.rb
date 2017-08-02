class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @user = current_user
    @article = Article.new
  end

  def create
    @user = current_user
    @article = @user.articles.build(article_params)

    if @article.save
      redirect_to user_article_path(current_user, @article)
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :link, category_ids: [], categories_attributes: [:name])
  end

end
