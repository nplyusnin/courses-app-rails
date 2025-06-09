# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sign out button", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "allows a user to log out" do
    visit root_path
    click_link I18n.t("devise.sessions.new.sign_out")

    expect(page).not_to have_link(I18n.t("devise.sessions.new.sign_out"))
    expect(page).to have_current_path(new_user_session_path)
  end

  it "redirects to the root path after logging out" do
    visit root_path
    click_link I18n.t("devise.sessions.new.sign_out")

    expect(current_path).to eq(new_user_session_path)
  end
end
