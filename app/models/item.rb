class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price, :quantity, :list
  belongs_to :user
  has_many :shared_users, :foreign_key => "shared_item_id", :through => :item_shares

  def self.add(params)
    @item = Item.create(params.slice(:owner, :name, :description, :quantity, :price))
  	@item.save!

  	if params[:shared]
  	  for p in params[:shareFriends]
  		@sharedItem = ItemShared.create(:user_id => p, :item_id => @item.id, :accepted => false)
  		@sharedItem.save!
  	  end
  	end
  end

  def self.edit(params)
    item = Item.find_by_id(params[:id])
    item.name = params[:name]
    item.price = params[:price]
    item.description = params[:description]
    item.quantity = params[:quantity]
    item.list = params[:list]
    item.save!
  end

  def self.delete(params)
    item = Item.find_by_id(params[:id])
    if item != nil
      sItems = ItemShared.find_by_item_id(params[id])
      if sItems != nil
		for i in sItems
		  i.destroy	
		end
	  end
	item.destroy
    end
  end

  def self.getItems(id)
    return Item.find_all_by_owner(id)
  end

end
