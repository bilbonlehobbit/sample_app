module Skip_Before_Action_Concern
  extend ActiveSupport::Concern
  included do
    skip_before_action :require_sign_in , only: [:new, :create]
    skip_before_action :correct_user, only: [:new, :create, :destroy, :index] 
    
  end
end
  
