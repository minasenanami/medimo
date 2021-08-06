class Articles::DraftsController < ApplicationController
  def index
    @draft_articles = current_user.articles.draft.order(updated_at: :desc)
  end
end
