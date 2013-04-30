class AddSharedToItem < ActiveRecord::Migration
  def change
    add_column :items, :shared, :boolean
  end
end
