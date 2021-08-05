class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy] # rubocop:disable Rails/LexicallyScopedActionFilter

  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーは更新・削除はできません。"
    end
  end
end