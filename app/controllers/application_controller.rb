class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to root_url, alert: "ログインしてください"
    end
  end
end
