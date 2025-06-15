# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = User.where.not(role: :admin)
      authorize @users
    end

    def edit
      authorize @user
    end

    def update
      authorize @user

      if @user.update(user_params)
        redirect_to admin_users_path, notice: t("notices.admin.users.updated")
      else
        render :edit
      end
    end

    def destroy
      authorize @user
      @user.destroy
      redirect_to admin_users_path, notice: t("notices.admin.users.destroyed")
    end

    private

    def set_user = @user = User.where.not(role: :admin).find(params[:id])

    def user_params
      params.expect(user: %i[email role])
    end
  end
end
