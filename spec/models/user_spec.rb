require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @attr = { :nom =>"Example User",
      :email =>"Example.User@example.com",
      :password => "foobar",
      :password_confirmation => "foobar" }
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
  describe "password validation" do

    it "devrait avoir un mot de passe" do
      expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).to_not be_valid
    end

    it "devrait avoir une confirmation de password == password" do
      expect(User.new(@attr.merge(:password_confirmation => "invalid"))).to_not be_valid
    end

    it "devrait rejeter les mots de passe (trop) courts" do
      short = "a" * 5
      hash = User.new(@attr.merge(:password => short, :password_confirmation => short))
      #User.new(hash).should_not be_valid
      expect(hash).not_to be_valid
    end

    it "devrait rejeter les (trop) longs mots de passe" do
      long = "a" * 41
      hash = User.new(@attr.merge(:password => long, :password_confirmation => long))
      expect(hash).to_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end
    it "devrait avoir un attribut mot de passe crypte" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "devrait definir le mot de passe crypte" do
      expect(@user.encrypted_password).not_to be_blank
    end
    describe "methode has_password" do

      it "doit => true si les mdp coincident" do
        expect(@user.has_password?(@attr[:password])).to be_truthy
      end

      it "doit => false si les mdp divergent" do
        expect(@user.has_password?("invalide")).to be_falsey
      end
    end
    describe "authenticate methode" do

      it "devrait retourner nil en cas d'erreur email/mdp" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        expect(wrong_password_user).to be_nil
      end

      it "devrait retourner nil quand un email n'a pas d'utilisateur" do
        non_existant_user = User.authenticate("bar@foo.com", @attr[:password])
        expect(non_existant_user).to be_nil
      end

      it "devrait retourner un utilisateur en cas de succes" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        expect(matching_user).to eq(@user)
      end
    end
  end

	describe "attribut admnin" do
 
	before(:each) do
	  @user = User.create!(@attr)
	end

	it "devrait confirmer l'existence d'admin" do
	  expect(@user).to respond_to(:admin)
	end

	it "ne devrait pas etre admin par defaut" do
	  expect(@user).not_to be_admin
	end

	it "devrait pouvoir creer un admin" do
	  @user.toggle!(:admin)
	  expect(@user).to be_admin
	end
end
end
