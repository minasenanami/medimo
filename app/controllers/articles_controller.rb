class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @articles = Article.published.order(updated_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.create!(article_params)
    redirect_to root_path
  end

  def edit
    if @article.user == current_user
      render :edit
    else
      redirect_to root_path, alert: "記事の編集はできません"
    end
  end

  def show
    @article = Article.published.find(params[:id])
  end

  def update
    @article.update!(article_params)
    redirect_to article_path
  end

  def destroy
    @article.destroy!
    redirect_to root_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :images, :status)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
