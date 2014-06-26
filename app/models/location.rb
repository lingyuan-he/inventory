class Location < ActiveRecord::Base
  belongs_to :employee
  has_many :stocks
  has_many :restocks
  has_many :transfers
  has_many :vending_machines
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :name, presence: true
  validates :address, presence: true
  validates :manager_id, presence: true
  before_destroy :location_used?
  
  def location_used?
    @restocks = Restock.where("location_id = ?", self.id)
    @transfers = Transfer.where("from_location_id = ? or to_location_id = ?", self.id, self.id)
    @stocks = Stock.where("location_id = ?", self.id)
    @vms = VendingMachine.where("stock_location_id = ?", self.id)
    if @restocks.empty? == false or @transfers.empty? == false or @stocks.empty? == false or @vms.empty? == false
      return false
    end
    return true
  end
end
