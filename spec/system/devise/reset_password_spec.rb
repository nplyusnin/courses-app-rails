# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Reset password forms", type: :system do
  let(:user) { create(:user) }

  describe "Password reset request" do
    it "allows a user to send instructions to reset password" do
      visit new_user_password_path

      fill_in I18n.t("activerecord.attributes.user.email"), with: user.email

      click_button I18n.t("devise.passwords.new.send_me_reset_password_instructions")

      expect(page).to have_content(I18n.t("devise.passwords.send_instructions"))
    end
  end

  describe "Password reset" do
    it "allows a user to reset password with valid credentials" do
      reset_password_token = user.send_reset_password_instructions

      visit edit_user_password_path(user, reset_password_token:)

      fill_in I18n.t("devise.passwords.edit.new_password"), with: user.password
      fill_in I18n.t("devise.passwords.edit.confirm_new_password"), with: user.password_confirmation

      click_button I18n.t("devise.passwords.edit.change_my_password")

      expect(page).to have_content(I18n.t("devise.passwords.updated"))
      expect(page).to have_current_path(root_path)
    end
  end
end
