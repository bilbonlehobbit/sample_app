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

end
