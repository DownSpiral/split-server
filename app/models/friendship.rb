class Friendship < ActiveRecord::Base
  attr_accessible :user1_id, :user2_id, :accepted
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'

  def self.requestFriendship(my_id, their_id)
  	f = Friendship.find_by_user1_id_and_user2_id(my_id, their_id)
  	if f == nil
  		f = Friendship.find_by_user1_id_and_user2_id(their_id, my_id)
  	end

  	if f == nil
  		Friendship.create(:user1_id => my_id, :user2_id => their_id, :accepted => false)
  		return true
  	end
  	return false 
  end

  def self.acceptFriendship(my_id, their_id)
    f = Friendship.find_by_user1_id_and_user2_id(my_id, their_id)

    if f == nil
      f = Friendship.find_by_user1_id_and_user2_id(their_id, my_id)
    end

    if f != nil
	  f.accepted = true
	  sItem.save!
	end
  end

  def self.getFriends(u_id)
    return Friendship.where("user1_id = ? OR user2_id = ?", u_id, u_id)
  end
end
