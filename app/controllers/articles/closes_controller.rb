class Articles::ClosesController < ApplicationController
  before_action :correct_user, only: [:show]
  def index
    @closed_articles = current_user.articles.closed.order(updated_at: :desc)
  end

  def show
    # @article = current_user.articles.closed.find(params[:id])
  end

  def correct_user
    @article = current_user.articles.closed.find_by(id: params[:id])
    unless @article
      redirect_to root_path
    end
  end
end
