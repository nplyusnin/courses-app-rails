require 'rails_helper'

RSpec.describe "Devise::SignIn", type: :system do
  let(:user) { create(:user) }

  describe "User sign in" do
    it "allows a user to register with valid credentials" do
      visit new_user_session_path

      fill_in I18n.t("activerecord.attributes.user.email"), with: user.email
      fill_in I18n.t("activerecord.attributes.user.password"), with: user.password

      click_button I18n.t('devise.sessions.new.sign_in')

      expect(page).to have_content(I18n.t("devise.sessions.signed_in"))
      expect(page).to have_current_path(root_path)
    end
  end
end
