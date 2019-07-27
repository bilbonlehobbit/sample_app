require 'rails_helper'

RSpec.describe "Users", type: :request do
	

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
end
