class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You created your account successfully'
      redirect_to :articles
    else
      render 'users/new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'You updated your account successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
