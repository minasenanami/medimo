class Articles::DraftsController < ApplicationController
  before_action :draft_owner, only: [:show, :destroy]
  before_action :authenticate_user!, only: %i[index show]

  def index
    @draft_articles = current_user.articles.draft.order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def show
  end

  def destroy
    @article.destroy!
    @article.images.purge
    redirect_to mypage_path(current_user)
  end

  private

    def draft_owner
      @article = current_user.articles.draft.find_by(id: params[:id])
      unless @article
        redirect_to root_path, alert: "指定した記事は閲覧できません"
      end
    end
end
