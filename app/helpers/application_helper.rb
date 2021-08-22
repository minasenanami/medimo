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

  def account_owner?(user)
    current_user.id.to_s == params[:id]
  end

  def creation_date(article)
    l article.created_at, format: :medium
  end

  def update_data(article)
    l article.updated_at, format: :medium
  end

  def user_icon(user, size)
    case size
    when "mypage"
      user.avatar.variant(resize: "72x72").processed
    when "profile"
      user.avatar.variant(resize: "64x64").processed
    when "header"
      user.avatar.variant(resize: "32x32").processed
    when "list"
      user.avatar.variant(resize: "25x25").processed
    end
  end
end
