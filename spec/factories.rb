require 'factory_bot'

# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
FactoryBot.define do 
 factory :user do |user|
  user.nom {"User Example"}
  user.email {"user@example.com"}
  user.password {"foobar"}
  user.password_confirmation {"foobar"}
end
end


