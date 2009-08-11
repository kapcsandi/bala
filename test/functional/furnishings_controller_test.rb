require 'test_helper'

class FurnishingsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Furnishing.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Furnishing.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Furnishing.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to furnishing_url(assigns(:furnishing))
  end
  
  def test_edit
    get :edit, :id => Furnishing.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Furnishing.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Furnishing.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Furnishing.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Furnishing.first
    assert_redirected_to furnishing_url(assigns(:furnishing))
  end
  
  def test_destroy
    furnishing = Furnishing.first
    delete :destroy, :id => furnishing
    assert_redirected_to furnishings_url
    assert !Furnishing.exists?(furnishing.id)
  end
end
