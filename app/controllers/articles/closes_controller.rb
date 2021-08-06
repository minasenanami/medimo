class Articles::ClosesController < ApplicationController
  def index
    @closed_articles = current_user.articles.closed.order(updated_at: :desc)
  end

  def show
    @article = current_user.articles.closed.find(params[:id])
  end
end
