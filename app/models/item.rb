class Item < ActiveRecord::Base
  belongs_to :purchase
  has_one :product
end
