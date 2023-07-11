class ExchangesController < ApplicationController
  def new
    @cate = Category.find(params[:cat_id])
    @transaction = Exchange.new
  end

  def create
    @original = Category.find(params[:cat_id])
    @cate = Category.find(params[:exchange][:category], user_id: current_user).first
    @transaction = Exchange.new(exchange_params)
    @transaction.user_id = current_user.id
    if @cate.nil?
      flash[:danger] = 'Category not found, create new category'
      redirect_to category_path
    elsif @transaction.save
      flash[:success] = 'Transaction created'
      redirect_to category_path(@cate.id)
      @complete = Category.find(exchange_id: @transaction.id, catgory_id: @cate.id)
      @complete.save
    else
      render 'new'
    end

    private

  def transaction_params
    params.require(:exchange).permit(:name, :amount)
  end
end
