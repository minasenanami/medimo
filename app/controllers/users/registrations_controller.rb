class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[profile_update update destroy] # rubocop:disable Rails/LexicallyScopedActionFilter

  def ensure_normal_user
    if current_user.email == "guest@example.com"
      redirect_to mypage_path(current_user), alert: "ゲストユーザーは更新・削除はできません。"
    end
  end

  def profile_edit
  end

  def profile_update
    current_user.assign_attributes(account_update_params)
    if current_user.save
      redirect_to mypage_path(current_user), notice: "プロフィールを更新しました"
    else
      render "profile_edit"
    end
  end

  protected

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :avatar])
    end
end
