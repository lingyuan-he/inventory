class VendingMachine < ActiveRecord::Base
  belongs_to :location
  has_many :purchases
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :address, presence: true
  validates :stock_location_id, presence: true
  before_destroy :vendingmachine_used?
  
  def vendingmachine_used?
    @purchases = Purchase.where("vending_machine_id = ?", self.id)
    if @purchases.empty? == false
      return false
    end
    return true
  end
end
