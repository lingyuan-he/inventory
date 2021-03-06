class Restock < ActiveRecord::Base
  belongs_to :product
  belongs_to :location
  belongs_to :employee
  validates :product_id, presence: true
  validates :location_id, presence: true
  validate :product_location_combination_exists?
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }
  validates :restock_staff_id, presence: true
  before_destroy :quantity_left_okay?
  
  def product_location_combination_exists?
    if Stock.find_by_product_id_and_location_id(self.product_id, self.location_id) == nil
      errors.add(:product_id, "and location combination does not exist in stock")
      return false
    else
      return true
    end
  end
  
  def quantity_left_okay?
    @stock = Stock.find_by_location_id_and_product_id(self.location_id, self.product_id)
    if @stock.quantity_left - self.quantity < 0
      return false
    end
    return true
  end
end
