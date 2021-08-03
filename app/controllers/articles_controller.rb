class ArticlesController < ApplicationController
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
  end

  def show
    @article = Article.published.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :images, :status)
    end
end
