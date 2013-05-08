class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price, :quantity, :list, :owner, :shared
  belongs_to :user
  has_many :shared_users, :foreign_key => "shared_item_id", :through => :item_shares

  def self.add(params)
    item = Item.create(params.slice(:owner, :name, :description, :quantity, :price, :list, :shared))
  	item.save!

  	if item.shared == true
      friends = eval(params[:shareFriends])
  	  for p in friends
  		  sharedItem = ItemShare.create(:user_id => p, :item_id => item.id, :accepted => false)
  		  sharedItem.save!
  	  end
  	end
    return item
  end

  def self.edit(params)
    item = Item.find_by_id(params[:id])
    if item == nil
      return "Item does not exist"
    end
    item.name = params[:name]
    item.price = params[:price]
    item.description = params[:description]
    item.quantity = params[:quantity]
    item.list = params[:list]
    #If the item was shared and no longer is shared delete all the shared items
    if item.shared and not params[:shared]
      items = ItemShare.find_all_by_item_id(params[:id])
      for i in items
        i.destroy
      end
    end
    #If the item was not shared and the user wants to share it add the shared items
    if not item.shared and params[:shared]
      for p in params[:shareFriends]
        sharedItem = ItemShare.create(:user_id => p, :item_id => item.id, :accepted => false)
        sharedItem.save!
      end
    end
    item.shared = params[:shared]
    item.save!   
    return "success"
  end

  def self.delete(params)
    itemId = Integer(params[:id])
    item = Item.find_by_id(itemId)
    if item != nil
      sItems = ItemShare.find_all_by_item_id(itemId)
      if sItems != nil
    		for i in sItems
    		  i.destroy
    		end
	    end
	    item.destroy
      return "success"
    end
    return "Item does not exist"
  end

  def self.getItems(id)
    items = Item.find_all_by_owner(id)
    itemList = []
    if items != nil
      for i in items
        pplSharing = ItemShare.find_all_by_item_id(i.id)
        itemList.push({:id => i.id, :name => i.name, :price => i.price, :pplSharing => pplSharing, :shared => i.shared, :list => i.list, :owner => i.owner})
      end
    end
    return itemList
  end
end
