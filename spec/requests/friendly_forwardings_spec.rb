require 'rails_helper'

RSpec.describe "FriendlyForwardings", type: :request do
  include Capybara::RSpecMatchers
  include Capybara::DSL
  describe "Friendly_forwarding" do
    
    it "devrait rediriger vers la page voulue apres identification" do
      user = FactoryBot.create(:user)
      visit edit_user_path(user)
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button
      expect(page).to have_current_path(edit_user_path(user))
      #expect(page).to render_template(edit_user_path(user))
    end
  end
end
