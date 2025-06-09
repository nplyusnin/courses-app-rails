# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sign up form", type: :system do
  let(:user_attributes) { attributes_for(:user) }

  it "allows a guest to register with valid credentials" do
    visit new_user_registration_path

    fill_in I18n.t("activerecord.attributes.user.email"), with: user_attributes[:email]
    fill_in I18n.t("activerecord.attributes.user.password"), with: user_attributes[:password]
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), with: user_attributes[:password_confirmation]

    click_button I18n.t("devise.registrations.new.sign_up")

    expect(page).to have_content(I18n.t("devise.registrations.signed_up"))
    expect(page).to have_current_path(root_path)
    expect(User.last.email).to eq(user_attributes[:email])
  end
end
