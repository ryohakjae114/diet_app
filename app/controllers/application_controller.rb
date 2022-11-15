class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to new_admin_session_url, alert: "ログインしてください"
    end
  end

  def current_admin
    if admin_signed_in?
      Admin.find_by(id: warden.user.id)
    end
  end

  def admin_signed_in?
    !!(warden.user)
  end
end
