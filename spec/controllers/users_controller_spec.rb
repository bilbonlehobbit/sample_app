require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	render_views

  describe "GET #new" do
	
	it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
	end
    
	it "devrait avoir le bon titre" do
        get :new
        expect(response.body).to have_title("Inscription")
	end
  end
 
  describe "GET #show" do
   #let(:user) {create :user}
	before(:each) do
    @user = FactoryBot.create(:user)

  end

	it "devrait reussir" do 
	get :show, params: {:id => @user}
	expect(response).to be_successful
	end
	
	it "devrait trouver le bon utilisateur" do
	get :show, params: {:id => @user}
        expect(assigns(:user)).to eq(@user)
	end

	it "devrait avoir le bon titre" do
	get :show, params: {:id => @user}
	expect(response.body).to have_title(@user.nom)
	end

	it "devrait inclure le nom de l'utilisateur" do
	get :show, params: {:id => @user}
	expect(response.body).to have_selector('h1', :text => @user.nom)
	end

	it "devrait avoir une image de profil" do
        get :show, params: {:id => @user}
        expect(response.body).to have_selector("h1>img", :class => "gravatar")
        end
      end
    end
