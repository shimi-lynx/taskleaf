class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      flash.now[:notice] = "#{@user.errors.full_messages}"
      render :new_admin_user
    end
  end

  def edit
  end

  def show
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
end
