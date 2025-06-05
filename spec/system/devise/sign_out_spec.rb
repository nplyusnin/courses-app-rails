require "rails_helper"

RSpec.describe "Devise::SignOut", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "allows a user to log out" do
    visit root_path
    click_link I18n.t("devise.logout")

    expect(page).not_to have_link("Logout")
    expect(page).to have_content(I18n.t("devise.failure.unauthenticated"))
    expect(page).to have_current_path(new_user_session_path)
  end

  it "redirects to the root path after logging out" do
    visit root_path
    click_link I18n.t("devise.logout")

    sleep 0.1 # Allow time for the logout to process
    expect(current_path).to eq(new_user_session_path)
  end
end