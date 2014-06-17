class Item < ActiveRecord::Base
  belongs_to :purchase
  has_one :product
  validates :quantity, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :unit_price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
