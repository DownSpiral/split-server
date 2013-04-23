class ItemController < ApplicationController
  before_filter :after_token_authentication

  def add
    params[:owner] = current_user.id
    Item.add(params)
  end

  def edit
    Item.edit(params)
  end

  def delete
    Item.delete(params)
  end

  def getItems
    result = Item.getItems(current_user.id)
    render :json => {:items => result}
  end

  def acceptShare
    ItemShare.acceptShare(params)
  end

  def getSharedItems
    result = ItemShare.getSharedItems(current_user.id)
    render :json => {:items => result}
  end
end
