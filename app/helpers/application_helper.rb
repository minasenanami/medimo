module ApplicationHelper
  def max_width
    if controller_name == "articles" && action_name == "show"
      "mw-md"
    elsif devise_controller?
      "mw-sm"
    else
      "mw-xl"
    end
  end

  def author?(article)
    article.user == current_user
  end

  def creation_date(article)
    l article.created_at, format: :medium
  end

  def update_data(article)
    l article.updated_at, format: :medium
  end
end
