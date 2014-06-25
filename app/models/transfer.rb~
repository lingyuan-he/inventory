class Transfer < ActiveRecord::Base
  has_many :location
  has_one :product
  has_one :employee
  validates :product_id, presence: true
  validates :from_location_id, presence: true
  validates :to_location_id, presence: true
  validates :transfer_staff_id, presence: true
  validates :quantity, :numericality => { :greater_than => 0 }
  validate :product_transfer_okay_in_locations?
  
  def product_transfer_okay_in_locations?
    if self.product_id == nil
      return false
    elsif self.from_location_id == nil
      return false
    elsif self.to_location_id == nil
      return false
    end
    if self.from_location_id == self.to_location_id
      errors.add(:from_location_id, "is the same as destination")
      return false
    end
    @stock_from = Stock.find_by_product_id_and_location_id(self.product_id, self.from_location_id)
    @stock_to = Stock.find_by_product_id_and_location_id(self.product_id, self.to_location_id)
    if @stock_from == nil
      errors.add(:product_id, "does not exist in stock of the origin location")
      return false
    end
    if @stock_to == nil
      errors.add(:product_id, "does not exist in stock of the destination location")
      return false
    end
    if self.quantity == nil
      return false
    elsif @stock_from.quantity_left < self.quantity
      errors.add(:product_id, "quantity is low in the origin location")
      return false
    end
    return true
  end
end
