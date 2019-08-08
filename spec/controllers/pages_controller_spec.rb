require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views
  before(:each) do
    @base_title = "Sample App du Tutoriel Ruby on Rails | "
    #@response_httpstatus = expect(response).to have_http_status(:success)
  end

  describe "GET #home" do
    before(:each) do
      get :home
    end
    it "returns http success" do
      @response_httpstatus
    end
    it "doit avoir le bon titre" do
      expect(response.body).to have_title(@base_title + "Accueil")
    end
  end
  describe "GET #contact" do
    before(:each) do
      get :contact

    end
    it "returns http success" do
      @response_httpstatus
    end
    it "doit avoir le bon titre" do
      expect(response.body).to have_title(@base_title + "Contact")
    end
  end

  describe "GET #about" do
    before(:each) do
      get :about

    end
    it "returns http success" do
      @response_httpstatus
    end
    it "doit avoir le bon titre" do
      expect(response.body).to have_title(@base_title + "A Propos")
    end
  end
end
