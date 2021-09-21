module ApplicationHelper
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
      user.avatar
    when "profile"
      user.avatar
    when "list"
      user.avatar
    end
  end
end
