class TaggablesController < ApplicationController
  # GET /taggables
  # GET /taggables.xml
  def index
    @taggables = Taggable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taggables }
    end
  end

  # GET /taggables/1
  # GET /taggables/1.xml
  def show
    @taggable = Taggable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taggable }
    end
  end

  # GET /taggables/new
  # GET /taggables/new.xml
  def new
    @taggable = Taggable.new
    @taggable.tags.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taggable }
    end
  end

  # GET /taggables/1/edit
  def edit
    @taggable = Taggable.find(params[:id])
    @taggable.tags.build
  end

  # POST /taggables
  # POST /taggables.xml
  def create
    @taggable = Taggable.new(params[:taggable])

    respond_to do |format|
      if @taggable.save
        flash[:notice] = 'Taggable was successfully created.'
        format.html { redirect_to(@taggable) }
        format.xml  { render :xml => @taggable, :status => :created, :location => @taggable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @taggable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taggables/1
  # PUT /taggables/1.xml
  def update
    @taggable = Taggable.find(params[:id])

    respond_to do |format|
      if @taggable.update_attributes(params[:taggable])
        flash[:notice] = 'Taggable was successfully updated.'
        format.html { redirect_to(@taggable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @taggable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taggables/1
  # DELETE /taggables/1.xml
  def destroy
    @taggable = Taggable.find(params[:id])
    @taggable.destroy

    respond_to do |format|
      format.html { redirect_to(taggables_url) }
      format.xml  { head :ok }
    end
  end
end
