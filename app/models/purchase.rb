class Purchase < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :vendingmachine
  accepts_nested_attributes_for :items, :allow_destroy => true, :reject_if => lambda { |a| a[:quantity].blank? or a[:product_id].blank? }
  validates :items, presence: true
  validates :invoice_number, presence: true
  validates_uniqueness_of :invoice_number, :message => "already exists in the database"
  validates :vending_machine_id, presence: true
  validate :stock_location_has_products?
  
  def stock_location_has_products?
    if self.vending_machine_id == nil
      return false
    end
    @location = VendingMachine.find(self.vending_machine_id).stock_location_id
    self.items.each do |item| 
      @stock = Stock.find_by_product_id_and_location_id(item.product_id, @location)
      if @stock == nil
        errors.add(:vending_machine_id, "does not have " + Product.find(item.product_id).name + " in its stocking location " + Location.find(@location).name)
        return false
      end
      if @stock.quantity_left < item.quantity
        errors.add(:vending_machine_id, "does not have enough " + Product.find(item.product_id).name + " in its stocking location " + Location.find(@location).name)
        return false
      end
    end
    return true
  end

end
