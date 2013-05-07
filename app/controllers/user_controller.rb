class UserController < ApplicationController
  respond_to :json
  def getMyId
  	render :json => {:id => current_user.id }
  end

  def getFriends
  	result = Friendship.getFriends(current_user.id)
    render :json => {:friends => result}
  end

  def makeFriendReq
  	result = Friendship.requestFriendship(current_user.id, params[:email])
    render :json => {:status => result}
  end

  def removeFriend
    result = Friendship.deleteFriendship(current_user.id, params[:friend_id])
    render :json => {:status => result}
  end

  def acceptFriendReq
  	result = Friendship.acceptFriendship(current_user.id, params[:email])
    render :json => {:status => result}
  end
end
