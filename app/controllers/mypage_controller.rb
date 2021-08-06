class MypageController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.published.order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
  end
end
