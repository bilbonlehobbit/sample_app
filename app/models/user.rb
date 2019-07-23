# == Schema Information
# Schema version: 20190722205042
#
# Table name: users
#
#  id         :integer(8)      not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ApplicationRecord

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

 validates :nom, :presence => true,
		 :length => {:maximum => 50 }                  
 validates :email, :presence => true,
		   :format => { :with => email_regex },
		   :uniqueness => {:case_sensitive => false }

	def create
	    User.create(user_params)
	end

    private
	def user_params
	    params.require(:user).permit(:nom, :email)
	end
     end
