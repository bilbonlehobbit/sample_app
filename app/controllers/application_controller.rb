class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include Before_Action_Concern
  include Require_Sign_in_Concern
  include Correct_User_Concern 
  include Users_Params_Concern

end
