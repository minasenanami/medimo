class MypageController < ApplicationController
  # 保存した記事一覧のページ
  def index
    @articles = current_user.kept_articles.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.published.order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
  end
end
