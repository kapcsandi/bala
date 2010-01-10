class ContactController < ApplicationController
  def new
    @house = House.find(params[:id])
    @cart = find_cart
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @cart = find_cart
    if @contact.house_id.nil?
      redirect_to root_path
    else
      @house = House.find(@contact.house_id)
      if @contact.valid?
        Notifications.deliver_contact(@contact, @house.code)
        flash[:notice] = t(:contact_sended)
        redirect_to :controller => 'houses', :action => 'show', :id => @house.id
      else
        render :action => :new, :id => @house.id
      end
    end
  end
end
