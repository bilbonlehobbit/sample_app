require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
 		@attr = { :nom =>"Example User", :email =>"Example.User@example.com" }
	end
 
 	it "devrait creer une nouvelle instance" do
  		User.create!(@attr)
	end
	
	it "devrait exiger un nom" do
	 no_name = User.new(@attr.merge(:nom =>""))
	 expect(no_name).not_to be_valid
	end

	it "devrait exiger un email" do
	 no_mail = User.new(@attr.merge(:email =>""))
	 expect(no_mail).not_to be_valid
	end
	
	it "devrait rejeter les nom trop long" do
	nom_trop_long = "a" * 51 
 	nom_trop_long = User.new(@attr.merge(:nom => nom_trop_long))
	expect(nom_trop_long).not_to be_valid
	end

	it "devrait accepter les bons format d'email" do
	valid_email = %w[user.example@example.com UsEr_EXAMPLE@example.fr.org user@user.example.fr]
	valid_email.each do |valid|
	valid_email_user = User.new(@attr.merge(:email => valid))
	expect(valid_email_user).to be_valid
	end
     end

	it "devrait rejeter les mauvais format d'email" do
	invalid_email = %w[user,example@example.com UsEr.EXAMPLE.example.fr user@user.example.]
	invalid_email.each do |invalid|
	invalid_email_user = User.new(@attr.merge(:email => invalid))
	expect(invalid_email_user).not_to be_valid
	end
     end
	
	it "devrait rejeter un email double" do
	User.create!(@attr)
	user_duplicate = User.new(@attr)
	expect(user_duplicate).not_to be_valid 
	end

	it "devrait rejeter les email jusqu'a la casse" do
	upcase_email = @attr[:email].upcase
	User.create!(@attr.merge(:email => upcase_email))
	user_duplicate = User.new(@attr)
	expect(user_duplicate).not_to be_valid
	end
      end

