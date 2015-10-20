class ArticlesController < ApplicationController
  before_filter :set_article, only: [:show,:edit,:update,:destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article has been updated"
      redirect_to @article
    else
      flash.now[:danger] = "Article has not been updated"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end
  end

    def show
    end
    def edit
    end

  private

  def article_params
    params.require(:article).permit(:body, :title)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
