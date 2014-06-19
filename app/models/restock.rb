class Restock < ActiveRecord::Base
  has_one :product
  has_one :location
  has_one :employee
  validates :product_id, presence: true
  validates :location_id, presence: true
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :restock_staff_id, presence: true
end
