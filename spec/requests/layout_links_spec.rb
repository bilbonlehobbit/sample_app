require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do

       describe "GET /layout_links" do

        it "devrait trouver Acceuil a /"  do
        get '/'
        expect(response).to have_http_status(200)
        expect(response).to render_template(:home)
        expect(response.body).to include("Accueil")
        end	

       it "devrait trouver A propos a /about"  do
        get '/about'
        expect(response).to have_http_status(200)
	expect(response).to render_template(:about)
        expect(response.body).to include("A Propos")
        end

        it "devrait trouver Contact a /contact"  do
        get '/contact'
        expect(response).to have_http_status(200)
        expect(response).to render_template(:contact)
        expect(response.body).to include("Aide")
        end

	it "devrait trouver Aide a /help"  do
        get '/help'
        expect(response).to have_http_status(200)
        expect(response).to render_template(:help)
        expect(response.body).to include("Aide")
    	end
	
	it "devrait trouver Inscription a /signup " do
	get '/signup'
        expect(response).to have_http_status(200)
	expect(response).to render_template(:new)
        expect(response.body).to include("Inscription")
	end

	it "devrait avoir le bon lien sur le layout" do
        visit root_path
        click_link "A Propos"
        expect(page).to have_selector :link, 'A Propos', href: '/about'
        click_link "Aide"
        expect(page).to have_selector :link, 'Aide', href: '/help'
        click_link "Contact"
        expect(page).to have_selector :link, 'Contact', href: '/contact'
        click_link "Accueil"
        expect(page).to have_selector :link, 'Accueil', href: '/'
        click_link "Inscription"
        expect(page).to have_selector :link, 'Inscription', href: '/signup'

	end
      end

	describe "user non identifie " do

	it "doit avoir un lien de connexion" do 
	visit root_path
	expect(page).to have_link("S'identifier", :href => signin_path)
   end
end

	describe "user identifie" do

	before(:each) do
	@user = FactoryBot.create(:user)
	visit signin_path
	fill_in "Email", :with => @user.email
	fill_in "Password", :with => @user.password
	click_button
	end

	it "devrait avoir un lien de deconnexion" do
	visit root_path
	expect(page).to have_link("Deconnexion", :href => signout_path)
	end
	
	it "doit avoir un lien vers le profil" do
	visit root_path
        expect(page).to have_link("Profil", :href =>user_path(@user))
      end
    end
  end
