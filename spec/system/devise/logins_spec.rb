require 'rails_helper'

RSpec.describe "Devise::Logins", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "User Logins" do
    it "allows a user to register with valid credentials" do
      user = FactoryBot.create(:user, email: "test@test.ru", password: "password")

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_current_path(root_path)
    end
  end
end
