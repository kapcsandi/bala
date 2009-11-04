class DiscountsController < ApplicationController
  before_filter :authorize

  def index
    @discounts = Discount.all
  end
  
  def show
    @discount = Discount.find(params[:id])
  end
  
  def new
    @discount = Discount.new
  end
  
  def create
    @discount = Discount.new(params[:discount])
    if @discount.save
      flash[:notice] = t('admin.successfully_created_discount')
      redirect_to @discount
    else
      render :action => 'new'
    end
  end
  
  def edit
    @discount = Discount.find(params[:id])
  end
  
  def update
    @discount = Discount.find(params[:id])
    if @discount.update_attributes(params[:discount])
      flash[:notice] = t('admin.successfully_updated_discount')
      redirect_to @discount
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy
    flash[:notice] = t('admin.successfully_destroyed_discount')
    redirect_to discounts_path
  end
end
