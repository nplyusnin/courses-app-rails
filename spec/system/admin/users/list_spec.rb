require "rails_helper"

RSpec.describe "Admin::Users::List", type: :system do
  let!(:users) { create_list(:user, 2) }

  context "when an admin visits the users list page" do
    let!(:admin) { create(:user, role: :admin) }

    before do
      sign_in admin
      visit admin_users_path
    end

    it "displays the list of users" do
      users.each do |user|
        expect(page).to have_content(user.email)
      end
    end
  end

  context "when a non-admin user visits the users list page" do
    before do
      sign_in users.first
      visit admin_users_path
    end

    it "redirects to the root path with an alert" do
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("You are not authorized to access this page.")
    end
  end
end
