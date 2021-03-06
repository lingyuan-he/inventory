class Transfer < ActiveRecord::Base
  belongs_to :location
  belongs_to :product
  belongs_to :employee
  validates :product_id, presence: true
  validates :from_location_id, presence: true
  validates :to_location_id, presence: true
  validates :transfer_staff_id, presence: true
  validates :quantity, :numericality => { :greater_than => 0 }
  validate :product_transfer_okay_in_locations?
  before_destroy :quantity_left_okay?
  
  def product_transfer_okay_in_locations?
    #upfront protections
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
    elsif @stock_to == nil
      errors.add(:product_id, "does not exist in stock of the destination location")
      return false
    elsif self.quantity == nil
      return false
    elsif @stock_from.quantity_left < self.quantity
      errors.add(:product_id, "quantity is low in the origin location")
      return false
    end
    return true
  end
  
  def quantity_left_okay?
    #check if destory will results in negative value
    @stock_in = Stock.find_by_location_id_and_product_id(self.to_location_id, self.product_id)
    if @stock_in.quantity_left - self.quantity < 0
      return false
    end
    return true
  end
end
