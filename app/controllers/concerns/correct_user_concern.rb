module Correct_User_Concern
  extend ActiveSupport::Concern
  included do
    private 
 def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
   
    
    def current_user?(user)
      user == current_user
    end
  end
end