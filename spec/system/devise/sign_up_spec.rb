require 'rails_helper'

RSpec.describe "Devise::SignUp", type: :system do
  describe "User sign up" do
    let(:user_attributes) { attributes_for(:user) }

    it "allows a user to register with valid credentials" do
      visit new_user_registration_path

      fill_in "Эл. почта", with: user_attributes[:email]
      fill_in "Пароль", with: user_attributes[:password]
      fill_in "Подтверждение пароля", with: user_attributes[:password_confirmation]

      click_button "Регистрация"

      expect(page).to have_content("Добро пожаловать! Вы успешно зарегистрировались.")
      expect(page).to have_current_path(root_path)
      expect(User.last.email).to eq(user_attributes[:email])
    end
  end
end
