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
    #let(:user) {FactoryBot.create :user}
    before(:each) do
      @user = FactoryBot.create(:user)
      test_sign_in(@user)
    end
=begin
2eme version posible si pas de test sign_in >>> spec_helper ----> accessible a tous les tests :)
    context 'when user is logged' do

      before(:each) do
       session[:user_id] = @user.id
    end
=end
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
        expect{post :create, params: {:user => @attr}}.not_to change(User, :count)
      end
      it "devrait avoir le bon titre" do
        post :create, params: {:user => @attr}
        expect(response.body).to have_title("Inscription")
      end

      it "devrait rendre la page 'new'" do
        post :create, params: {:user => @attr}
        expect(response).to render_template('new')
      end
    end

    describe "succes du post" do

      before(:each) do
        @attr = {:nom => "User new", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar"}
      end

      it "devrait creer un nouvel utilisateur" do
        expect{post :create, params: {:user => @attr}}.to change(User, :count).by(1)
      end

      it " devrait rediriger l'utilisateur vers sa page" do
        post :create, params: {:user => @attr}
        expect(response).to redirect_to(user_path(assigns(:user)))
      end

      it "devrait avoir un message de bienvenue " do
        post :create, params: {:user => @attr}
        expect(flash[:success]).to be =~ /Bienvenue dans l'Application Exemple/i
      end

      it "devrait identifier l'utilisateur " do
        post :create, params: {:user => @attr}
        expect(controller).to be_signed_in
      end
    end
  end

  describe" GET #edit" do

    before(:each) do
      @user = FactoryBot.create(:user)
      test_sign_in(@user)
    end

    it "devrait trouver la page" do
      get :edit, params: {:id => @user}
      expect(response).to be_successful
    end

    it "devrait avoir le bon titre" do
      get :edit, params: {:id => @user}
      expect(response.body).to have_title("Edition du profil")
    end

    it "devrait avoir un lien pour l'image Gravatar " do
      get :edit, params: {:id => @user}
      #expect(response.body).to have_selector(:css, 'a[href$="gravatar.com/emails"]')
      expect(response.body).to have_link('changer', href: 'http://gravatar.com/emails')
    end
  end

  describe "PUT update" do
    before(:each) do
      @user = FactoryBot.create(:user)
      test_sign_in(@user)
    end

    describe "echec" do

      before(:each) do
        @attr = {:nom => "", :email => "", :password => "", :password_confirmation => "" }
      end

      it "devrait retourner la page d'edition" do
        put :update, params: {:id => @user, :user => @attr}
        expect(response).to render_template('edit')
      end

      it "devrait avoir le bon titre" do
        put :update, params: {:id => @user, :user => @attr}
        expect(response.body).to have_title("Edition du profil")
      end
    end

    describe "reussite" do
      before(:each) do
        @attr = {:nom => "New User", :email => "user@example.com", :password => "boorfa", :password_confirmation => "boorfa" }
      end

      it "devrait modifier les caracteristiques de l'utilisateur" do
        put :update, params: {:id => @user, :user => @attr}
        @user.reload
        expect(@user.nom).to eq(@attr[:nom])
        expect(@user.email).to eq(@attr[:email])
      end

      it "devrait rediriger vers la page de profil" do
        put :update, params: {:id => @user, :user => @attr}
        expect(response).to redirect_to(user_path(@user))
      end

      it "devrait afficher un message flash" do
        put :update, params: {:id => @user, :user => @attr}
        expect(flash[:success]).to be =~ /Profil actualisé/
      end
    end
  end

  describe "authentification des pages edit et update" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    describe "un utillisateur non-identifie" do

      it "devrait refuser l'acces a l'action edit" do
        get :edit, params: {:id => @user}
        expect(response).to redirect_to(signin_path)
      end

      it "devrait refuser l'acces a l'action update" do
        get :edit, params: {:id => @user, :user => {}}
        expect(response).to redirect_to(signin_path)
      end
    end

    describe "un utilisateur identfie" do

      before(:each) do
        wrong_user = FactoryBot.create(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "devrait correspondre a l'utilisateur a editer" do
        get :edit, params: {:id => @user}
        expect(response).to redirect_to(root_path)
      end

      it "devrait correspondre a l'utilisateur a update" do
        put :update, params: {:id => @user, :user => {}}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET index" do

    describe "utilisateur non identifie" do

      it "devrait refuser l'acces" do
        get :index
        expect(response).to redirect_to(signin_path)
        expect(flash[:error]).to eq("Vous devez etre connecté(e)")
      end
    end
    describe "utilisateur identifie" do

      before(:each) do
	 @user = FactoryBot.create(:user)
      test_sign_in(@user)
        second = FactoryBot.create(:user, :email => "user2@example.net")
        third = FactoryBot.create(:user, :email => "user3@example.org")
        @users = [@user, second, third]
	30.times do
	@users << FactoryBot.create(:user, :email => FactoryBot.generate(:email))
      end
    end
      it "devrait accepter l'acces" do
        get :index
        expect(response).to be_successful
      end

      it" devrait avoir le bon titre" do
        get :index
        expect(response.body).to have_title("Liste des utilisateurs")
      end

      it "devrait avoir un element pour chaque utilisateur" do
        get :index
        @users.each do |user|
          expect(response.body).to have_selector('li', :text => user.nom)
        end
      end
       it "devrait avoir un element pour chaque utilisateur" do
	get :index
	@users[0..2].each do |user|
	expect(response.body).to have_selector('li', :text => user.nom)
	end
	end
	it "devrait paginer le utilisateurs" do
	get :index
	expect(response.body).to have_selector('div.pagination')
	expect(response.body).to have_selector('span', :text => "Previous")
	expect(response.body).to have_link('2', :href => "/users?page=2")
	expect(response.body).to have_link('Next', :href => "/users?page=2")     
	end	
      end
    end

	describe "DELETE destroy" do

	before(:each) do
	 @user = FactoryBot.create(:user)
	end

	describe "en tant qu'utilisateur non identifie" do
	
	it "devrait refuser l'acces" do
	 delete :destroy, params: {:id => @user}
	 expect(response).to redirect_to(signin_path)
	end
      end

	describe "en tant qu'utilisateur connecte non admin" do
 
	it "devrait proteger la page" do
	  test_sign_in(@user)
	  delete :destroy, params: {:id => @user}
	 expect(response).to redirect_to(root_path)
	end
      end

	describe "en tant qu'administrateur" do

	before(:each) do
	admin = FactoryBot.create(:user, :email => "admin@example.com", :admin => true)
	test_sign_in(admin)
	end

	it "devrait detruire l'utilisateur" do
	 expect{delete :destroy, params: {:id => @user}}.to change(User, :count).by(-1)
	 end

	it "devrait rediriger vers la page des utilisateurs" do
	  delete :destroy, params: {:id => @user}
	expect(response).to redirect_to(users_path)
	end
     end
  end
end
