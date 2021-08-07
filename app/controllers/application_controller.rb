class ApplicationController < ActionController::Base
  # deviseコントローラーのストロングパラメータに追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  PER_PAGE = 10

  protected

    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofileとavatarのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :avatar])
    end

    def correct_user
      @article = current_user.articles.closed.find_by(id: params[:id])
      unless @article
        redirect_to root_path, alert: "指定した記事は閲覧できません"
      end
    end
end
