require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "access root page" do
    it "without user log in" do
      visit root_url
      expect(page).not_to have_content("Products")
    end

    it "signing in the user" do
      visit new_user_session_path	
      fill_in "Email", with: "gowu@mail.com"
      fill_in "Password", with: "gowu12"
      click_button "Log in"
      expect(page).to have_content("Signed in successfully.")
      expect(current_path).to eq root_path
    end
  end
end