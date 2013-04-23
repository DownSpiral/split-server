require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get getFriends" do
    get :getFriends
    assert_response :success
  end

  test "should get getFriendReqs" do
    get :getFriendReqs
    assert_response :success
  end

  test "should get makeFriendReq" do
    get :makeFriendReq
    assert_response :success
  end

  test "should get acceptFriendReq" do
    get :acceptFriendReq
    assert_response :success
  end

end
