class HomeController < ApplicationController
  def index
    @articles = Article.published.order(updated_at: :desc)
    @q = Article.published.ransack(params[:q])
  end
end
