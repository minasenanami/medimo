class HomeController < ApplicationController
  def index
    @articles = Article.published.order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
    @q = Article.published.ransack(params[:q])
  end
end
