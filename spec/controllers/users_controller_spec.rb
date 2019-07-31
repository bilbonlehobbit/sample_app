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

	it "devrait avoir un champ nom" do
		get :new
		expect(response.body).to have_selector("input[name='user[nom]'][type='text'][id='user_nom']")
	end
	
	it "devrait avoir un champs e-mail" do
		get :new
		expect(response.body).to have_selector("input[name='user[email]'][type='text'][id='user_email']")
	end
	
	it "devrait avoir un champs password" do
		get :new
		expect(response.body).to have_selector("input[name='user[password]'][type='password'][id='user_password']")
	end

	it "devrait avoir un champs confirmation" do
		get :new
		expect(response.body).to have_selector("input[name='user[password_confirmation]'][type='password'][id='user_password_confirmation']")
	end
	
	it "devrait avoit un bouton d'inscription" do
		get :new
		expect(response.body).to have_selector("input[name='commit'][type='submit'][value='Inscription']")
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
  
  describe "Post create" do
    
     describe "echec du post" do

	before(:each) do
	@attr = {:nom => "", :email => "", :password => "", :password_confirmation => ""}
	end

	it "ne doit pas creer d'utilisateur" do 
	#expect{(post :create, :user => @attr).not_to change(User, :count)}
	expect{post :create, params:{:user => @attr}}.not_to change(User, :count)
	end
        it "devrait avoir le bon titre" do
        post :create, params:{:user => @attr}
        expect(response.body).to have_title("Inscription")
        end

        it "devrait rendre la page 'new'" do
        post :create, params:{:user => @attr}
        expect(response).to render_template('new')
        end
      end

     describe "succes du post" do

	before(:each) do
        @attr = {:nom => "User new", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar"}	
	end
	
	it "devrait creer un nouvel utilisateur" do
        expect{post :create, params:{:user => @attr}}.to change(User, :count).by(1)
	end

	it " devrait rediriger l'utilisateur vers sa page" do
	post :create, params:{:user => @attr}    
        expect(response).to redirect_to(user_path(assigns(:user)))
	end

	it "devrait avoir un message de bienvenue " do
	post :create, params:{:user => @attr}
        expect(flash[:success]).to be =~ /Bienvenue dans l'Application Exemple/i
        end 

	it "devrait identifier l'utilisateur " do
	post :create, params:{:user => @attr}
	expect(controller).to be_signed_in
	end

      end
   end
end
