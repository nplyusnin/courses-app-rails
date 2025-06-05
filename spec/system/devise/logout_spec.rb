require "rails_helper"

RSpec.describe "Devise::Logout", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "allows a user to log out" do
    visit root_path
    click_link "Logout"

    expect(page).not_to have_link("Logout")
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(page).to have_current_path(new_user_session_path)
  end

  it "redirects to the root path after logging out" do
    visit root_path
    click_link "Logout"

    expect(current_path).to eq(new_user_session_path)
  end
end