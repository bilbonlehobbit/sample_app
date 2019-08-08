module ValidatesConcern
  extend ActiveSupport::Concern

  included do

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :nom, :presence => true,
    :length => {:maximum => 50 }
    validates :email, :presence => true,
    :format => { :with => email_regex },
    :uniqueness => {:case_sensitive => false }
    validates :password, :presence     => true,
    :confirmation => true,
    :length       => { :within => 6..40 }
  end
end
