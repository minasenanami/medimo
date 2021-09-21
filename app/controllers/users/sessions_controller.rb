class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    sign_in(User.guest)
    redirect_to mypage_path(current_user), notice: "ゲストユーザーとしてログインしました。"
  end
end
