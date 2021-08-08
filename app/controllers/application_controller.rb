class ApplicationController < ActionController::Base
  # deviseコントローラーのストロングパラメータに追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  PER_PAGE = 10

  def after_sign_in_path_for(resource)
    mypage_path(current_user)
  end

  protected

    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofileとavatarのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :avatar])
    end
end
