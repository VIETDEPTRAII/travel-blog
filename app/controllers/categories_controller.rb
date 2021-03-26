class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update]
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'You created a new category successfully'
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'You updated category name successfully'
      redirect_to @category
    else
      render 'edit'
    end
  end

  private

  def require_admin
    unless (logged_in? && current_user.admin?)
      flash[:warning] = 'You do not have permission to create a new category'
      redirect_to categories_path
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
