class Item < ActiveRecord::Base
  belongs_to :purchase
  has_one :product
  validates :product_id, presence: true
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }
end
