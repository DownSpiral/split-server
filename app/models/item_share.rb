class ItemShare < ActiveRecord::Base
  attr_accessible :item_id, :user_id, :accepted
  belongs_to :shared_user, :class_name => "User"
  belongs_to :shared_item, :class_name => "Item"

  def self.acceptShare(i_id, u_id)
    sItem = ItemShare.find_by_item_id_and_user_id(i_id, u_id)
    if sItem != nil
  	  sItem.accepted = true
  	  sItem.save!
      return "success"
	  end
    return "Item does not exist"
  end

  def self.getSharedItems(u_id)
    shares = ItemShare.find_all_by_user_id(u_id)
    itemList = []
    if shares != nil
      for s in shares
        i = Item.find_by_id(s.item_id)
        sharing = ItemShare.find_all_by_item_id(i.id)
        numSharing = 1
        for sItem in sharing
          if sItem.accepted
            numSharing += 1
          end
        end
        itemList.push({:id => i.id, :name => i.name, :price => i.price, :numSharing => numSharing, :shared => i.shared, :list => i.list, :owner => i.owner, :shareAccepted => s.accepted})
      end
    end
    return itemList 
  end
end
