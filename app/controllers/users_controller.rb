class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]

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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
