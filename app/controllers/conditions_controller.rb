class ConditionsController < ApplicationController
  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(params[:condition])
    if @condition.save
      flash[:notice] = "Successfully created condition."
      redirect_to @condition
    else
      render :action => 'new'
    end
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def update
    @condition = Condition.find(params[:id])
    if @condition.update_attributes(params[:condition])
      flash[:notice] = "Successfully updated condition."
      redirect_to @condition
    else
      render :action => 'edit'
    end
  end

  def destroy
    @condition = Condition.find(params[:id])
    @condition.destroy
    flash[:notice] = "Successfully destroyed condition."
    redirect_to conditions_url
  end

end
