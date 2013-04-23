class ItemShare < ActiveRecord::Base
  attr_accessible :item_id, :user_id, :accepted
  belongs_to :shared_user, :class_name => "User"
  belongs_to :shared_item, :class_name => "Item"

  def self.acceptShare(i_id, u_id)
    sItem = ItemShare.find_by_item_id_and_user_id(i_id, u_id)
    if sItem != nil
	  sItem.accepted = true
	  sItem.save!
	end
  end

  def self.getSharedItems(u_id)
    return ItemShare.find_all_by_user_id(u_id)
  end
end
