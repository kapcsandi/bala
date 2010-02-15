class ContactController < ApplicationController
#  protect_from_forgery :only => [:create]

  def new
    @house = House.find(params[:id]) if params[:id]
    @cart = find_cart
    @contact = Contact.new
  end

  def index
    redirect_to new_contact_path
  end

  def create
    @contact = Contact.new(params[:contact])
    @cart = find_cart
    if @contact.house_id
      @house = House.find(@contact.house_id)
      if @contact.valid?
        Notifications.deliver_contact(@contact, @house.code)
        flash[:notice] = t(:contact_sended)
        redirect_to :controller => 'houses', :action => 'show', :id => @house.id
      else
        render :action => :new, :id => @house.id
      end
    else
      if @contact.valid?
        Notifications.deliver_contact(@contact, nil)
        flash[:notice] = t(:contact_sended)
        redirect_to :controller => 'houses', :action => 'index'
      else
        render :action => :new
      end
    end
  end
end
