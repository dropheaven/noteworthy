class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all
		@user = User.search(params[:user])
		if @user
			redirect_to user_path(@user)
		else
			'Username does not exist'
		end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @user = current_user
    @article = @user.articles.build
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
    params.require(:article).permit(:title, :link, :category_name, category_ids:[])
  end

end
