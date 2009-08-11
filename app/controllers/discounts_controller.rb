class DiscountsController < ApplicationController
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
      flash[:notice] = "Successfully created discount."
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
      flash[:notice] = "Successfully updated discount."
      redirect_to @discount
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy
    flash[:notice] = "Successfully destroyed discount."
    redirect_to discounts_url
  end
end
