class Articles::DraftsController < ApplicationController
  before_action :draft_owner, only: [:show]
  before_action :authenticate_user!, only: %i[index show]

  def index
    @draft_articles = current_user.articles.draft.order(updated_at: :desc)
  end

  def show
    @article = current_user.articles.draft.find(params[:id])
  end

  private

    def draft_owner
      @article = current_user.articles.draft.find_by(id: params[:id])
      unless @article
        redirect_to root_path, alert: "指定した記事は閲覧できません"
      end
    end
end
