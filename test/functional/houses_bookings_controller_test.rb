require 'test_helper'

class HousesBookingsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => HousesBooking.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    HousesBooking.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    HousesBooking.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to houses_booking_url(assigns(:houses_booking))
  end
  
  def test_edit
    get :edit, :id => HousesBooking.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    HousesBooking.any_instance.stubs(:valid?).returns(false)
    put :update, :id => HousesBooking.first
    assert_template 'edit'
  end
  
  def test_update_valid
    HousesBooking.any_instance.stubs(:valid?).returns(true)
    put :update, :id => HousesBooking.first
    assert_redirected_to houses_booking_url(assigns(:houses_booking))
  end
  
  def test_destroy
    houses_booking = HousesBooking.first
    delete :destroy, :id => houses_booking
    assert_redirected_to houses_bookings_url
    assert !HousesBooking.exists?(houses_booking.id)
  end
end
