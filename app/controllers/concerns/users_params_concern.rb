module Users_Params_Concern
  extend ActiveSupport::Concern
  included do
    private
    def user_params
      params.require(:user).permit(:nom, :email, :password, :password_confirmation)
    end
  end
end