require 'rails_helper'

RSpec.describe "Devise::Registrations", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "User Registration" do
    it "allows a user to register with valid credentials" do
      visit new_user_registration_path

      fill_in "Email", with: "test@test.ru"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      click_button "Sign up"

      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(page).to have_current_path(root_path)
      expect(User.last.email).to eq("test@test.ru")
    end
  end
end
