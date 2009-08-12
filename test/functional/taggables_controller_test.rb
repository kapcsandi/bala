require 'test_helper'

class TaggablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taggables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taggable" do
    assert_difference('Taggable.count') do
      post :create, :taggable => { }
    end

    assert_redirected_to taggable_path(assigns(:taggable))
  end

  test "should show taggable" do
    get :show, :id => taggables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => taggables(:one).to_param
    assert_response :success
  end

  test "should update taggable" do
    put :update, :id => taggables(:one).to_param, :taggable => { }
    assert_redirected_to taggable_path(assigns(:taggable))
  end

  test "should destroy taggable" do
    assert_difference('Taggable.count', -1) do
      delete :destroy, :id => taggables(:one).to_param
    end

    assert_redirected_to taggables_path
  end
end
