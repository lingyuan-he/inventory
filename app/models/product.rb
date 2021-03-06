class Product < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :items
  has_many :stocks
  has_many :restocks
  has_many :transfers
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :manufacturer_id, presence: true
  validates :unit_price, :numericality => { :greater_than => 0 }
  validates :quantity_sold, :numericality => { :greater_than_or_equal_to => 0 }
  before_destroy :product_used?
  
  def product_used?
    @items = Item.where("product_id = ?", self.id)
    @stocks = Stock.where("product_id = ?", self.id)
    @restocks = Restock.where("product_id = ?", self.id)
    @transfers = Transfer.where("product_id = ?", self.id)
    if @items.empty? == false or @stocks.empty? == false or @restocks.empty? == false or @transfers.empty? == false
      return false
    end
    return true
  end
end

