require "rails_helper"

RSpec.describe "Admin::Users::Edit", type: :system do
  let!(:admin) { create(:user, role: :admin) }
  let!(:user) { create(:user) }

  context "when an admin tries update a user with valid parameters" do
    let(:valid_user_params) { attributes_for(:user) }

    before do
      sign_in admin
      visit edit_admin_user_path(user)
    end

    it "updates the user and redirects to the user's show page" do
      fill_in I18n.t("activerecord.attributes.user.email"), with: valid_user_params[:email]
      click_button "Update User"

      expect(page).to have_current_path(edit_admin_user_path(user))
      expect(page).to have_content("User updated successfully.")
      expect(user.reload.email).to eq(valid_user_params[:email])
    end
  end

  context "when an admin tries to update a user with invalid parameters" do
    let(:invalid_user_params) { attributes_for(:user, email: "") }

    before do
      sign_in admin
      visit edit_admin_user_path(user)
    end

    it "does not update the user and re-renders the edit page" do
      fill_in I18n.t("activerecord.attributes.user.email"), with: invalid_user_params[:email]
      click_button "Update User"

      expect(page).to have_current_path(edit_admin_user_path(user))
      expect(user.reload.email).not_to eq(invalid_user_params[:email])
    end
  end
end