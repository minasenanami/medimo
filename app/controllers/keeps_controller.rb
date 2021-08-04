class KeepsController < ApplicationController
  def create
    current_user.keeps.create!(article_id: params[:article_id])
    @article = Article.find(params[:article_id])
  end

  def destroy
    current_user.keeps.find_by(article_id: params[:article_id]).destroy!
    @article = Article.find(params[:article_id])
  end
end
