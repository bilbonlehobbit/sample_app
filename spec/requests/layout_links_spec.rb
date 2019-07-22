require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
include Capybara::RSpecMatchers 
 describe "GET /layout_links" do

    it "devrait trouver Acceuil a /"  do
      get '/'
      expect(response).to have_http_status(200)
    end
	
    it "devrait trouver Acceuil a /" do
     get '/'
   expect(response).to render_template(:home)
        expect(response.body).to include("Accueil")
        end	

  it "devrait trouver A propos a /about"  do
      get '/about'
      expect(response).to have_http_status(200)
    end

 it "devrait trouver Acceuil a /about" do
     get '/about'
   expect(response).to render_template(:about)
        expect(response.body).to include("A Propos")
    end

  it "devrait trouver Contact a /contact"  do
      get '/contact'
      expect(response).to have_http_status(200)
    end

 it "devrait trouver Acceuil a /contact" do
     get '/contact'
     expect(response).to render_template(:contact)
        expect(response.body).to include("Aide")
    end

  it "devrait trouver Aide a /help"  do
      get '/help'
      expect(response).to have_http_status(200)
    end

 it "devrait trouver Aide a /help" do
     get '/help'
    expect(response).to render_template(:help)
       expect(response.body).to include("Aide")
      expect(response.body).to have_selector("title", visible:false, :text => "Aide")
    end
 it "devrait trouver Inscription a /signup " do
	get '/signup'
        expect(response).to have_http_status(200)
end
 it "devrait trouver Inscription a /signup " do
get '/signup'
expect(response).to render_template(:new)
       expect(response.body).to include("Inscription")
end





  end
end
