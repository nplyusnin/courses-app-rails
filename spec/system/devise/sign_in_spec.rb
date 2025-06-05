require 'rails_helper'

RSpec.describe "Devise::SignIn", type: :system do
  let(:user) { create(:user) }

  describe "User sign in" do
    it "allows a user to register with valid credentials" do
      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_current_path(root_path)
    end
  end
end
