require 'test_helper'

class ItemControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get getItems" do
    get :getItems
    assert_response :success
  end

  test "should get getSharedItems" do
    get :getSharedItems
    assert_response :success
  end

end
