class KeepsController < ApplicationController
  def create
    current_user.keeps.create!(article_id: params[:article_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.keeps.find_by(article_id: params[:article_id]).destroy!
    redirect_back(fallback_location: root_path)
  end
end
