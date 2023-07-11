class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[splash]

  def splash; end

  def index
    @categories = Category.where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
    @exchanges = @category.exchanges.order(created_at: :desc)
    @total_amount = @category.exchangess.sum(:amount)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: 'Category was successfully deleted.'
    else
      redirect_to categories_path, notice: 'Retry deleting category.'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
