class Product < ActiveRecord::Base
  belongs_to :manufacturer
  belongs_to :item
  belongs_to :stock
  belongs_to :restock
  validates :name, presence: true
  validates_uniqueness_of :name, :message => "already exists in the database"
  validates :manufacturer_id, presence: true
  validates :unit_price, :numericality => { :greater_than => 0 }
  validates :quantity_sold, :numericality => { :greater_than_or_equal_to => 0 }
  validates :quantity_left, :numericality => { :greater_than_or_equal_to => 0 }
  validates :archieved, :inclusion => {:in => [true, false]}
end

