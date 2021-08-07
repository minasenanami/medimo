class Articles::ClosesController < ApplicationController
  before_action :closed_owner, only: [:show]
  before_action :authenticate_user!, only: %i[index show]
  def index
    @closed_articles = current_user.articles.closed.order(updated_at: :desc)
  end

  def show
    @article = current_user.articles.closed.find(params[:id])
  end

  private

    def closed_owner
      @article = current_user.articles.closed.find_by(id: params[:id])
      unless @article
        redirect_to root_path, alert: "指定した記事は閲覧できません"
      end
    end
end
