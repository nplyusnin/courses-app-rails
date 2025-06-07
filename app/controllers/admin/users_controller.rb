module Admin
  class UsersController < BaseController
    before_action :authenticate_admin!
    before_action :set_user, only: [:edit, :update, :destroy]

    def index      
      @users = User.where.not(role: "admin")
    end

    def edit;end

    def update
      if @user.update(user_params)
        redirect_to edit_admin_user_path(@user), notice: t("notices.admin.user.updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: t("notices.admin.user.destroyed")
    end

    private

    def set_user() = @user = User.where.not(role: "admin").find(params[:id])

    def user_params
      params.expect(user: [:email, :role]).delete_if do |k, v|
        k == :role && User::AVAILABLE_MANAGING_ROLES.exclude?(v)
      end
    end

    def authenticate_admin!
      redirect_to root_path, alert: t("notices.access_denied") if !current_user.admin?
    end
  end
end
