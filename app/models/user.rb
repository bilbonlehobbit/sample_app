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

  attr_accessor :password
email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

 validates :nom, :presence => true,
		 :length => {:maximum => 50 }                  
 validates :email, :presence => true,
		   :format => { :with => email_regex },
		   :uniqueness => {:case_sensitive => false }
validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  before_save :encrypt_password

	def has_password?(password_soumis)
	encrypted_password == encrypt(password_soumis)
	end

	def self.authenticate(email, submitted_password)
	#equivalent a User.authenticate =>> methode de classe se refere a la classe elle meme	
	#different de self.salt qui est une instance de classe
	user = find_by_email(email)
	return nil if user.nil?
	return user if user.has_password?(submitted_password)
	end

   private 

	def encrypt_password
      self.salt = make_salt if new_record?
	self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
      secure_hash("#{salt}--#{string}")
	end
 
	def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
        end

        def secure_hash(string)
        Digest::SHA2.hexdigest(string)
        end
      end

