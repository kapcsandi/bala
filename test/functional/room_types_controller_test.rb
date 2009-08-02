require 'test_helper'

class RoomTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => RoomType.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    RoomType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    RoomType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to room_type_url(assigns(:room_type))
  end
  
  def test_edit
    get :edit, :id => RoomType.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    RoomType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => RoomType.first
    assert_template 'edit'
  end
  
  def test_update_valid
    RoomType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => RoomType.first
    assert_redirected_to room_type_url(assigns(:room_type))
  end
  
  def test_destroy
    room_type = RoomType.first
    delete :destroy, :id => room_type
    assert_redirected_to room_types_url
    assert !RoomType.exists?(room_type.id)
  end
end
