class HomeController < ApplicationController
  def index
    @articles = Article.published.includes(:tag_maps, :tags, :keeps,
                                           user: { avatar_attachment: :blob }).order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
    @q = Article.published.ransack(params[:q])
  end
end
