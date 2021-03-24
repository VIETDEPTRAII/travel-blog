class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Travel Blog #{@user.username}. You created your account successfully"
      redirect_to @user
    else
      render 'users/new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'You updated your account successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    flash[:success] = 'You have deleted your account with articles'
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def require_same_user
    if current_user != @user
      flash[:warning] = 'You can only edit your own account!'
      redirect_to @user
    end
  end
end
