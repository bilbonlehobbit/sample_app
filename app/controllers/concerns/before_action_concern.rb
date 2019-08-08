module Before_Action_Concern
  extend ActiveSupport::Concern
  included do
    before_action :require_sign_in
    before_action :correct_user

  end
end
