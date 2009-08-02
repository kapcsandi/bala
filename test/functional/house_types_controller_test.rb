require 'test_helper'

class HouseTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => HouseType.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    HouseType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    HouseType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to house_type_url(assigns(:house_type))
  end
  
  def test_edit
    get :edit, :id => HouseType.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    HouseType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => HouseType.first
    assert_template 'edit'
  end
  
  def test_update_valid
    HouseType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => HouseType.first
    assert_redirected_to house_type_url(assigns(:house_type))
  end
  
  def test_destroy
    house_type = HouseType.first
    delete :destroy, :id => house_type
    assert_redirected_to house_types_url
    assert !HouseType.exists?(house_type.id)
  end
end
