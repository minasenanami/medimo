class MypageController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  # 保存した記事一覧のページ
  def index
    @articles = current_user.kept_articles.includes(:tag_maps, :tags, :keeps,
                                                    user: { avatar_attachment: :blob }).order("keeps.created_at desc").page(params[:page]).per(PER_PAGE)
  end

  def show
    @user = User.with_attached_avatar.find(params[:id])
    @articles = @user.articles.published.includes(:keeps, :tags, :tag_maps).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    @draft_articles = @user.articles.draft.order(created_at: :desc).limit(PER_PAGE)
    @closed_articles = @user.articles.closed.order(created_at: :desc).limit(PER_PAGE)
  end
end
