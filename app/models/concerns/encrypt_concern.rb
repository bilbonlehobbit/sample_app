module EncryptConcern
  extend ActiveSupport::Concern

  included do
    def has_password?(password_soumis)
      encrypted_password == encrypt(password_soumis)
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
end
