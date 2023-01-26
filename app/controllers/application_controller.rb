class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false

  private

    #管理者

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

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    #api

    def data_owner(data)
      unless current_api_v1_user == data.user
        render json: { status: "ERROR", message: "Not current_user's data"}
      end
    end

    def share_data(data)
      unless data.user_id == nil
        render json: { status: "ERROR", message: "Not share data"}
      end
    end
end
