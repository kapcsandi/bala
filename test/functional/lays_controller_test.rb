require 'test_helper'

class LaysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Lay.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Lay.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Lay.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lay_url(assigns(:lay))
  end
  
  def test_edit
    get :edit, :id => Lay.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Lay.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Lay.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Lay.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Lay.first
    assert_redirected_to lay_url(assigns(:lay))
  end
  
  def test_destroy
    lay = Lay.first
    delete :destroy, :id => lay
    assert_redirected_to lays_url
    assert !Lay.exists?(lay.id)
  end
end
