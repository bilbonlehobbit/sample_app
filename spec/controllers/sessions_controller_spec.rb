require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include Capybara::RSpecMatchers
  include Capybara::DSL

  render_views

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it"devrait avoir le bon titre" do
      get :new
      expect(response.body).to have_title("S'identifier")
    end
  end

  describe "Post create" do

    describe "Identification invalide" do

      before(:each) do
        @attr = {:email => "email@example.com", :password =>"invalid"}
      end

      it "devrait revenir(render) a la page new " do
        post :create, params: {:session => @attr}
        expect(response).to render_template('new')
      end

      it "devrait avoir le bon titre" do
        post :create, params: {:session => @attr}
        expect(response.body).to have_title("S'identifier")
      end

      it "devrait avoir un message flash" do
        post :create, params: {:session => @attr}
        expect(flash[:error]).to be =~ /Invalid/i
      end
    end

    describe "Identification valide" do

      before(:each) do
        @user = FactoryBot.create(:user)
        @attr = {:email => @user.email, :password => @user.password}
      end

      it "devrait identifier l'utilisateur" do
        post :create, params: {:session => @attr}
        expect(controller.current_user).to eq(@user)
        expect(controller).to be_signed_in
        #expect(controller.signed_in?).to be_truthy
        #controller.should be_signed_in
      end

      it "devrait rediriger la page vers celle de l'utilisateur" do
        post :create, params: {:session => @attr}
        expect(response).to redirect_to(user_path(@user))
      end
    end
  end
  describe "DELETE destroy " do

    it "devrait deconnecter l'utilisateur" do
      test_sign_in(FactoryBot.create(:user))
      delete :destroy
      #  controller.should_not be_signed_in #version du livre
      expect(controller).not_to be_signed_in
      #expect(controller.signed_in).to be_falsey#autre possibilite a verifier
      expect(response).to redirect_to(root_path)
    end
  end
end
