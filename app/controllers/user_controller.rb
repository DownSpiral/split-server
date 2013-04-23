class UserController < ApplicationController

  def getMyId
  	render :json => {:id => current_user.id }
  end

  def getFriends
  	result = Friendship.getFriends(current_user.id)
    render :json => {:items => result}
  end

  def makeFriendReq
  	return Friendship.requestFriendship(current_user.id, params[:id])
  end

  def acceptFriendReq
  	Friendship.acceptFriendship(current_user.id, params[:id])
  end
end
