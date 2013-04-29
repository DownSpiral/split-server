class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :token_authenticatable
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :items
  has_many :shared_items, :foreign_key => "shared_user_id", :through => :item_shares
end
