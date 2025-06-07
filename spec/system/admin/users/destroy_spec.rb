require "rails_helper"

RSpec.describe "Admin::Users::Destroy", type: :system do
  let!(:admin) { create(:user, role: :admin) }
  let!(:user) { create(:user) }

  context "when an admin tries to delete a user" do
    before do
      sign_in admin
      visit edit_admin_user_path(user)
    end

    it "deletes the user and redirects to the users index page" do
      click_link I18n.t("resources.users.destroy")
      accept_confirm

      expect(page).to have_current_path(admin_users_path)
      expect(page).to have_content(I18n.t("notices.admin.user.destroyed"))
      expect(User.exists?(user.id)).to be_falsey
    end
  end
end