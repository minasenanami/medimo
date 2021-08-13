class MypageController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  # 保存した記事一覧のページ
  def index
    @articles = current_user.kept_articles.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def show
    @user = User.with_attached_avatar.find(params[:id])
    @articles = @user.articles.published.includes(:keeps, :tags, :tag_maps).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end
end
