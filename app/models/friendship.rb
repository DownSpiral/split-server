class Friendship < ActiveRecord::Base
  attr_accessible :user1_id, :user2_id, :accepted
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'

  def self.requestFriendship(my_id, their_email)
    user = User.find_by_email(their_email)
    if user == nil
      return "User does not exist"
    end
    their_id = user.id
  	f = Friendship.find_by_user1_id_and_user2_id(my_id, their_id)
  	if f == nil
  		f = Friendship.find_by_user1_id_and_user2_id(their_id, my_id)
      if f == nil
        Friendship.create(:user1_id => my_id, :user2_id => their_id, :accepted => false)
        return {:id => their_id, :name => user.name, :email => user.email}
      end
    else
      if f.accepted
        return "Already friends"
      else
  	    return "Already requested to be friends"
      end      
    end
    return "success"
  end

  def self.acceptFriendship(my_id, their_email)
    user = User.find_by_email(their_email)
    if user == nil
      return "User does not exist"
    end
    their_id = user.id
    f = Friendship.find_by_user1_id_and_user2_id(my_id, their_id)
    if f == nil
      f = Friendship.find_by_user1_id_and_user2_id(their_id, my_id)
    end

    if f != nil
  	  f.accepted = true
  	  f.save!
      return "success"
    else
      return "No friend request exists"
	  end
  end

  def self.deleteFriendship(my_id, their_id)
    f = Friendship.find_by_user1_id_and_user2_id(my_id, their_id)
    if f == nil
      f = Friendship.find_by_user1_id_and_user2_id(their_id, my_id)
    end

    if f != nil
      f.destroy
      return "Friendship DESTROYED!"
    end
    return "You have no friend with id: " + their_id
  end

  def self.getFriends(u_id)
    friends = Friendship.where("user1_id = ? OR user2_id = ?", u_id, u_id)
    if friends == nil
      return "No friends exist"
    end
    data = []
    for f in friends
      id = nil
      if f.user1_id == u_id
        id = f.user2_id
      else
        id = f.user1_id
      end
      if id != nil
        fr = User.find_by_id(id)
        if f.user1_id == u_id
          data.push({:id => fr.id, :name => fr.name, :email => fr.email, :accepted => f.accepted, :asker => "me"})
        else 
          if f.user2_id == u_id
            data.push({:id => fr.id, :name => fr.name, :email => fr.email, :accepted => f.accepted, :asker => "them"})
          end
        end
      end
    end
    return data
  end
end
