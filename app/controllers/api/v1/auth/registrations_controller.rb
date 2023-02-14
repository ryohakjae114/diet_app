class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private
    def sign_up_params
      params.require(:registration).permit(authenticated_params)
    end
    def account_update_params
      params.require(:registration).permit(authenticated_params)
    end

    def authenticated_params
      [:nickname, :email, :gender, :height, :weight, :password, :password_confirmation]
    end
end
