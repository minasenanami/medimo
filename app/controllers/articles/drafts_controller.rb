class Articles::DraftsController < ApplicationController
before_action :correct_user, only: [:show]

  def index
    @draft_articles = current_user.articles.draft.order(updated_at: :desc)
  end

  def show
  end
end
