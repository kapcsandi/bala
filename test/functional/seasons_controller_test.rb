require 'test_helper'

class SeasonsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Season.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Season.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Season.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to season_url(assigns(:season))
  end
  
  def test_edit
    get :edit, :id => Season.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Season.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Season.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Season.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Season.first
    assert_redirected_to season_url(assigns(:season))
  end
  
  def test_destroy
    season = Season.first
    delete :destroy, :id => season
    assert_redirected_to seasons_url
    assert !Season.exists?(season.id)
  end
end
