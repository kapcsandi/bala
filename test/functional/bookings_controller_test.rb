require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Booking.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Booking.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Booking.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to booking_url(assigns(:booking))
  end
  
  def test_edit
    get :edit, :id => Booking.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Booking.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Booking.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Booking.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Booking.first
    assert_redirected_to booking_url(assigns(:booking))
  end
  
  def test_destroy
    booking = Booking.first
    delete :destroy, :id => booking
    assert_redirected_to bookings_url
    assert !Booking.exists?(booking.id)
  end
end
