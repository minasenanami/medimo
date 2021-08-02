class ArticlesController < ApplicationController
  def index
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
