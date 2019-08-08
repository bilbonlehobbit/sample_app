module AuthenticateConcern
  extend ActiveSupport::Concern

  included do
    def self.authenticate(email, password_soumis)
      #equivalent a User.authenticate =>> methode de classe se refere a la classe elle meme
      #different de self.salt qui est une instance de classe
      user = find_by_email(email)
      return nil if user.nil?
      return user if user.has_password?(password_soumis)
    end

    def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end
end
