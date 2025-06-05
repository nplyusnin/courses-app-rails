require 'rails_helper'

RSpec.describe "Devise::SignUp", type: :system do
  describe "User sign up" do
    let(:user_attributes) { attributes_for(:user) }

    it "allows a user to register with valid credentials" do
      visit new_user_registration_path

      fill_in "Email", with: user_attributes[:email]
      fill_in "Password", with: user_attributes[:password]
      fill_in "Password confirmation", with: user_attributes[:password_confirmation]

      click_button "Sign up"

      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(page).to have_current_path(root_path)
      expect(User.last.email).to eq(user_attributes[:email])
    end
  end
end
