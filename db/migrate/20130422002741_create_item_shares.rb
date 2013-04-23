class CreateItemShares < ActiveRecord::Migration
  def change
    create_table :item_shares do |t|
      t.boolean :accepted
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
