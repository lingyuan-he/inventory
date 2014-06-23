class Restock < ActiveRecord::Base
  has_one :product
  has_one :location
  has_one :employee
  validates :product_id, presence: true
  validates :location_id, presence: true
  validate :product_location_combination?
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :restock_staff_id, presence: true
  
  def product_location_combination?
    if Stock.find_by_product_id_and_location_id(self.product_id, self.location_id) == nil
      errors.add(:product_id, "and location combination does not exist in stock")
      return false
    else
      return true
    end
  end
end
