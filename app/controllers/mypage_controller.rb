class MypageController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  # 保存した記事一覧のページ
  def index
    @articles = current_user.kept_articles.includes(:tag_maps, :tags, :keeps,
                                                    user: { avatar_attachment: :blob }).order("keeps.created_at desc").page(params[:page]).per(PER_PAGE)
  end

  def show
    check_blobs
    @user = User.with_attached_avatar.find(params[:id])
    @articles = @user.articles.published.includes(:keeps, :tags, :tag_maps).order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    @draft_articles = @user.articles.draft.order(updated_at: :desc).limit(PER_PAGE)
    @closed_articles = @user.articles.closed.order(updated_at: :desc).limit(PER_PAGE)
  end

  private

    # 記事作成時にD&Dしたが使用せずにactive_storage_blobs内に浮遊しているデータの削除
    def check_blobs
      ActiveStorage::Blob.includes(:variant_records, :preview_image_attachment).unattached.each(&:purge) if ActiveStorage::Blob.unattached.any?
    end
end
