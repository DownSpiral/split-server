class List < ActiveRecord::Base
  belongs_to :owner
  attr_accessible :name
end
