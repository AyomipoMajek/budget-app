class ExchangesController < ApplicationController
  def new
    @cate = Category.find(params[:cat_id])
    @transaction = Exchange.new
  end

  def create
    @original = Category.find(params[:cat_id])
    @cate = Category.where(name: params[:exchange][:category], author_id: current_user).first
    if @cate.nil?
      flash[:danger] = 'Category not found, create new category'
      redirect_to categories_path
    else
      @transaction = Exchange.new(transaction_params)
      @transaction.author_id = current_user.id
      @transaction.save
      @complete = CategoryExchange.new(exchange_id: @transaction.id, category_id: @cate.id)
      @complete.save
      flash[:success] = 'Transaction created'
      redirect_to category_path(@cate.id)
    end
  end

  private

  def transaction_params
    params.require(:exchange).permit(:name, :amount)
  end
end
