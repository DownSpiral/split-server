class ItemController < ApplicationController

  def add
    params[:owner] = current_user.id
    result = Item.add(params)
    render :json => result
  end

  def edit
    result = Item.edit(params)
    render :json => {:status => result}
  end

  def delete
    result = Item.delete(params)
    render :json => {:status => result}
  end

  def getItems
    result = Item.getItems(current_user.id)
    render :json => {:items => result}
  end

  def acceptShare
    result = ItemShare.acceptShare(params[:item],current_user.id)
    render :json => {:status => result}
  end

  def getSharedItems
    result = ItemShare.getSharedItems(current_user.id)
    render :json => {:items => result}
  end
end
