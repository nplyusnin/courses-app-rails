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
        redirect_to edit_admin_user_path(@user), notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    end

    private

    def set_user() = @user = User.where.not(role: "admin").find(params[:id])

    def user_params
      params.expect(user: [:email, :role])
    end

    def authenticate_admin!
      redirect_to root_path, alert: "You are not authorized to access this page." if !current_user.admin?
    end
  end
end
