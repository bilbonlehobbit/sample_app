module Require_Sign_in_Concern
  extend ActiveSupport::Concern

  included do
    def require_sign_in
      unless signed_in?
        store_location
        flash[:error] = "Vous devez etre connecté(e)"
        redirect_to signin_path # halts request cycle
      end
    end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
    end

    private

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
  end
end
