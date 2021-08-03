class LikesController < ApplicationController
  def create
    current_user.likes.create!(article_id: params[:article_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.likes.find_by(article_id: params[:article_id]).destroy!
    redirect_back(fallback_location: root_path)
  end
end
