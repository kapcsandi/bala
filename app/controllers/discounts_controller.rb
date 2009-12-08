class DiscountsController < ApplicationController
  before_filter :authorize
  before_filter :search_discount, :except => [:index, :new, :create]

  def index
    @discounts = Discount.all
  end

  def show
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
  end

  def update
    if @discount.update_attributes(params[:discount])
      flash[:notice] = t('admin.successfully_updated_discount')
      redirect_to @discount
    else
      render :action => 'edit'
    end
  end

  def destroy
    @discount.destroy
    flash[:notice] = t('admin.successfully_destroyed_discount')
    redirect_to discounts_path
  end

  private

  def seach_discount
    @discount = Discount.find(params[:id])
  end
end
