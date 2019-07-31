require 'rails_helper'

RSpec.describe "Users", type: :request do
include Capybara::RSpecMatchers 
include Capybara::DSL	

 describe "Une inscription" do

    describe "ratée" do
             
	it "ne devrait pas créer un nouvel utilisateur" do
		visit signup_path
           expect{ 
	fill_in "Nom", :with => ""
        fill_in "Email", :with => ""
        fill_in "Password", :with => ""
        fill_in "Confirmation", :with => ""
	click_button  
	render_template("users/new")
	have_selector("div#error_explanation") 
     }.not_to change(User, :count)	    
	end
    end
	describe "reussite" do

	it "devrait creer un nouvel utilisateur" do
		visit signup_path		
expect{
	fill_in "Nom", :with => "User Example"
        fill_in "Email", :with => "user@exmaple.com"
        fill_in "Password", :with => "foobar"
        fill_in "Confirmation", :with => "foobar"
	click_button  
	have_selector("div.flash.success", :content => "Bienvenue")
        render_template('users/show')
       }.to change(User, :count).by(1)
	end
     end   
  end
 	describe "identification /deconnexion" do

     describe "echec connexion /deconnexion" do

	it "ne devrait pas identifier l'utilisateur" do 
	visit signin_path 
	fill_in "Email", :with => ""
	fill_in "Password", :with => ""
	click_button
        #response.should have_selector("flash.error", :text => "Combinaison Email/Mot de passe invalide")
        expect(page).to have_selector("div.flash.error", :text => "Combinaison Email/Mot de passe invalide")
	
        end
     end  
    describe "le succès" do

      it "devrait identifier un utilisateur puis le déconnecter" do
        user = FactoryBot.create(:user)
	visit signin_path
	fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
	click_button "Connexion"
        expect(page).to have_title(user.nom)   
	expect(page).to have_selector :link, 'Deconnexion', href: '/signout'  
	expect(page).to have_link("Profil", :href =>user_path(user))
	visit user_path(user)
	click_link "Deconnexion"
        expect(page).to have_current_path('/')
	expect(page).to have_title("Accueil")   
      end
     end
  end
end 		
