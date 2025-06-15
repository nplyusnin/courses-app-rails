# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin Users", type: :system do
  let!(:admin) { create(:admin) }
  let!(:users) { create_list(:user, 3) }

  before do
    sign_in admin
  end

  describe "Admin visit users page" do
    it "shows the list of users except admin" do
      visit admin_users_path

      users.each do |user|
        expect(page).to have_content(user.email)
      end

      expect(page).not_to have_content(admin.email)
    end
  end

  describe "Admin visit edit user page" do
    let(:user) { users.first }

    before do
      visit edit_admin_user_path(user)
    end

    context "when admin edits a user with valid parameters" do
      let(:valid_user_params) { attributes_for(:user) }

      it "updates the user and redirects to users list" do
        fill_in I18n.t("activerecord.attributes.user.email"), with: valid_user_params[:email]

        click_on(I18n.t("resources.admin.users.update"))

        expect(page).to have_content(I18n.t("notices.admin.users.updated"))
        expect(page).to have_content(valid_user_params[:email])
        expect(user.reload.email).to eq(valid_user_params[:email])
      end
    end

    context "when admin edits a user with invalid parameters" do
      let(:invalid_user_params) { attributes_for(:user, email: "") }

      it "shows an error message" do
        fill_in I18n.t("activerecord.attributes.user.email"), with: invalid_user_params[:email]

        click_on(I18n.t("resources.admin.users.update"))

        expect(page).to have_content(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "Admin delete user" do
    let(:user) { users.first }

    it "deletes the user and redirects to users list" do
      visit edit_admin_user_path(user)

      click_link I18n.t("resources.admin.users.destroy")

      expect(page).to have_current_path(admin_users_path)
      expect(page).not_to have_content(user.email)
    end
  end
end
