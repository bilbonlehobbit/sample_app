module Admin_User_Concern
  extend ActiveSupport::Concern
  included do
before_action :admin_user,   :only => :destroy
   private

     def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  end
end
