class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include EncryptConcern
  include AuthenticateConcern
end
