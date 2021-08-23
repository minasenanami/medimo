class Articles::ClosesController < ApplicationController
  before_action :closed_owner, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:index, :show]
  def index
    @closed_articles = current_user.articles.closed.order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def show
    @article_tags = @article.tags
  end

  def destroy
    @article.destroy!
    @article.images.purge
    redirect_to mypage_path(current_user)
  end

  private

    def closed_owner
      @article = current_user.articles.closed.find_by(id: params[:id])
      unless @article
        redirect_to root_path, alert: "指定した記事は閲覧できません"
      end
    end
end
